import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../../domain/models/class_data.dart';
import '../../domain/models/class_note.dart';
import '../../domain/models/note_type.dart';
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

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
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

              // Add note section
              Text(
                'Add Note',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () {
                      if (textController.text.trim().isNotEmpty) {
                        notesProvider.addNote(
                          classCode: classData.code,
                          content: textController.text.trim(),
                          type: selectedType.value,
                        );
                        textController.clear();
                      }
                    },
                  ),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    notesProvider.addNote(
                      classCode: classData.code,
                      content: value.trim(),
                      type: selectedType.value,
                    );
                    textController.clear();
                  }
                },
              ),

              const SizedBox(height: 24),

              // Notes list
              Text(
                'Notes (${notes.length})',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Notes
              Expanded(
                child: notes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return _NoteCard(
                            note: note,
                            onDelete: () => notesProvider.deleteNote(
                              note.id,
                              classData.code,
                            ),
                          );
                        },
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
  final VoidCallback onDelete;

  const _NoteCard({required this.note, required this.onDelete});

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
