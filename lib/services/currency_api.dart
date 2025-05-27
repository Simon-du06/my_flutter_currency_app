import 'package:http/http.dart' as http;
import 'dart:convert';

import '../secrets.dart';

Future<Map<String, dynamic>> fetchExchangeRates(String base) async {
  final response = await http.get(
    Uri.parse('https://currency-conversion-and-exchange-rates.p.rapidapi.com/latest?base=$base'),
    headers: {
      'X-RapidAPI-Key': apiKey,
      'X-RapidAPI-Host': 'currency-conversion-and-exchange-rates.p.rapidapi.com'
    },
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load exchange rates');
  }
}

Future<Map<String, dynamic>> fetchHistoricalsRates(String from, String to) async {
  final response = await http.get(
    Uri.parse('https://api.frankfurter.dev/v1/2024-01-01..?base=$from&symbols=$to'),
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load exchange rates');
  }
}