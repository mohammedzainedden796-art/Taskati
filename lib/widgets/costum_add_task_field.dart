import 'package:flutter/material.dart';

class CostumAddTaskField extends StatelessWidget {
  const CostumAddTaskField({
    super.key,
    this.controller,
    this.validator,
    this.readOnly = true,
    this.MaxLines = 1,
    this.suffixIcon = null,
    required this.hintText,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final int MaxLines;
  final Widget? suffixIcon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "this field is  required";
            }
          },
      maxLines: MaxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff4E5AE8)),
        ),
      ),
    );
  }
}
