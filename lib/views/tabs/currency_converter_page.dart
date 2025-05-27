import 'package:flutter/material.dart';

import 'package:my_flutter_currency_app/views/widgets/input_fields.dart';
import 'package:my_flutter_currency_app/views/widgets/currency_selection_sheet.dart';
import '../../services/currency_api.dart';

class MyHomePage extends StatefulWidget
{
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  late final TextEditingController _amount;
  late final TextEditingController _result;
  Map<String, dynamic>? _rates;
  String _selectedCurrency = "USD";
  String _baseCurrency = "EUR";

  void _loadRates() async {
    final data = await fetchExchangeRates();
    setState(() {
      _rates = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController(text: '');
    _result = TextEditingController(text: '');
    _loadRates();
  }

  @override
  void dispose() {
    _amount.dispose();
    _result.dispose();
    super.dispose();
  }

  void _onAmountChanged(String value) {
    final amount = double.tryParse(value) ?? 0.0;
    if (_rates != null) {
      _result.text = (amount * _rates!["rates"][_selectedCurrency]).toStringAsFixed(2);
    }
  }

  void _onCurrencyTap(String currencyType) {
    if (_rates == null) return;
    
    final currencyList = _rates!["rates"]?.keys.toList().cast<String>() ?? [];
    
    CurrencySelectionSheet.show(
      context: context,
      currencyList: currencyList,
      onCurrencySelected: (currency) {
        setState(() {
          if (currencyType == "base") {
            _baseCurrency = currency;
          } else {
            _selectedCurrency = currency;
          }
          if (_amount.text.isNotEmpty) {
            _onAmountChanged(_amount.text);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AmountInputField(
              controller: _amount,
              baseCurrency: _baseCurrency,
              onChanged: _onAmountChanged,
              onCurrencyTap: () => _onCurrencyTap("base"),
            ),
            SizedBox(height: 65),
            ResultField(
              controller: _result,
              selectedCurrency: _selectedCurrency,
              onCurrencyTap: () => _onCurrencyTap("target"),
            ),
          ],
        ),
      ),
    );
  }
}