import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/table_theme_provider.dart';
import '../providers/display_config_provider.dart';
import '../../domain/models/table_theme.dart';

/// Screen for managing saved table themes
class TableThemesScreen extends HookWidget {
  const TableThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<TableThemeProvider>();
    final displayConfig = context.read<DisplayConfigProvider>();
    final themes = themeProvider.themes;

    useEffect(() {
      themeProvider.loadThemes();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Table Themes'),
        actions: [
          if (themes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Delete all themes',
              onPressed: () => _showDeleteAllDialog(context, themeProvider),
            ),
        ],
      ),
      body: themeProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : themes.isEmpty
          ? _buildEmptyState(context)
          : _buildThemesList(context, themes, themeProvider, displayConfig),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.palette_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved themes',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save your table customizations\nfrom the Settings screen',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildThemesList(
    BuildContext context,
    List<TableTheme> themes,
    TableThemeProvider themeProvider,
    DisplayConfigProvider displayConfig,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: themes.length,
      itemBuilder: (context, index) {
        final theme = themes[index];
        return _buildThemeCard(context, theme, themeProvider, displayConfig);
      },
    );
  }

  Widget _buildThemeCard(
    BuildContext context,
    TableTheme theme,
    TableThemeProvider themeProvider,
    DisplayConfigProvider displayConfig,
  ) {
    final borderColor = Color.fromARGB(
      theme.tableBorderColor.alpha,
      theme.tableBorderColor.red,
      theme.tableBorderColor.green,
      theme.tableBorderColor.blue,
    );

    final backgroundColor = Color.fromARGB(
      theme.tableBackgroundColor.alpha,
      theme.tableBackgroundColor.red,
      theme.tableBackgroundColor.green,
      theme.tableBackgroundColor.blue,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _applyTheme(context, theme, themeProvider, displayConfig),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      theme.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () =>
                        _showDeleteDialog(context, theme, themeProvider),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Created: ${_formatDate(theme.createdAt)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              const SizedBox(height: 12),
              // Color preview
              Row(
                children: [
                  _buildColorPreview(context, 'Border', borderColor),
                  const SizedBox(width: 16),
                  _buildColorPreview(context, 'Background', backgroundColor),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Radius',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        '${theme.cornerRadius.toStringAsFixed(0)}px',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  FilledButton.icon(
                    onPressed: () => _applyTheme(
                      context,
                      theme,
                      themeProvider,
                      displayConfig,
                    ),
                    icon: const Icon(Icons.brush, size: 18),
                    label: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorPreview(BuildContext context, String label, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 4),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  void _applyTheme(
    BuildContext context,
    TableTheme theme,
    TableThemeProvider themeProvider,
    DisplayConfigProvider displayConfig,
  ) {
    themeProvider.applyTheme(theme, displayConfig);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Applied theme: ${theme.name}'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    TableTheme theme,
    TableThemeProvider themeProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Theme?'),
        content: Text('Are you sure you want to delete "${theme.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await themeProvider.deleteTheme(theme.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Theme deleted'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAllDialog(
    BuildContext context,
    TableThemeProvider themeProvider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Themes?'),
        content: const Text(
          'Are you sure you want to delete all saved themes? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await themeProvider.deleteAllThemes();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All themes deleted'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}
