
import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/quote_model.dart';
import 'package:quotes_demo/examples/quotes_app/quotes_repo.dart';




class BasicCrudApp extends StatelessWidget {
  BasicCrudApp({super.key});

  Quote quote=Quote(author: "Meir Meshulami", text: "test text");
  final QuotesRepo quotesRepo = QuotesRepo();

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
        body:  Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => quotesRepo.addQuote(quote),
                child: const Text('Add Quote'),
              ),
              ElevatedButton( 
                 onPressed: () => quotesRepo.getQuotes(),
                child: const Text('Get Quote'),
              ),
              ElevatedButton(
                onPressed:() => quotesRepo.deleteQuotes(), 
                child: const Text('Delete Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}