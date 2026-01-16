import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    final String? Function(String?)? validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      obscureText: obscureText,
      controller: controller,
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "Please enter $hintText";
        }
        return null;
      },
    );
  }
}
