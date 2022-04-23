import 'package:flutter/cupertino.dart';

class TextCeraRoundBold extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextCeraRoundBold({
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
        fontFamily: 'ceraroundpro',
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 14,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextCeraRoundRegular extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextCeraRoundRegular({
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
        fontFamily: 'ceraroundpro',
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextCeraRoundMedium extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextCeraRoundMedium({
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
        fontFamily: 'ceraroundpro',
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextCeraRoundThin extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextCeraRoundThin({
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
        fontFamily: 'ceraroundpro',
        fontWeight: FontWeight.w300,
        fontSize: fontSize ?? 14,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}

class TextCeraRoundLight extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColour;
  final TextOverflow? overflow;
  const TextCeraRoundLight({
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
        fontFamily: 'ceraroundpro',
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 14,
        color: textColour ?? CupertinoColors.black,
      ),
    );
  }
}
