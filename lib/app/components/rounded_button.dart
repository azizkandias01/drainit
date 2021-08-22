import 'package:flutter/material.dart';

import 'constant.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final Color color, textColor;
  final double? borderRadius;
  final double? elevation;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  const RoundedButton(
      {Key? key,
      required this.text,
      this.press,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.width,
      this.elevation = 0,
      this.color = primary,
      this.textColor = textPrimary,
      this.borderRadius = 29})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: width != null ? this.width : size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: this.color),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              primary: color,
            ),
            onPressed: press,
            child: Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: this.fontSize,
                  fontWeight: this.fontWeight),
            ),
          ),
        ]),
      ),
    );
  }
}
