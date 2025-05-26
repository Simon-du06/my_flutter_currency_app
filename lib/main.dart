import 'package:flutter/material.dart';
import 'package:my_flutter_currency_app/views/tabs/currency_converter_page.dart';
import 'package:my_flutter_currency_app/views/tabs/graph_page.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatefulWidget 
{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List <Widget> _pages = [
    MyHomePage(title: 'Currency Exchange'),
    GraphPage(title: 'Graph Page'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: navigationPage(),
    );
  }

  Widget navigationPage() {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF676EDA),
        unselectedItemColor: const Color(0xFF8292B3),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/icons/currency.png', height: 45, color: _currentIndex == 0 ? Color(0xFF676EDA) : Color(0xFF8292B3)), label: 'Exhange'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart, size: 45), label: 'Graph'),
        ],
      ),
    );
  }
}
