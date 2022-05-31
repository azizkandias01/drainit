import 'package:flutter/cupertino.dart';

class TextBold extends StatelessWidget {
  const TextBold({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextRegular extends StatelessWidget {
  const TextRegular({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextMedium extends StatelessWidget {
  const TextMedium({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}

class TextThin extends StatelessWidget {
  const TextThin({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextLight extends StatelessWidget {
  const TextLight({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextSemiBold extends StatelessWidget {
  const TextSemiBold({
    Key? key,
    required this.text,
    this.fontSize,
    this.textAlign,
    this.overflow,
    this.textColour,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}
