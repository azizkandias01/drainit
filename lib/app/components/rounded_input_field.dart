import 'package:flutter/material.dart';
import 'constant.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final double? roundedCorner;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  const RoundedInputField(
      {Key? key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.textEditingController,
      this.roundedCorner = 29})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      roundedCorner: this.roundedCorner!,
      child: TextField(
        onChanged: onChanged,
        cursorColor: primary,
        controller: this.textEditingController,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: primary,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
