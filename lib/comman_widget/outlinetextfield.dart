import 'package:flutter/material.dart';

class OutlineTextField extends StatelessWidget {
  const OutlineTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.keyboardType,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: hintText,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
