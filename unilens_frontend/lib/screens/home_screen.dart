import 'package:flutter/material.dart';
import 'package:unilens/appLayout.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Stay Connected. Stay Informed.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Primary color for emphasis
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10), // Space between the texts
            Text(
              'Kyung Hee University',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black
                    .withOpacity(0.7), // Slightly muted for contrast
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
