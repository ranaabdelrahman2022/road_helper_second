import 'package:flutter/material.dart';

class EditTextField extends StatelessWidget {
  final String label;
  final IconData icon; // Change to IconData
  final double iconSize;
  final TextInputType keyboardType;
  final bool obscureText;

  const EditTextField({
    super.key,
    required this.label,
    required this.icon, // Change to IconData
    this.iconSize = 8, // Smaller default size
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white
          ),
          prefixIcon: Icon(
            icon,
            size: iconSize,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
          filled: true,
          fillColor: Theme.of(context).brightness == Brightness.light
              ? Colors.grey[200]
              : const Color(0xFF022C5A),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey
                  : Colors.transparent,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
        ),
      ),
    );
  }
}