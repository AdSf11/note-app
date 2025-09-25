class Note {
  final String content;
  Note({required this.content});

  factory Note.fromJson(Map<String, dynamic> json) => Note(content: json['content'] ?? '');
  Map<String, dynamic> toJson() => {'content': content};
}
