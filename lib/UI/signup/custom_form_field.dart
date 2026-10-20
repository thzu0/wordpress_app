import 'package:flutter/material.dart';
import 'package:wordpress_app/constans/constans.dart';

class CustomFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final Object? initialValue;
  final Function(String)? onChanged;
  final TextDirection textDirection;
  final String labelName;

  const CustomFormField({
    super.key,
    this.validator,
    this.initialValue,
    this.onChanged,
    required this.textDirection,
    required this.labelName,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        initialValue: initialValue != null ? initialValue.toString() : '',
        onChanged: onChanged,
        cursorColor: Constants.primaryColor,
        style: const TextStyle(
          fontFamily: 'Lalazar',
          fontSize: 20,
          height: 2.0,
        ),
        textDirection: textDirection,
        decoration: InputDecoration(
          errorStyle: const TextStyle(fontFamily: 'Vazirmatn'),
          hintTextDirection: TextDirection.rtl,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Constants.primaryColor, width: 2.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          label: Text(
            labelName,
            style: TextStyle(
              fontFamily: 'Lalezar',
              fontSize: 20,
              color: Constants.primaryColor,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
