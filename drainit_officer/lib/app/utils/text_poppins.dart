import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPoppinsBold extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextPoppinsBold({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textColour,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: textColour,
      ),
    );
  }
}

class TextPoppinsRegular extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;

  const TextPoppinsRegular({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: fontSize,
        color: textColour,
      ),
    );
  }
}

class TextPoppinsItalic extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  const TextPoppinsItalic({
    Key? key,
    required this.text,
    required this.fontSize,
    this.textColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
          color: textColour,
          fontWeight: FontWeight.normal,
          fontSize: fontSize,
          fontStyle: FontStyle.italic),
    );
  }
}
