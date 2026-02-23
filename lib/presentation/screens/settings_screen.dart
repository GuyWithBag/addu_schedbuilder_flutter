import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/display_config_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Settings screen for app configuration
class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();
    final packageInfo = useFuture(PackageInfo.fromPlatform());

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            secondary: Icon(
              displayConfig.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            value: displayConfig.isDarkMode,
            onChanged: (value) {
              displayConfig.toggleDarkMode();
            },
          ),
          SwitchListTile(
            title: const Text('24-Hour Format'),
            subtitle: const Text('Display time in 24-hour format'),
            secondary: const Icon(Icons.access_time),
            value: displayConfig.is24HourFormat,
            onChanged: (value) {
              displayConfig.toggle24HourFormat();
            },
          ),

          const Divider(),

          // About Section
          _buildSectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('App Version'),
            subtitle: Text(packageInfo.data?.version ?? 'Loading...'),
          ),
          ListTile(
            leading: const Icon(Icons.build_outlined),
            title: const Text('Build Number'),
            subtitle: Text(packageInfo.data?.buildNumber ?? 'Loading...'),
          ),
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text('SchedBuilder'),
            subtitle: const Text('A smart schedule builder for students'),
            onTap: () {
              _showAboutDialog(context, packageInfo.data);
            },
          ),

          const Divider(),

          // Data Section
          _buildSectionHeader(context, 'Data'),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Clear All Data'),
            subtitle: const Text('Delete all saved schedules'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () => _showClearDataDialog(context),
          ),

          const SizedBox(height: 24),

          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Made with ❤️ for students',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context, PackageInfo? packageInfo) {
    showAboutDialog(
      context: context,
      applicationName: 'SchedBuilder',
      applicationVersion: packageInfo?.version ?? '1.0.0',
      applicationLegalese: '© 2024 SchedBuilder\nMIT License',
      applicationIcon: const FlutterLogo(size: 64),
      children: [
        const SizedBox(height: 16),
        const Text(
          'SchedBuilder helps students parse, visualize, and manage their class schedules with ease.',
        ),
        const SizedBox(height: 8),
        const Text(
          'Features:\n'
          '• Parse schedule text automatically\n'
          '• Visual weekly grid view\n'
          '• Save multiple schedules\n'
          '• Export to PDF, PNG, and Calendar\n'
          '• Conflict detection\n'
          '• Dark mode support',
        ),
      ],
    );
  }

  void _showClearDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all your saved schedules. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              // TODO: Implement clear data functionality
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data clearing not yet implemented'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );
  }
}
