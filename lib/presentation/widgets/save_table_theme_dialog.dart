import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Dialog for saving table theme with a custom name
class SaveTableThemeDialog extends HookWidget {
  final Function(String name) onSave;

  const SaveTableThemeDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return AlertDialog(
      title: const Text('Save Table Theme'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Save your current table customizations as a theme'),
            const SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Theme Name',
                hintText: 'e.g., Dark Blue Theme',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.palette),
              ),
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a theme name';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                if (formKey.currentState!.validate()) {
                  onSave(nameController.text.trim());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              onSave(nameController.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
