import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/display_config_provider.dart';
import '../providers/widget_provider.dart';
import '../providers/saved_schedules_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets/table_theme_dialog.dart';

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

          // Schedule Table Section
          _buildSectionHeader(context, 'Schedule Table'),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Table Theme'),
            subtitle: const Text('Colors, borders, background, and more'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => showTableThemeDialog(context),
          ),

          const Divider(),

          // Widget Section
          _buildSectionHeader(context, 'Home Screen Widget'),
          _buildWidgetSection(context),

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

  Widget _buildWidgetSection(BuildContext context) {
    final widgetProvider = context.watch<WidgetProvider>();
    final schedulesProvider = context.watch<SavedSchedulesProvider>();

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.widgets),
          title: const Text('Active Schedule for Widget'),
          subtitle: Text(
            widgetProvider.activeScheduleId != null &&
                    schedulesProvider.schedules.isNotEmpty
                ? schedulesProvider.schedules
                      .firstWhere(
                        (s) => s.id == widgetProvider.activeScheduleId,
                        orElse: () => schedulesProvider.schedules.first,
                      )
                      .name
                : 'No schedule selected',
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => _showScheduleSelector(context),
        ),
        SwitchListTile(
          secondary: const Icon(Icons.refresh),
          title: const Text('Auto-Update Widget'),
          subtitle: const Text(
            'Automatically update widget when schedule changes',
          ),
          value: widgetProvider.autoUpdate,
          onChanged: (value) {
            widgetProvider.setAutoUpdate(value);
          },
        ),
        ListTile(
          leading: widgetProvider.isUpdating
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.update),
          title: const Text('Update Widget Now'),
          subtitle: const Text('Manually refresh the home screen widget'),
          enabled: !widgetProvider.isUpdating,
          onTap: () async {
            final schedule = widgetProvider.activeScheduleId != null
                ? schedulesProvider.schedules.firstWhere(
                    (s) => s.id == widgetProvider.activeScheduleId,
                    orElse: () => schedulesProvider.schedules.first,
                  )
                : null;

            await widgetProvider.refreshWidget(schedule);

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Widget updated'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Note: After adding the widget to your home screen, it will show today\'s classes from the selected schedule.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }

  void _showScheduleSelector(BuildContext context) {
    final schedulesProvider = context.read<SavedSchedulesProvider>();
    final widgetProvider = context.read<WidgetProvider>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Schedule for Widget'),
        content: SizedBox(
          width: double.maxFinite,
          child: schedulesProvider.schedules.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'No schedules available. Create a schedule first.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: schedulesProvider.schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = schedulesProvider.schedules[index];
                    final isSelected =
                        widgetProvider.activeScheduleId == schedule.id;

                    return ListTile(
                      leading: Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                      title: Text(schedule.name),
                      subtitle: Text(
                        schedule.semester ?? 'No semester',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      selected: isSelected,
                      onTap: () async {
                        await widgetProvider.setActiveSchedule(schedule);
                        if (context.mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Widget will show "${schedule.name}"',
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
