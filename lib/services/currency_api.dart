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

Future<Map<String, dynamic>> fetchHistoricalsRates({
  required String from, 
  required String to, 
  String since = '2025-01-01'
}) async {
  final response = await http.get(
    Uri.parse('https://api.frankfurter.dev/v1/$since..?base=$from&symbols=$to'),
  );
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load exchange rates');
  }
}