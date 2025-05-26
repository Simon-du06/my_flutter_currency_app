import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencySelectionSheet extends StatelessWidget {
  const CurrencySelectionSheet({
    super.key,
    required this.currencyList,
    required this.onCurrencySelected,
  });

  final List<String> currencyList;
  final Function(String) onCurrencySelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Drag indicator
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
          // Currency list
          Expanded(
            child: ListView(
              children: currencyList.map<Widget>((currency) {
                return ListTile(
                  title: Text(
                    currency, 
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold, 
                      fontSize: 16
                    )
                  ),
                  onTap: () {
                    onCurrencySelected(currency);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static void show({
    required BuildContext context,
    required List<String> currencyList,
    required Function(String) onCurrencySelected,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Color.fromRGBO(32, 37, 50, 0.8),
      context: context,
      builder: (context) => CurrencySelectionSheet(
        currencyList: currencyList,
        onCurrencySelected: onCurrencySelected,
      ),
    );
  }
}