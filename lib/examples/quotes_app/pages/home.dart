import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/models/quote_model.dart';
import 'package:quotes_demo/examples/quotes_app/quotes_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final QuotesRepo quotesRepo = QuotesRepo();
  List<Quote> quotes = [];
  int currentIndex = 0;

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

  void _nextQuote() {
    setState(() {
      if (currentIndex < quotes.length - 1) {
        currentIndex++;
      }
    });
  }

  void _prevQuote() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  Color _getBackgroundColor(int index) {
    // Generate different background colors based on the index
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.orange,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: quotes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: _getBackgroundColor(currentIndex),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      quotes[currentIndex].text,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '- ${quotes[currentIndex].author}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: _prevQuote,
                        child: const Icon(Icons.arrow_left),
                      ),
                      ElevatedButton(
                        onPressed: _nextQuote,
                        child: const Icon(Icons.arrow_right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
