import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    super.key,
    this.controller,
    this.obscureText,
    this.labelText,
    this.prefixIcon,
    this.style,
    this.inputBorderColor,
  });

  final TextEditingController? controller;
  final bool? obscureText;
  final String? labelText;
  final IconData? prefixIcon;
  final TextStyle? style;
  final Color? inputBorderColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      obscuringCharacter: "*",
      style: style,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        labelStyle: const TextStyle(fontSize: 20),

        //
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: inputBorderColor ?? borderColor,
          ),
        ),

        //
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: inputBorderColor ?? borderColor,
          ),
        ),
      ),
    );
  }
}
