import 'package:http/http.dart' as http;
import 'dart:convert';

import '../secrets.dart';

Future<Map<String, dynamic>> fetchExchangeRates() async {
  final response = await http.get(
    Uri.parse('https://currency-conversion-and-exchange-rates.p.rapidapi.com/latest?base=EUR'),
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