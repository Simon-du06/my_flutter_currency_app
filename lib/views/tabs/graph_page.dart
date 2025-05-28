import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/currency_api.dart';
import '../widgets/currency_selection_sheet.dart';

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
  String _baseCurrency = "EUR";
  String _targetCurrency = "USD";
  
  List<Color> gradientColors = [
    const Color(0xFF676EDA),
    const Color(0xFF4DFED1),
  ];

  void _loadHistory() async {
    final data = await fetchHistoricalsRates(from: _baseCurrency, to: _targetCurrency);
    setState(() {
      _histRates = data;
    });
  }

    void _onCurrencyTap(String currencyType) {    
    final currencyList = ['USD', 'EUR', 'GBP', 'JPY', 'AUD', 'CAD', 'CHF', 'CNY', 'SEK', 'NZD', 'TRY'];
    
    CurrencySelectionSheet.show(
      context: context,
      currencyList: currencyList,
      onCurrencySelected: (currency) {
        setState(() {
          if (currencyType == "base") {
            _baseCurrency = currency;
          } else {
            _targetCurrency = currency;
          }
          _histRates = null;
        });
        _loadHistory();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  List<FlSpot> _convertToFlSpots() {
    if (_histRates == null) return [];
    
    List<String> datesList = _histRates?["rates"].keys.toList() ?? [];
    
    return datesList.asMap().entries.map((entry) {
      int index = entry.key;
      String dateString = entry.value;
      double rate = _histRates?["rates"][dateString][_targetCurrency]?.toDouble() ?? 0.0;
      
      return FlSpot(index.toDouble(), rate);
    }).toList();
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (_histRates == null) return const Text('');
    
    List<String> datesList = _histRates?["rates"].keys.toList() ?? [];
    datesList.sort();
    
    if (value.toInt() >= datesList.length) return const Text('');
    
    String dateString = datesList[value.toInt()];
    DateTime date = DateTime.parse(dateString);
    
    int totalDates = datesList.length;
    int index = value.toInt();
    int step = totalDates > 10 ? 4 : 2;
    
    if (index % step == 0 || index == totalDates - 1) {
      List<String> months = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 
                            'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'];
      
      return SideTitleWidget(
        meta: meta,
        child: Transform.rotate(
          angle: -0.5,
          child: Text(
            '${months[date.month - 1]} ${date.day}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return const Text('');
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    
    return Text(
      value.toStringAsFixed(2),
      style: style,
      textAlign: TextAlign.left,
    );
  }

  LineChartData _buildLineChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 0.05,
        verticalInterval: 2,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 0.3,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 45,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 0.1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 50,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xFF676EDA), width: 1),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: _convertToFlSpots(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onCurrencyTap("base"),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF676EDA)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Base: $_baseCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onCurrencyTap("target"),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF676EDA)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Target: $_targetCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _histRates == null 
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: AspectRatio(
                    aspectRatio: 1.50,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                        top: 30,
                        bottom: 20,
                      ),
                      child: LineChart(_buildLineChartData()),
                    ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
