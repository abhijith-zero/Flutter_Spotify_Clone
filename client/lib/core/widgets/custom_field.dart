import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    final String? Function(String?)? validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      decoration: InputDecoration(hintText: hintText),
      readOnly: readOnly,
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
