import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  late final TextEditingController _amountController;
  late final TextEditingController _resultController;

 @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '');
    _resultController = TextEditingController(text: '');
  }

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
                controller: _amountController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Enter amount in €'),
                onChanged: (value) {
                  _resultController.text = value;
                }
              ),
            ),
            SizedBox(height: 65),
            SizedBox(
              width: 250,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(readOnly: true, controller: _resultController,),
                  ),
                  SvgPicture.asset('assets/icons/Chevron.svg', height: 16, width: 16)
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
