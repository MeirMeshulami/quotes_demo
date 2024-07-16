import 'package:flutter/material.dart';
import 'package:quotes_demo/examples/quotes_app/pages/add.dart';
import 'package:quotes_demo/examples/quotes_app/pages/data.dart';
import 'package:quotes_demo/examples/quotes_app/pages/home.dart';



class QuotesApp extends StatefulWidget {
  const QuotesApp({super.key});

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  int _selectedIndex = 0;
  final List<Widget>pages=[const HomePage(),const AddPage(),const DataPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Quotes App')),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body:  Center(
          child: pages[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Data',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}