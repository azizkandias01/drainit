import 'package:flutter/material.dart';
import 'constant.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double roundedCorner;
  final double? width;
  final double? height;
  const TextFieldContainer({
    Key? key,
    this.roundedCorner = 29,
    this.child,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: width ?? size.width * 0.8,
      height: height ?? size.height * .05,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(roundedCorner),
      ),
      child: child,
    );
  }
}
