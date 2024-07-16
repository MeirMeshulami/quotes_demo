class Quote {
  final String? id;
  final String author;
  final String text;

  Quote({
    this.id,
    required this.author,
    required this.text,
  });

  factory Quote.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Quote(
      id: documentId,
      author: data['author'] ?? '',
      text: data['text'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'author': author,
      'text': text,
    };
  }
}
