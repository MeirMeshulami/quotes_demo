import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/models/quote_model.dart';
import 'package:quotes_demo/examples/quotes_app/quotes_repo.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final QuotesRepo quotesRepo = QuotesRepo();
  List<Quote> quotes = [];

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    final List<Quote> loadedQuotes = await quotesRepo.getAllQuotes();
    setState(() {
      quotes = loadedQuotes;
    });
  }

  void _deleteQuote(String id) async {
    await quotesRepo.deleteQuote(id);
    _loadQuotes();
  }

void _editQuote(Quote quote) async {
  TextEditingController authorController = TextEditingController(text: quote.author);
  TextEditingController textController = TextEditingController(text: quote.text);

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Quote'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: authorController,
              decoration: const InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Quote Text'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Quote updatedQuote = Quote(
                id: quote.id,
                author: authorController.text,
                text: textController.text,
              );
              await quotesRepo.updateQuote(updatedQuote);
              Navigator.of(context).pop();
              _loadQuotes();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data'),
      ),
      body: quotes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index) {
                Quote quote = quotes[index];
                return ListTile(
                  title: Text(quote.text),
                  subtitle: Text('- ${quote.author}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editQuote(quote),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteQuote(quote.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
