// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_currency_app/services/currency_api.dart';

void main() {
  test('fetchExchangeRates returns a map with rates', () async {
    final result = await fetchExchangeRates("EUR");
    expect(result, isA<Map<String, dynamic>>());
    expect(result.containsKey('rates'), true);
  });
}
