import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quotes_demo/examples/quotes_app/models/quote_model.dart';

class QuotesRepo {
  final FirebaseFirestore db;

  QuotesRepo() : db = FirebaseFirestore.instance;

  void addQuote(Quote quote) async {
    final data = {"text": quote.text, "author": quote.author};
    try {
      DocumentReference documentReference = await db.collection("quotes").add(data);
      print("Added Data with ID: ${documentReference.id}");
    } catch (e) {
      print("Error adding quote: $e");
    }
  }

  void deleteQuotes() async {
    try {
      // Get all documents in the "quotes" collection
      QuerySnapshot querySnapshot = await db.collection("quotes").get();

      // Loop through each document and delete it
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await db.collection("quotes").doc(doc.id).delete();
      }
      print("All quotes deleted successfully.");
    } catch (e) {
      print("Error deleting quotes: $e");
    }
  }

  Future<List<Quote>> getAllQuotes() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("quotes").get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Quote(
          id: doc.id,
          author: data['author'],
          text: data['text'],
        );
      }).toList();
    } catch (e) {
      print("Error getting all quotes: $e");
      return [];
    }
  }

  Future<void> updateQuote(Quote quote) async {
    try {
      await db.collection("quotes").doc(quote.id).update({
        "author": quote.author,
        "text": quote.text,
      });
    } catch (e) {
      print("Error updating quote: $e");
    }
  }

  Future<void> deleteQuote(String id) async {
    try {
      await db.collection("quotes").doc(id).delete();
      print("Deleted quote with ID: $id");
    } catch (e) {
      print("Error deleting quote: $e");
    }
  }
}
