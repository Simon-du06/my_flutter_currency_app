import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/icons/currency.png', height: 40), label: 'Exhange'),
          BottomNavigationBarItem(icon: SvgPicture.asset('assets/icons/graphic.svg', height: 35), label: 'Graph'),
        ],
      ),
    );
  }
}
