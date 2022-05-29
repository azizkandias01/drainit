import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'constant.dart';

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
  final EdgeInsetsGeometry? padding;
  final Color? borderColor;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textEditingController,
    this.roundedCorner = 10,
    this.height,
    this.width,
    this.textSize,
    this.backgroundColor,
    this.padding,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: onChanged,
        cursorColor: kBackgroundInput,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Colors.grey[100],
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(roundedCorner!),
            borderSide: BorderSide(
              color: Colors.grey[100]!,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(roundedCorner!),
            borderSide: BorderSide(
              color: Colors.grey[300]!,
            ),
          ),
          contentPadding: padding ??
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: textSize ?? 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
