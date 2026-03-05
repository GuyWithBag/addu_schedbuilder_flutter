import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../../domain/models/schedule_table.dart';
import '../providers/display_config_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Table widget displaying class information details
class ClassInfoTable extends HookWidget {
  final ScheduleTable scheduleTable;

  const ClassInfoTable({super.key, required this.scheduleTable});

  @override
  Widget build(BuildContext context) {
    final displayConfig = context.watch<DisplayConfigProvider>();
    final theme = Theme.of(context);
    final classes = scheduleTable.getAllClasses();

    if (classes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 64,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(height: 16),
              Text(
                'No classes to display',
                style: TextStyle(
                  color: theme.colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: displayConfig.tableBackgroundColor,
        borderRadius: BorderRadius.circular(displayConfig.cornerRadius),
        border: Border.all(color: displayConfig.tableBorderColor, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(displayConfig.cornerRadius),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(
              theme.colorScheme.surfaceContainerHighest,
            ),
            border: TableBorder.all(
              color: displayConfig.tableBorderColor,
              width: 1,
            ),
            columns: [
              DataColumn(
                label: Text(
                  'Class Code',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Subject',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Class Name',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Professor',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Email',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            rows: classes.map((classData) {
              final teacher = classData.teacher;
              final hasTeacher = teacher != null;
              final hasEmail = hasTeacher && teacher.emails.isNotEmpty;

              return DataRow(
                cells: [
                  // Class Code
                  DataCell(
                    Text(
                      classData.code.isNotEmpty ? classData.code : '-',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  // Subject Number
                  DataCell(
                    Text(
                      classData.subject.isNotEmpty ? classData.subject : '-',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  // Class Name/Title
                  DataCell(
                    SizedBox(
                      width: 250,
                      child: Text(
                        classData.title.isNotEmpty ? classData.title : '-',
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  // Professor Name
                  DataCell(
                    Text(
                      hasTeacher ? teacher.fullName : '-',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  // Email
                  DataCell(
                    hasEmail
                        ? InkWell(
                            onTap: () => _launchEmail(teacher.emails.first),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  teacher.emails.first,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.email_outlined,
                                  size: 16,
                                  color: theme.colorScheme.primary,
                                ),
                              ],
                            ),
                          )
                        : const Text('-'),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
