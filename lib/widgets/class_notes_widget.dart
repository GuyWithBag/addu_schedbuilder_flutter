import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../domain/models/class_note.dart';
import '../../domain/models/note_type.dart';
import '../providers/notes_provider.dart';

/// Widget displaying notes for a specific class
class ClassNotesWidget extends HookWidget {
  final String classCode;
  final String className;

  const ClassNotesWidget({
    super.key,
    required this.classCode,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.getNotesForClass(classCode);

    useEffect(() {
      Future.microtask(() => notesProvider.loadNotesForClass(classCode));
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: Text('Notes - $className')),
      body: notes.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return _NoteCard(
                  note: note,
                  onEdit: () => _showEditNoteDialog(context, note),
                  onDelete: () => _confirmDelete(context, note),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddNoteDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_outlined,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add a note',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          _NoteDialog(classCode: classCode, title: 'Add Note'),
    );
  }

  void _showEditNoteDialog(BuildContext context, ClassNote note) {
    showDialog(
      context: context,
      builder: (context) => _NoteDialog(
        classCode: classCode,
        title: 'Edit Note',
        existingNote: note,
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, ClassNote note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
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
        await context.read<NotesProvider>().deleteNote(note.id, classCode);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Note deleted'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting note: $e'),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }
}

/// Note card widget
class _NoteCard extends StatelessWidget {
  final ClassNote note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _NoteCard({
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y • h:mm a');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _NoteTypeChip(type: note.type),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined, size: 20),
                    onPressed: onEdit,
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Delete',
                    color: Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SelectableText(
                note.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Text(
                dateFormat.format(note.createdAt),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Note type chip
class _NoteTypeChip extends StatelessWidget {
  final NoteType type;

  const _NoteTypeChip({required this.type});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (type) {
      case NoteType.homework:
        color = Colors.orange;
        icon = Icons.assignment_outlined;
        break;
      case NoteType.exam:
        color = Colors.red;
        icon = Icons.quiz_outlined;
        break;
      case NoteType.general:
        color = Colors.blue;
        icon = Icons.note_outlined;
        break;
    }

    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(type.label),
      labelStyle: TextStyle(color: color, fontSize: 12),
      side: BorderSide(color: color),
      backgroundColor: color.withAlpha(30),
    );
  }
}

/// Dialog for adding/editing notes
class _NoteDialog extends HookWidget {
  final String classCode;
  final String title;
  final ClassNote? existingNote;

  const _NoteDialog({
    required this.classCode,
    required this.title,
    this.existingNote,
  });

  @override
  Widget build(BuildContext context) {
    final contentController = useTextEditingController(
      text: existingNote?.content ?? '',
    );
    final selectedType = useState(existingNote?.type ?? NoteType.general);
    final isSaving = useState(false);

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            SegmentedButton<NoteType>(
              segments: NoteType.values
                  .map(
                    (type) => ButtonSegment(
                      value: type,
                      label: Text(type.label),
                      icon: Icon(_getIconForType(type), size: 16),
                    ),
                  )
                  .toList(),
              selected: {selectedType.value},
              onSelectionChanged: (Set<NoteType> newSelection) {
                selectedType.value = newSelection.first;
              },
            ),
            const SizedBox(height: 16),
            Text('Content', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: 'Enter note content...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              autofocus: true,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: isSaving.value ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: isSaving.value
              ? null
              : () async {
                  final content = contentController.text.trim();
                  if (content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter note content'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  isSaving.value = true;

                  try {
                    final notesProvider = context.read<NotesProvider>();

                    if (existingNote != null) {
                      // Update existing note
                      final updatedNote = existingNote!.copyWith(
                        content: content,
                        type: selectedType.value,
                      );
                      await notesProvider.updateNote(updatedNote);
                    } else {
                      // Add new note
                      await notesProvider.addNote(
                        classCode: classCode,
                        content: content,
                        type: selectedType.value,
                      );
                    }

                    if (context.mounted) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            existingNote != null
                                ? 'Note updated'
                                : 'Note added',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  } catch (e) {
                    isSaving.value = false;
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error saving note: $e'),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  }
                },
          child: Text(existingNote != null ? 'Save' : 'Add'),
        ),
      ],
    );
  }

  IconData _getIconForType(NoteType type) {
    switch (type) {
      case NoteType.homework:
        return Icons.assignment_outlined;
      case NoteType.exam:
        return Icons.quiz_outlined;
      case NoteType.general:
        return Icons.note_outlined;
    }
  }
}
