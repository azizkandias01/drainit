import 'package:drainit_flutter/app/components/constant.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key? key,
    this.obscureText = true,
    this.onIconPressed,
    this.onChanged,
    this.textEditingController,
    this.roundedCorner = 29,
    this.hintText,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final double roundedCorner;
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool obscureText;
  final Function? onIconPressed;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
          hintText: hintText,
          icon: const Icon(
            Icons.lock,
            color: primary,
          ),
          suffixIcon: IconButton(
            color: primary,
            icon: obscureText
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
            onPressed: () => onIconPressed,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
