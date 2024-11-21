// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String Text;
  final TextEditingController textEditingController;
  final bool isPassword;
  final IconData icon;
  
  const TextFieldInput({
    super.key, 
    required this.Text, 
    required this.textEditingController, 
    this.isPassword = false, 
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField( 
        controller: textEditingController,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: Text,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
          prefixIcon: Icon(icon, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          
          // Adding the border
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.5), // Visible grey border
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2), // Blue border when focused
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: const Color(0xFFedf0f8), // Background color inside the TextField
        ),
      ),
    );
  }
}
