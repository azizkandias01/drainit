import 'package:drainit_flutter/app/components/constant.dart';
import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({
    Key? key,
    this.roundedCorner = 29,
    this.child,
    this.height,
    this.width,
    this.backgroundColor,
  }) : super(key: key);
  final Widget? child;
  final double roundedCorner;
  final double? width;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: width ?? size.width * 0.8,
      height: height ?? size.height * .05,
      decoration: BoxDecoration(
        color: backgroundColor ?? kBackgroundInput,
        borderRadius: BorderRadius.circular(roundedCorner),
      ),
      child: child,
    );
  }
}
