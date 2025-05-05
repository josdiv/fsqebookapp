import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    this.hintText,
    this.hasIcon = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.keyboardType,
  });

  final String? hintText;
  final Widget? suffixIcon;
  final bool hasIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = hasIcon;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: isPasswordField,
        maxLines: 1,
        validator: validator,
        keyboardType: keyboardType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffDDDDDD)),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.w700,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}

