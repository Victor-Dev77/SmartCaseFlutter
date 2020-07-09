import 'package:flutter/material.dart';

class CustomTextField extends TextFormField {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final String hintText;
  final String Function(String) validator;
  final Function(String) onChanged;
  final VoidCallback onTap;
  final bool obscureText, readOnly;

  CustomTextField({
    Key key,
    this.controller,
    this.keyboardType: TextInputType.text,
    this.suffixIcon,
    this.hintText: "",
    this.obscureText: false,
    this.readOnly: false,
    this.validator,
    this.onChanged,
    this.onTap,
  })  : super(
          key: key,
          obscureText: obscureText,
          readOnly: readOnly,
          keyboardType: keyboardType,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          ),
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
        );
}
