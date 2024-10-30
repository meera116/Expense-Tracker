import 'package:flutter/material.dart';
import 'package:expense/expenseform.dart';
// Make sure to import the other necessary pages, e.g., SetSavingsGoalPage and AnalysisPage

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker Home',
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 179, 247),
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200, // Set your desired width
              height: 50, // Set your desired height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromARGB(255, 173, 211, 241),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExpenseFormPage()),
                  );
                },
                child: Text('Add New Expenses', style: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 200, // Set your desired width
              height: 50, // Set your desired height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromARGB(255, 120, 187, 241),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SetSavingsGoalPage()), // Ensure this page exists
                  );
                },
                child: Text('Set Savings Goal', style: TextStyle(color: Colors.black)),
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: 200, // Set your desired width
              height: 50, // Set your desired height
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: const Color.fromARGB(255, 71, 170, 250),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnalysisPage()), // Ensure this page exists
                  );
                },
                child: Text('Analyze Expenses', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
}

void main() {
  runApp(ExpenseTrackerApp());
}
