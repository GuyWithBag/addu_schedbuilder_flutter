import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/display_config_provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/save_schedule_dialog.dart';
import '../widgets/schedule_table_widget.dart';

/// Screen for inputting and parsing schedule text
class InputScreen extends HookWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final textController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SchedBuilder'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<DisplayConfigProvider>().toggleDarkMode();
            },
            tooltip: 'Toggle dark mode',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input field
            TextField(
              controller: textController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Paste Schedule Text',
                hintText:
                    'CS101 Computer Science Intro * 8:00 AM - 9:30 AM Room 204 M W F * DOE, JOHN john@example.com 3',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                scheduleProvider.updateInput(value);
              },
            ),

            const SizedBox(height: 16),

            // Parse button
            ElevatedButton.icon(
              onPressed: scheduleProvider.isLoading
                  ? null
                  : () {
                      scheduleProvider.parseAndArrange();
                    },
              icon: scheduleProvider.isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(
                scheduleProvider.isLoading ? 'Parsing...' : 'Parse Schedule',
              ),
            ),

            const SizedBox(height: 16),

            // Results
            Expanded(child: _buildResults(context, scheduleProvider)),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context, ScheduleProvider provider) {
    final parseResult = provider.parseResult;
    final scheduleTable = provider.scheduleTable;

    if (parseResult == null) {
      return const Center(
        child: Text(
          'Enter schedule text and tap Parse',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (!parseResult.isSuccess) {
      return SingleChildScrollView(
        child: Card(
          color: Colors.red.shade50,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 8),
                    SelectableText(
                      'Parsing Errors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ...parseResult.errors!.map(
                  (error) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: SelectableText('• $error'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (scheduleTable == null || scheduleTable.isEmpty) {
      return const Center(child: Text('No schedule to display'));
    }

    // Success! Show schedule table
    final classes = scheduleTable.getAllClasses();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success banner with save button
          Card(
            color: Colors.green.shade50,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Successfully parsed ${classes.length} classes!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    onPressed: () => _showSaveDialog(context),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
          // Schedule Table
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Schedule',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  ScheduleTableWidget(table: scheduleTable),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => SaveScheduleDialog(
        onSave: (name, semester) async {
          final scheduleProvider = context.read<ScheduleProvider>();
          final savedSchedulesProvider = context.read<SavedSchedulesProvider>();
          final displayConfigProvider = context.read<DisplayConfigProvider>();

          final scheduleTable = scheduleProvider.scheduleTable;
          if (scheduleTable == null) return;

          try {
            await savedSchedulesProvider.saveSchedule(
              name,
              scheduleTable,
              semester,
              displayConfigProvider.classColors,
            );

            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Schedule "$name" saved successfully!'),
                  behavior: SnackBarBehavior.floating,
                  action: SnackBarAction(
                    label: 'View',
                    onPressed: () {
                      // TODO: Navigate to saved schedules screen
                    },
                  ),
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving schedule: $e'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          }
        },
      ),
    );
  }
}
