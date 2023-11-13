import 'package:flutter/material.dart';

class OutlineTextField extends StatelessWidget {
  OutlineTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.keyboardType,
    this.readOnly = false,
    this.validator,
    this.suffixIcon,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool readOnly;
  String? Function(String?)? validator;
  Widget? suffixIcon;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextFormField(
        onChanged: onChanged,

        validator: validator,
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,

          label: SizedBox(
              height: 40,
              child: Text(hintText,)),
          alignLabelWithHint: true,
          labelStyle: TextStyle(fontSize: 20,),
          border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
              ),
          filled: true,


          // fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
