import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/schedule_provider.dart';
import '../widgets/saved_schedule_card.dart';

/// Screen displaying all saved schedules
class SavedSchedulesScreen extends HookWidget {
  const SavedSchedulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final savedSchedulesProvider = context.watch<SavedSchedulesProvider>();
    final schedules = savedSchedulesProvider.schedules;
    final isLoading = savedSchedulesProvider.isLoading;

    // Load schedules on first build
    useEffect(() {
      savedSchedulesProvider.loadSchedules();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Schedules'),
        actions: [
          if (schedules.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list),
              tooltip: 'Filter by semester',
              onSelected: (semester) {
                // TODO: Implement semester filtering
              },
              itemBuilder: (context) {
                final semesters = savedSchedulesProvider.getUniqueSemesters();
                return [
                  const PopupMenuItem(value: '', child: Text('All Semesters')),
                  ...semesters.map(
                    (semester) =>
                        PopupMenuItem(value: semester, child: Text(semester)),
                  ),
                ];
              },
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : schedules.isEmpty
          ? _buildEmptyState(context)
          : _buildSchedulesList(context, schedules),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_month_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved schedules',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Parse and save a schedule to see it here',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulesList(BuildContext context, schedules) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: schedules.length,
      itemBuilder: (context, index) {
        final schedule = schedules[index];
        return SavedScheduleCard(
          schedule: schedule,
          onTap: () => _loadSchedule(context, schedule.id),
          onDelete: () => _confirmDelete(context, schedule),
        );
      },
    );
  }

  Future<void> _loadSchedule(BuildContext context, String scheduleId) async {
    final savedSchedulesProvider = context.read<SavedSchedulesProvider>();
    final scheduleProvider = context.read<ScheduleProvider>();

    final schedule = await savedSchedulesProvider.loadScheduleById(scheduleId);

    if (schedule != null && context.mounted) {
      // Load the schedule table into ScheduleProvider
      scheduleProvider.loadScheduleTable(schedule.table);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Loaded "${schedule.name}"'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Navigate back to schedule view
      // TODO: Navigate to schedule screen when navigation is implemented
    }
  }

  Future<void> _confirmDelete(BuildContext context, schedule) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Schedule'),
        content: Text(
          'Are you sure you want to delete "${schedule.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      try {
        await context.read<SavedSchedulesProvider>().deleteSchedule(
          schedule.id,
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Deleted "${schedule.name}"'),
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // TODO: Implement undo functionality
                },
              ),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting schedule: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }
}
