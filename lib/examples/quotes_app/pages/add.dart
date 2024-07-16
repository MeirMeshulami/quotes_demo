import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/models/quote_model.dart';
import 'package:quotes_demo/examples/quotes_app/quotes_repo.dart';



class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final quotesRepo = QuotesRepo();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _authorController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Quote quote = Quote(author: _authorController.text, text: _textController.text);
      quotesRepo.addQuote(quote);

      // Process data
      _authorController.clear();
      _textController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Quote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(100.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the author name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _textController,
                decoration: const InputDecoration(labelText: 'Quote Text'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter quote text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
