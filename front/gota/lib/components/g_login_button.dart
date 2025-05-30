import 'package:flutter/material.dart';

class GLoginButton extends StatefulWidget {
  final VoidCallback onPressed;

  const GLoginButton({super.key, required this.onPressed});

  @override
  State<GLoginButton> createState() => _GLoginButtonState();
}

class _GLoginButtonState extends State<GLoginButton> {
  Color colorPrimary = const Color.fromARGB(255, 81, 180, 86);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Login",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
