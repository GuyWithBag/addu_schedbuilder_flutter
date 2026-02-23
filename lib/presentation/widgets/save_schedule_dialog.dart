import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Dialog for saving the current schedule
class SaveScheduleDialog extends HookWidget {
  final Function(String name, String? semester) onSave;

  const SaveScheduleDialog({super.key, required this.onSave});

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
        FilledButton(
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

                  isLoading.value = true;
                  final semester = semesterController.text.trim();
                  onSave(name, semester.isEmpty ? null : semester);
                  Navigator.of(context).pop();
                },
          child: isLoading.value
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Save'),
        ),
      ],
    );
  }
}
