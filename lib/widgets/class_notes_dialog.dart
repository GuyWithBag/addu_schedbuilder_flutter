import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../models/class_data.dart';
import '../models/class_note.dart';
import '../models/note_type.dart';
import '../providers/notes_provider.dart';

/// Dialog for managing notes for a specific class
class ClassNotesDialog extends HookWidget {
  final ClassData classData;

  const ClassNotesDialog({super.key, required this.classData});

  @override
  Widget build(BuildContext context) {
    final notesProvider = context.watch<NotesProvider>();
    final notes = notesProvider.getNotesForClass(classData.code);
    final textController = useTextEditingController();
    final selectedType = useState(NoteType.general);
    final editingNote = useState<ClassNote?>(null);

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          classData.code,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          classData.title,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).textTheme.bodySmall?.color,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),

              const Divider(height: 32),

              // Add/Edit note section
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        editingNote.value != null ? 'Edit Note' : 'Add Note',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      // Note type selector
                      SegmentedButton<NoteType>(
                        segments: const [
                          ButtonSegment(
                            value: NoteType.general,
                            label: Text('General'),
                            icon: Icon(Icons.note_outlined),
                          ),
                          ButtonSegment(
                            value: NoteType.homework,
                            label: Text('Homework'),
                            icon: Icon(Icons.assignment_outlined),
                          ),
                          ButtonSegment(
                            value: NoteType.exam,
                            label: Text('Exam'),
                            icon: Icon(Icons.quiz_outlined),
                          ),
                        ],
                        selected: {selectedType.value},
                        onSelectionChanged: (Set<NoteType> newSelection) {
                          selectedType.value = newSelection.first;
                        },
                      ),

                      const SizedBox(height: 12),

                      // Note input
                      TextField(
                        controller: textController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter note...',
                          border: const OutlineInputBorder(),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (editingNote.value != null)
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  tooltip: 'Cancel edit',
                                  onPressed: () {
                                    editingNote.value = null;
                                    textController.clear();
                                    selectedType.value = NoteType.general;
                                  },
                                ),
                              IconButton(
                                icon: Icon(
                                  editingNote.value != null
                                      ? Icons.check_circle
                                      : Icons.add_circle,
                                ),
                                tooltip: editingNote.value != null
                                    ? 'Save changes'
                                    : 'Add note',
                                onPressed: () {
                                  if (textController.text.trim().isNotEmpty) {
                                    if (editingNote.value != null) {
                                      notesProvider.updateNote(
                                        editingNote.value!.copyWith(
                                          content: textController.text.trim(),
                                          type: selectedType.value,
                                        ),
                                      );
                                      editingNote.value = null;
                                    } else {
                                      notesProvider.addNote(
                                        classCode: classData.code,
                                        content: textController.text.trim(),
                                        type: selectedType.value,
                                      );
                                    }
                                    textController.clear();
                                    selectedType.value = NoteType.general;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Notes list header
                      Text(
                        'Notes (${notes.length})',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),

                      // Notes list
                      if (notes.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.note_add_outlined,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No notes yet',
                                  style: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...notes.map(
                          (note) => _NoteCard(
                            note: note,
                            onEdit: () {
                              editingNote.value = note;
                              textController.text = note.content;
                              selectedType.value = note.type;
                            },
                            onDelete: () => notesProvider.deleteNote(
                              note.id,
                              classData.code,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual note card widget
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
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Type icon
                Icon(
                  _getTypeIcon(note.type),
                  size: 16,
                  color: _getTypeColor(note.type),
                ),
                const SizedBox(width: 6),
                Text(
                  note.type.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _getTypeColor(note.type),
                  ),
                ),
                const Spacer(),
                // Timestamp
                Text(
                  _formatDate(note.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(width: 8),
                // Edit button
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // Delete button
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(16),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SelectableText(
              note.content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon(NoteType type) {
    switch (type) {
      case NoteType.general:
        return Icons.note_outlined;
      case NoteType.homework:
        return Icons.assignment_outlined;
      case NoteType.exam:
        return Icons.quiz_outlined;
    }
  }

  Color _getTypeColor(NoteType type) {
    switch (type) {
      case NoteType.general:
        return Colors.blue;
      case NoteType.homework:
        return Colors.orange;
      case NoteType.exam:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }
}
