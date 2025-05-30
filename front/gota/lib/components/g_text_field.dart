import 'package:flutter/material.dart';

class GTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const GTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<GTextField> createState() => _GTextFieldState();
}

class _GTextFieldState extends State<GTextField> {
  Color colorPrimary = const Color.fromARGB(255, 81, 180, 86);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorPrimary),
        ),
      ),
    );
  }
}
