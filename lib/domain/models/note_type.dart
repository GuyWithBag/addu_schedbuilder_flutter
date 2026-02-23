/// Type of class note
enum NoteType {
  general('General', 'General note'),
  homework('Homework', 'Homework assignment'),
  exam('Exam', 'Exam or quiz');

  const NoteType(this.label, this.description);

  final String label;
  final String description;
}
