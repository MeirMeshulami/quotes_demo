import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:quotes_demo/examples/quotes_app/quote_model.dart';

class QuotesRepo {
  final FirebaseFirestore db;

 QuotesRepo() : db = FirebaseFirestore.instance;

  void addQuote(Quote quote) async {
    final data = {"text": "Lorem text here...", "author": "John Doh"};
    try {
      DocumentReference documentReference =
          await db.collection("quotes").add(data);
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

  void getQuotes() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("quotes").get();

      if (querySnapshot.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          print("Quote: ${data['text']}, Author: ${data['author']}");
        }
      } else {
        print("No quotes found.");
      }
    } catch (e) {
      print("Error getting quotes: $e");
    }
  }
}
