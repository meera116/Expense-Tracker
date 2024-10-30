import 'package:flutter/material.dart';

// Global variables for simplicity
double savingsGoal = 0.0; // Savings goal
double totalExpenses = 0.0; // Total expenses

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      home: ExpenseFormPage(),
    );
  }
}

class ExpenseFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense',style:TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: ExpenseForm(),
    );
  }
}

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _amountControllers = [];

  void _showFieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int numberOfFields = 0;

        return AlertDialog(
          title: Text('Enter Number of Expenses'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Number of Fields'),
            onChanged: (value) {
              numberOfFields = int.tryParse(value) ?? 0;
            },
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _generateFields(numberOfFields);
              },
            ),
          ],
        );
      },
    );
  }

  void _generateFields(int count) {
    setState(() {
      _titleControllers = List.generate(count, (_) => TextEditingController());
      _amountControllers = List.generate(count, (_) => TextEditingController());
    });
  }

  void _submitForm() {
    double newTotal = 0.0;

    for (var amountController in _amountControllers) {
      double amount = double.tryParse(amountController.text) ?? 0;
      newTotal += amount;
    }

    setState(() {
      totalExpenses += newTotal; // Update total expenses
    });

    // Show a snackbar with the input values
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Total Expenses Added: Rs${newTotal.toStringAsFixed(2)}, Grand Total: Rs${totalExpenses.toStringAsFixed(2)}')),
    );

    // Clear the form fields for new input
    for (var controller in _titleControllers) {
      controller.clear();
    }
    for (var controller in _amountControllers) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill space
          children: [
            ElevatedButton(
              onPressed: _showFieldDialog,
              child: Text('Add Expense', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
            ),
            SizedBox(height: 20),
            Text(
              'Total Expenses: Rs${totalExpenses.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20), // Optional: Increase font size for visibility
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Generate text fields based on the number of expenses
            ...List.generate(_titleControllers.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleControllers[index],
                      decoration: InputDecoration(labelText: 'Title ${index + 1}'),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _amountControllers[index],
                      decoration: InputDecoration(labelText: 'Amount ${index + 1}'),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm, // Call _submitForm when pressed
              child: Text('Submit', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetSavingsGoalPage()),
                );
              },
              child: Text('Set Savings Goal', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
            ),
          ],
        ),
      ),
    );
  }
}

// Savings Goal Page
class SetSavingsGoalPage extends StatefulWidget {
  @override
  _SetSavingsGoalPageState createState() => _SetSavingsGoalPageState();
}

class _SetSavingsGoalPageState extends State<SetSavingsGoalPage> {
  final TextEditingController _goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Savings Goal',style:TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
       
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _goalController,
                decoration: InputDecoration(labelText: 'Monthly Savings Goal'),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _setSavingsGoal(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
              child: Text('Set Goal', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnalysisPage()),
                );
              },
              child: Text('Go to Analysis', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 111, 185, 245)),
            ),
          ],
        ),
      ),
    );
  }

  void _setSavingsGoal(BuildContext context) {
    final double goal = double.tryParse(_goalController.text) ?? 0;

    if (goal > 0) {
      setState(() {
        savingsGoal = goal; // Update global savings goal variable
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Savings goal set to Rs${savingsGoal.toStringAsFixed(2)}'),
      ));

      // Clear the form
      _goalController.clear();
    }
  }
}

// Analysis Page
class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analysis',
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 96, 179, 247),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Total Expenses Card
                Expanded(child: _buildSquareCard('Total Expenses:', 'Rs${totalExpenses.toStringAsFixed(2)}')),
                SizedBox(width: 20),
                // Savings Goal Card
                Expanded(child: _buildSquareCard('Savings Goal:', 'Rs${savingsGoal.toStringAsFixed(2)}')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Check if expenses are within savings goal
                String message = (totalExpenses <= savingsGoal)
                    ? 'HURRAY! YOUR EXPENSE IS BELOW SAVING GOAL, CONGRATS!'
                    : 'YOUR EXPENSE IS NOT BELOW SAVING GOAL, REDUCE YOUR EXPENSES';

                // Show alert dialog instead of snackbar
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Savings Status'),
                      content: Text(message),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Check Savings Status'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareCard(String title, String amount) {
    return Container(
      width: 150 , // Make card full width
      height: 150, // Fixed height for square card
      child: Card(
        color: const Color.fromARGB(255, 134, 196, 247),
        elevation: 4,
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
