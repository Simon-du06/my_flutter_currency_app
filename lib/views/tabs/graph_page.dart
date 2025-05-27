import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import '../../services/currency_api.dart';

class GraphPage extends StatefulWidget
{
  const GraphPage({super.key, required this.title});
  final String title;

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage>
{
  Map<String, dynamic>? _histRates;

  void _loadHistory(String base, String target) async {
    final data = await fetchHistoricalsRates(from: base, to: target);
    setState(() {
      _histRates = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadHistory('EUR', 'USD');
  }

  List<FlSpot> _convertToFlSpots() {
    if (_histRates == null) return [];
    List<String> datesList = _histRates?["rates"].keys.toList() ?? [];
  
    return datesList.asMap().entries.map((entry) => 
      FlSpot(entry.key.toDouble(), _histRates?["rates"][entry.value]["USD"])
    ).toList();
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: _convertToFlSpots(),
          color: Colors.blue,
        )
      ],
      // Configuration basique des axes/grille
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _histRates == null 
      ? Center(child: CircularProgressIndicator())
      : LineChart(_buildLineChartData())
    );
  }
}