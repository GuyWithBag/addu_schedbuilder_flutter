import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../models/schedule_table.dart';
import '../models/weekday.dart';
import '../services/statistics_service.dart';
import '../providers/display_config_provider.dart';

/// Widget displaying schedule statistics
class StatisticsWidget extends HookWidget {
  final ScheduleTable table;

  const StatisticsWidget({super.key, required this.table});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayConfig = context.watch<DisplayConfigProvider>();
    final is24Hour = displayConfig.is24HourFormat;

    final totalHours = StatisticsService.calculateTotalHours(table);
    final busiestDay = StatisticsService.getBusiestDay(table);
    final classCount = StatisticsService.countClasses(table);
    final avgDuration = StatisticsService.getAverageClassDuration(table);
    final earliestTime = StatisticsService.getEarliestClassTime(
      table,
      is24Hour,
    );
    final latestTime = StatisticsService.getLatestClassTime(table, is24Hour);
    final hoursPerDay = StatisticsService.getAverageHoursPerDay(table);
    final timeDistribution = StatisticsService.getTimeDistribution(table);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.bar_chart, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Schedule Statistics',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Main stats grid
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _StatCard(
                  icon: Icons.event_note,
                  label: 'Total Classes',
                  value: classCount.toString(),
                  color: Colors.blue,
                ),
                _StatCard(
                  icon: Icons.access_time,
                  label: 'Hours/Week',
                  value: totalHours.toStringAsFixed(1),
                  color: Colors.green,
                ),
                _StatCard(
                  icon: Icons.calendar_today,
                  label: 'Busiest Day',
                  value: _getWeekdayName(busiestDay),
                  color: Colors.orange,
                ),
                _StatCard(
                  icon: Icons.timer,
                  label: 'Avg Duration',
                  value: '${avgDuration.toStringAsFixed(0)} min',
                  color: Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Time range
            Text(
              'Schedule Time Range',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _InfoRow(
                    icon: Icons.wb_sunny,
                    label: 'Earliest',
                    value: earliestTime,
                  ),
                ),
                Expanded(
                  child: _InfoRow(
                    icon: Icons.nights_stay,
                    label: 'Latest',
                    value: latestTime,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Hours per day chart
            Text(
              'Hours per Weekday',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _HoursPerDayChart(hoursPerDay: hoursPerDay),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Time distribution
            Text(
              'Time Distribution',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _TimeDistributionChart(distribution: timeDistribution),
          ],
        ),
      ),
    );
  }

  String _getWeekdayName(Weekday day) {
    switch (day) {
      case Weekday.sunday:
        return 'Sunday';
      case Weekday.monday:
        return 'Monday';
      case Weekday.tuesday:
        return 'Tuesday';
      case Weekday.wednesday:
        return 'Wednesday';
      case Weekday.thursday:
        return 'Thursday';
      case Weekday.friday:
        return 'Friday';
      case Weekday.saturday:
        return 'Saturday';
    }
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          SelectableText(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          SelectableText(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            SelectableText(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class _HoursPerDayChart extends StatelessWidget {
  final Map<Weekday, double> hoursPerDay;

  const _HoursPerDayChart({required this.hoursPerDay});

  @override
  Widget build(BuildContext context) {
    final maxHours = hoursPerDay.values.isEmpty
        ? 0.0
        : hoursPerDay.values.reduce((a, b) => a > b ? a : b);

    return Column(
      children: Weekday.values.map((day) {
        final hours = hoursPerDay[day] ?? 0.0;
        final percentage = maxHours > 0 ? hours / maxHours : 0.0;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Text(
                  _getWeekdayShort(day),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percentage,
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 50,
                child: Text(
                  '${hours.toStringAsFixed(1)}h',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getWeekdayShort(Weekday day) {
    switch (day) {
      case Weekday.sunday:
        return 'S';
      case Weekday.monday:
        return 'M';
      case Weekday.tuesday:
        return 'T';
      case Weekday.wednesday:
        return 'W';
      case Weekday.thursday:
        return 'Th';
      case Weekday.friday:
        return 'F';
      case Weekday.saturday:
        return 'Sa';
    }
  }
}

class _TimeDistributionChart extends StatelessWidget {
  final Map<String, int> distribution;

  const _TimeDistributionChart({required this.distribution});

  @override
  Widget build(BuildContext context) {
    final total = distribution.values.reduce((a, b) => a + b);

    return Row(
      children: [
        _buildSegment(
          context,
          'Morning',
          distribution['morning'] ?? 0,
          total,
          Colors.amber,
        ),
        _buildSegment(
          context,
          'Afternoon',
          distribution['afternoon'] ?? 0,
          total,
          Colors.orange,
        ),
        _buildSegment(
          context,
          'Evening',
          distribution['evening'] ?? 0,
          total,
          Colors.deepOrange,
        ),
      ],
    );
  }

  Widget _buildSegment(
    BuildContext context,
    String label,
    int count,
    int total,
    Color color,
  ) {
    final percentage = total > 0
        ? (count / total * 100).toStringAsFixed(0)
        : '0';

    return Expanded(
      flex: count > 0 ? count : 1,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(_getIcon(label), color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text('$count classes', style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(String label) {
    switch (label) {
      case 'Morning':
        return Icons.wb_sunny;
      case 'Afternoon':
        return Icons.wb_twilight;
      case 'Evening':
        return Icons.nights_stay;
      default:
        return Icons.access_time;
    }
  }
}
