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
      home: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Image.asset('assets/icons/currency.png')),
              Tab(icon: SvgPicture.asset('assets/icons/graphic.svg')),
            ],
          ),
        ),
        body: const TabBarView(
            children: [
              MyHomePage(title: 'My Currency App'),
              Icon(Icons.directions_bike),
            ],
          ),
        )
      )
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
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
            final amount = double.tryParse(value) ?? 0.0;
            _result.text = (amount * _rates?["rates"][_selectedCurrency]).toStringAsFixed(2);
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
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
          _buildConvertionText(_selectedCurrency),
          _buildSheet(),
        ],
      )
    );
  }

  Widget _buildConvertionText(String selectedText) {
    return Text(
      selectedText,
      style: GoogleFonts.lato(
      fontWeight: FontWeight.bold,
      fontSize: 16)
    );
  }

  Widget _buildSheet() {
    return IconButton(
      icon: SvgPicture.asset('assets/icons/Chevron.svg'),
      iconSize: 16,
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          barrierColor: Color.fromRGBO(32, 37, 50, 0.8),
          context: context,
          builder: (context) {
            final currencyList = _rates?["rates"]?.keys.toList() ?? [];
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 8),
                  child: Container(
                    width: 60,
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3.5),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: currencyList.map<Widget>((currency) {
                      return ListTile(
                        title: Text(currency, style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16)),
                        onTap: () {
                          setState(() {
                            _selectedCurrency = currency;
                            _result.text = (_rates?["rates"][_selectedCurrency] * int.parse(_amount.text)).toString();
                          });
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }
}
