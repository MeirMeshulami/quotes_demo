


class Quote{
  final String author;
  final String text;

  Quote({
    required this.author,
    required this.text
  });

  factory Quote.fromFirestore(Map<String, dynamic> data, String documentId){
    return Quote(
      author: data['author']??'',
      text: data['text']??''
    );
  }

  Map<String,dynamic> toFirestore(){
    return{
      'author':author,
      'text':text
    };
  }
}