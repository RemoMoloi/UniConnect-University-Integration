import 'package:flutter/material.dart';

class MyButtons extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const MyButtons({
    super.key, 
    required this.onTap, 
    required this.text
    });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30),
              ),
            ),
            color: const Color.fromARGB(255, 19, 44, 87),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        ),
    );
  }
}