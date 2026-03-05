import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../domain/models/saved_schedule.dart';

/// Dialog for saving the current schedule
class SaveScheduleDialog extends HookWidget {
  final Function(String name, String? semester, {String? overwriteId}) onSave;
  final List<SavedSchedule> existingSchedules;
  final String? currentScheduleId;

  const SaveScheduleDialog({
    super.key,
    required this.onSave,
    this.existingSchedules = const [],
    this.currentScheduleId,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final semesterController = useTextEditingController();
    final isLoading = useState(false);

    return AlertDialog(
      title: const Text('Save Schedule'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Schedule Name',
              hintText: 'e.g., Fall 2024 Schedule',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: semesterController,
            decoration: const InputDecoration(
              labelText: 'Semester (optional)',
              hintText: 'e.g., Fall 2024',
              border: OutlineInputBorder(),
            ),
            textCapitalization: TextCapitalization.words,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading.value ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        // Show overwrite current button if there's a current schedule
        if (currentScheduleId != null) ...[
          FilledButton.tonal(
            onPressed: isLoading.value
                ? null
                : () async {
                    final currentSchedule = existingSchedules.firstWhere(
                      (s) => s.id == currentScheduleId,
                      orElse: () => existingSchedules.first,
                    );

                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Overwrite Schedule?'),
                        content: Text(
                          'Overwrite "${currentSchedule.name}" with the current schedule?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Overwrite'),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true && context.mounted) {
                      isLoading.value = true;
                      onSave(
                        currentSchedule.name,
                        currentSchedule.semester,
                        overwriteId: currentScheduleId,
                      );
                      Navigator.of(context).pop();
                    }
                  },
            child: const Text('Overwrite Current'),
          ),
        ],
        // Overwrite by name button (if name matches existing)
        FilledButton.tonal(
          onPressed: isLoading.value
              ? null
              : () {
                  final name = nameController.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a schedule name'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  // Check if name exists
                  final existing = existingSchedules
                      .where((s) => s.name == name)
                      .toList();

                  if (existing.isEmpty) {
                    // No match, save as new
                    isLoading.value = true;
                    final semester = semesterController.text.trim();
                    onSave(name, semester.isEmpty ? null : semester);
                    Navigator.of(context).pop();
                  } else {
                    // Show overwrite dialog
                    showDialog<SavedSchedule>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Schedule Name Exists'),
                        content: existing.length == 1
                            ? Text(
                                'A schedule named "$name" already exists. Overwrite it?',
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${existing.length} schedules named "$name" exist. Choose one to overwrite:',
                                  ),
                                  const SizedBox(height: 16),
                                  ...existing.map(
                                    (schedule) => ListTile(
                                      title: Text(schedule.name),
                                      subtitle: Text(
                                        schedule.semester ?? 'No semester',
                                      ),
                                      trailing: Text(
                                        '${schedule.table.getAllClasses().length} classes',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                      onTap: () =>
                                          Navigator.of(context).pop(schedule),
                                    ),
                                  ),
                                ],
                              ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          if (existing.length == 1)
                            FilledButton(
                              onPressed: () =>
                                  Navigator.of(context).pop(existing.first),
                              child: const Text('Overwrite'),
                            ),
                        ],
                      ),
                    ).then((selectedSchedule) {
                      if (selectedSchedule != null) {
                        isLoading.value = true;
                        final semester = semesterController.text.trim();
                        onSave(
                          name,
                          semester.isEmpty ? null : semester,
                          overwriteId: selectedSchedule.id,
                        );
                        Navigator.of(context).pop();
                      }
                    });
                  }
                },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
