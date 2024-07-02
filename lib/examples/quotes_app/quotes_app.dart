
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final db = FirebaseFirestore.instance;


void addQuote() async {
  final data = {"text": "Lorem text here...", "author": "John Doh"};
  try {
    DocumentReference documentReference = await db.collection("quotes").add(data);
    print("Added Data with ID: ${documentReference.id}");
  } catch (e) {
    print("Error adding quote: $e");
  }
}

void deleteQuotes()async{
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




class BasicCrudApp extends StatelessWidget {
  const BasicCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Provider Example'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: addQuote,
                child: Text('Add Quote'),
              ),
              ElevatedButton( 
                onPressed: getQuotes, 
                child: Text('Get Quote'),
              ),
              ElevatedButton(
                onPressed: deleteQuotes, 
                child: Text('Delete Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}