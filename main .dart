import 'package:expense/select.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      home: CenteredImagePage(),
    );
  }
}

class CenteredImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to the Frontpage after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ExpenseTrackerApp()),
      );
    });

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BUDGET BUDDY",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
            color: const Color.fromARGB(255, 2, 38, 68),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 179, 247),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset(
              "lib/icons.png", // Ensure this path is correct
              width: 200, // Set desired width
              height: 200, // Set desired height
            ),
          ),
          Positioned(
            right: 20,
            bottom: screenHeight * 0.15,
            child: Text(
              "SAVE TODAY, SMILE TOMORROW!!",
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 38, 68),
                fontSize: screenHeight * 0.02, // Responsive font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: screenHeight * 0.1,
            child: Text(
              "SMALL SAVINGS, BIG DREAMS!!",
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 38, 68),
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: screenHeight * 0.05,
            child: Text(
              "INVEST IN YOUR FUTURE!!",
              style: TextStyle(
                color: const Color.fromARGB(255, 2, 38, 68),
                fontSize: screenHeight * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
