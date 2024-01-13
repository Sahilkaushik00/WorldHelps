import 'package:flutter/material.dart';
import 'package:worldhelps/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.ispass,
      required this.hintText,
      required this.keyboardType,
      this.onFieldSubmitted,
      this.validator});
  final TextEditingController controller;
  final bool ispass;
  final String hintText;
  final TextInputType keyboardType;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: ispass,
        maxLines: 1,
        validator: validator,
        // onFieldSubmitted: onFieldSubmitted ?? FocusScope.of(context).nextFocus(),
        style: const TextStyle(color: primaryDark, fontSize: 16),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(color: primaryGrey, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: primaryDark,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryGrey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
