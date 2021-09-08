import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constant.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double? roundedCorner;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final double? width;
  final double? height;
  final double? textSize;
  final Color? backgroundColor;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textEditingController,
    this.roundedCorner = 29,
    this.height,
    this.width,
    this.textSize,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: this.backgroundColor ?? kBackgroundInput,
        borderRadius: BorderRadius.circular(roundedCorner!),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: kBackgroundInput,
        controller: this.textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: textSize ?? 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
