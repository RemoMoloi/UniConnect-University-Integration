import 'package:flutter/material.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/main_campus.jpg'),
            Image.asset('assets/images/key.jpg')
          ],
        ),
      ),
    );
  }
}