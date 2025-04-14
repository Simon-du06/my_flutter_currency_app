import 'package:flutter/material.dart';

void main()
{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Currency App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My Currency App'),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Enter amount in €'),
              ),
            ),
            SizedBox(height: 65),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: false,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Which is'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
