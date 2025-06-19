import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountInputField extends StatelessWidget {
  const AmountInputField({
    super.key,
    required this.controller,
    required this.baseCurrency,
    this.onChanged,
    this.onCurrencyTap,
  });

  final TextEditingController controller;
  final String baseCurrency;
  final Function(String)? onChanged;
  final VoidCallback? onCurrencyTap;

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
      width: MediaQuery.of(context).size.width * 0.9,
      height: 108,
      child: Row(
        children: [
            Flexible(
            flex: 1,
            child: TextField(
              controller: controller,
              obscureText: false,
              keyboardType: TextInputType.number,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.bold,
                fontSize: 36
              ),
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(borderSide: BorderSide.none)
              ),
              onChanged: onChanged,
            ),
          ),
          Text(
            baseCurrency,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 16
            )
          ),
          IconButton(
            icon: SvgPicture.asset('assets/icons/Chevron.svg'),
            iconSize: 16,
            onPressed: onCurrencyTap,
          ),
        ],
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
      padding: EdgeInsets.fromLTRB(10, 5, 10, 4),
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
            icon: SvgPicture.asset('assets/icons/Chevron.svg'),
            iconSize: 16,
            onPressed: onCurrencyTap,
          ),
        ],
      )
    );
  }
}
