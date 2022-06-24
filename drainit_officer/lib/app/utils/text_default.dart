import 'package:flutter/cupertino.dart';

class TextBold extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextBold({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);

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
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextRegular({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);

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
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextMedium({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextThin extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextThin({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);

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
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextLight({
    Key? key,
    required this.text,
    this.fontSize,
    this.overflow,
    this.textColour,
  }) : super(key: key);

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
