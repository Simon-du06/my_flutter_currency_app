import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_flutter_currency_app/services/currency_api.dart';

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
  Map<String, dynamic>? _rates;
  late final TextEditingController _amount;
  late final TextEditingController _result;
  String _selectedCurrency = "USD";

  void _loadRates() async {
    final data = await fetchExchangeRates();
    setState(() {
      _rates = data;
    });
  }

 @override
  void initState() {
    _amount = TextEditingController(text: '');
    _result = TextEditingController(text: '');
    _loadRates();
    super.initState();
  }

  @override
  void dispose() {
    _amount.dispose();
    _result.dispose();
    super.dispose();
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
            _buildAmountInput(),
            SizedBox(height: 65),
            _buildResultField(),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
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
        controller: _amount,
        obscureText: false,
        keyboardType: TextInputType.number,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 36
        ),
        decoration: InputDecoration(
          hintText: 'Enter amount in €',
          border: OutlineInputBorder(borderSide: BorderSide.none)
        ),
        onChanged: (value) {
          _result.text = (_rates?["rates"][_selectedCurrency] * int.parse(value)).toString();
        }
      ),
    );
  }

  Widget _buildResultField() {
    return Container(
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
              controller: _result,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 36
              ),
              decoration: InputDecoration(
                hintText: 'Which is',
                border: OutlineInputBorder(borderSide: BorderSide.none)
              ),
            ),
          ),
          _buildD),
        ],
      )
    );
  }

  Widget _buildDropRates() {
    final currencyList = _rates?["rates"]?.keys.toList() ?? [];
  
    return DropdownButton(
      value: _selectedCurrency,
      items: currencyList
        .map<DropdownMenuItem<String>>(
          (currency) => DropdownMenuItem<String>(
            value: currency,
            child: Text(currency),
          ),
        )
        .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value as String;
        });
      },
      icon: SvgPicture.asset('assets/icons/Chevron.svg'), //, height: 16, width: 16
      iconSize: 16,
    );
  }
}
