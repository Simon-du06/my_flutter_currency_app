import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountInputField extends StatelessWidget {
  const AmountInputField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
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
        controller: controller,
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
        onChanged: onChanged,
      ),
    );
  }
}

class ResultField extends StatelessWidget {
  const ResultField({
    super.key,
    required this.controller,
    required this.selectedCurrency,
    this.onCurrencyTap,
  });

  final TextEditingController controller;
  final String selectedCurrency;
  final VoidCallback? onCurrencyTap;

  @override
  Widget build(BuildContext context) {
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
              controller: controller,
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
          Text(
            selectedCurrency,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
          IconButton(
            icon: Icon(Icons.expand_more),
            iconSize: 16,
            onPressed: onCurrencyTap,
          ),
        ],
      )
    );
  }
}
