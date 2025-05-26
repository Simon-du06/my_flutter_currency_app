import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Graph Page',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}