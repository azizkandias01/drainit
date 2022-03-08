import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return GestureDetector(
      onTap: press,
      child: Container(
        width: width ?? size.width * 0.8,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius!),
          child:
              Stack(alignment: AlignmentDirectional.center, children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(color: color),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                  color: textColor, fontSize: fontSize, fontWeight: fontWeight),
            ),
          ]),
        ),
      ),
    );
  }
}

class LoginWithButton extends StatelessWidget {
  final String? iconPath;
  final double? width;
  final double? height;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? spaceBetweenIconAndText;
  final double? fontSize;
  final double? iconWidth;
  final double? iconHeight;
  final void Function()? onClick;
  const LoginWithButton({
    Key? key,
    this.iconPath,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.spaceBetweenIconAndText,
    this.text,
    this.fontSize,
    this.iconWidth,
    this.iconHeight,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath ?? "",
            height: iconHeight,
            width: iconWidth,
          ),
          SizedBox(
            width: spaceBetweenIconAndText,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: textColor,
            ),
            onPressed: onClick,
            child: Text(
              text ?? "not defined",
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    ]);
  }
}

class ProfileMenuButton extends StatelessWidget {
  final String? iconPath;
  final double? width;
  final double? height;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? spaceBetweenIconAndText;
  final double? fontSize;
  final double? iconWidth;
  final double? iconHeight;
  final Function()? onPressed;
  const ProfileMenuButton({
    Key? key,
    this.iconPath,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.spaceBetweenIconAndText,
    this.text,
    this.fontSize,
    this.iconWidth,
    this.iconHeight,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: <Widget>[
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath ?? "",
            height: iconHeight,
            width: iconWidth,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: textColor,
            ),
            onPressed: onPressed,
            child: Text(
              text ?? "not defined",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
          SvgPicture.asset(
            "assets/svg/arrow_right.svg",
            height: iconHeight,
            width: iconWidth,
          ),
        ],
      ),
    ]);
  }
}
