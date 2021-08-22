import 'package:flutter/material.dart';
import 'constant.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final double roundedCorner;
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool obscureText;
  final Function? onIconPressed;
  const RoundedPasswordField({
    Key? key,
    this.obscureText = true,
    this.onIconPressed,
    this.onChanged,
    this.textEditingController,
    this.roundedCorner = 29,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: grey,
        borderRadius: BorderRadius.circular(roundedCorner),
      ),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        cursorColor: primaryVariant,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: this.hintText,
          icon: Icon(
            Icons.lock,
            color: primary,
          ),
          suffixIcon: IconButton(
            color: primary,
            icon: obscureText
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            onPressed: () => onIconPressed,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
