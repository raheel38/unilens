import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Info Screen',
          style: TextStyle(
            fontSize: 24, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Emphasize the text
            color: Colors.black, // Default black color for text
          ),
        ),
      ),
    );
  }
}
