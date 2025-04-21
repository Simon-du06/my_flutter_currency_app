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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all( 
                        color: const Color.fromRGBO(103, 110, 218, 1), 
                        width: 2.0,
                ),
              ),
              padding: EdgeInsets.fromLTRB(16, 34, 16, 34),
              width: 395,
              height: 108,
              child: TextField(
                controller: _amountController,
                obscureText: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter amount in €',
                  border: OutlineInputBorder(borderSide: BorderSide.none)
                ),
                onChanged: (value) {
                  _resultController.text = value;
                }
              ),
            ),
            SizedBox(height: 65),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all( 
                        color: const Color.fromRGBO(206, 210, 218, 1), 
                        width: 2.0,
                ),
              ),
              padding: EdgeInsets.fromLTRB(16, 34, 16, 34),
              width: 395,
              height: 108,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      readOnly: true,
                      controller: _resultController,
                      decoration: InputDecoration(
                        labelText: 'Which is',
                        border: OutlineInputBorder(borderSide: BorderSide.none)
                      ),
                    ),
                  ),
                  // DropdownButton(
                  //   items: currencyList,
                  //   onChanged: _setDestinationCurrency,
                  //   icon: SvgPicture.asset('assets/icons/Chevron.svg'), //, height: 16, width: 16
                  //   iconSize: 16,
                  // ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
