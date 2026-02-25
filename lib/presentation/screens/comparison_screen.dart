import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../providers/comparison_provider.dart';
import '../providers/saved_schedules_provider.dart';
import '../providers/display_config_provider.dart';
import '../../domain/models/weekday.dart';

/// Screen for comparing multiple schedules to find common free time
class ComparisonScreen extends HookWidget {
  const ComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final comparisonProvider = context.watch<ComparisonProvider>();
    final savedSchedulesProvider = context.watch<SavedSchedulesProvider>();
    final displayConfig = context.watch<DisplayConfigProvider>();
    final schedules = savedSchedulesProvider.schedules;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        savedSchedulesProvider.loadSchedules();
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Schedules'),
        actions: [
          if (comparisonProvider.hasSelection)
            TextButton(
              onPressed: () => comparisonProvider.clearSelection(),
              child: const Text('Clear'),
            ),
        ],
      ),
      body: schedules.isEmpty
          ? _buildEmptyState(context)
          : Column(
              children: [
                // Schedule selection list
                Expanded(
                  flex: 2,
                  child: _buildSchedulesList(
                    context,
                    schedules,
                    comparisonProvider,
                  ),
                ),

                // Compare button
                if (comparisonProvider.selectedScheduleIds.length >= 2)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FilledButton.icon(
                      onPressed: () {
                        comparisonProvider.compareSchedules(schedules);
                      },
                      icon: const Icon(Icons.compare_arrows),
                      label: Text(
                        'Find Common Free Time (${comparisonProvider.selectedScheduleIds.length} schedules)',
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ),

                // Results
                if (comparisonProvider.hasResults)
                  Expanded(
                    flex: 3,
                    child: _buildResults(
                      context,
                      comparisonProvider,
                      displayConfig,
                    ),
                  ),
              ],
            ),
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
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No saved schedules',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save schedules to compare them',
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulesList(
    BuildContext context,
    List schedules,
    ComparisonProvider provider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'Select schedules to compare',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => provider.selectAll(schedules.cast()),
                child: const Text('Select All'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: schedules.length,
            itemBuilder: (context, index) {
              final schedule = schedules[index];
              final isSelected = provider.isSelected(schedule.id);

              return Card(
                color: isSelected
                    ? Theme.of(context).colorScheme.primaryContainer
                    : null,
                child: CheckboxListTile(
                  value: isSelected,
                  onChanged: (_) => provider.toggleSchedule(schedule.id),
                  title: Text(schedule.name),
                  subtitle: Text(
                    schedule.semester ?? 'No semester',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  secondary: Icon(
                    Icons.calendar_today,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResults(
    BuildContext context,
    ComparisonProvider provider,
    DisplayConfigProvider displayConfig,
  ) {
    final groupedFreeTime = provider.groupedFreeTime;
    final stats = provider.stats;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Stats header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Common Free Time',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${stats['totalHours']}h ${stats['totalMinutes']}m • ${stats['blockCount']} time slots',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () => _exportResults(context, provider),
                  icon: const Icon(Icons.share, size: 18),
                  label: const Text('Export'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Free time blocks by day
          Expanded(
            child: groupedFreeTime.isEmpty
                ? Center(
                    child: Text(
                      'No common free time found',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: Weekday.values.length,
                    itemBuilder: (context, index) {
                      final weekday = Weekday.values[index];
                      final blocks = groupedFreeTime[weekday] ?? [];

                      if (blocks.isEmpty) return const SizedBox.shrink();

                      return _buildDayCard(
                        context,
                        weekday,
                        blocks,
                        displayConfig,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(
    BuildContext context,
    Weekday weekday,
    List blocks,
    DisplayConfigProvider displayConfig,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: displayConfig.weekdayColors[weekday],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  weekday.fullName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${blocks.length} ${blocks.length == 1 ? "slot" : "slots"}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...blocks.map((block) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      block.formatTimeRange(displayConfig.is24HourFormat),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${block.durationMinutes} min',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _exportResults(BuildContext context, ComparisonProvider provider) {
    final groupedFreeTime = provider.groupedFreeTime;
    final buffer = StringBuffer();

    buffer.writeln('Common Free Time Comparison');
    buffer.writeln('===========================\n');

    for (final weekday in Weekday.values) {
      final blocks = groupedFreeTime[weekday];
      if (blocks == null || blocks.isEmpty) continue;

      buffer.writeln('${weekday.fullName}:');
      for (final block in blocks) {
        buffer.writeln(
          '  ${block.formatTimeRange(false)} (${block.durationMinutes} minutes)',
        );
      }
      buffer.writeln();
    }

    // Show export dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Results'),
        content: SingleChildScrollView(
          child: SelectableText(buffer.toString()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
