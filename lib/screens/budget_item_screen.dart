import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/message_codec.dart';
import 'package:image_picker/image_picker.dart'; // Ensure this package is in your pubspec.yaml
import 'package:myfinance/utils/constants.dart'; // Import for constants like primaryColor
import 'package:myfinance/widgets/BuildElevatedButton.dart';
import 'package:myfinance/widgets/BuildTextButton.dart';
import 'package:myfinance/widgets/BuildTextField.dart'; // For date formatting
import 'package:myfinance/widgets/BuildDatePicker.dart';
import 'package:myfinance/widgets/BuildDropdown.dart';

class BudgetItemScreen extends StatefulWidget {
  final int budgetId;

  // Constructor with required parameters

  BudgetItemScreen({
    required this.budgetId,
  });

  @override
  _BudgetItemScreenState createState() => _BudgetItemScreenState();
}

class _BudgetItemScreenState extends State<BudgetItemScreen> {
  final _expensesTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedFromDate = DateTime.now();
  DateTime _selectedToDate = DateTime.now();

  List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "type": "Income",
      "section": "Transport",
      "description": "Transportation",
      "amount": 5000,
    },
    {
      "id": 2,
      "type": "Expense",
      "section": "Electricity",
      "description": "Electricity Bill",
      "amount": 2000,
    },
    {
      "id": 3,
      "type": "Expense",
      "section": "Groceries",
      "description": "Groceries",
      "amount": 3000,
    },
    {
      "id": 4,
      "type": "Income",
      "section": "Transport",
      "description": "Transportation",
      "amount": 5000,
    },
    {
      "id": 5,
      "type": "Expense",
      "section": "Electricity",
      "description": "Electricity Bill",
      "amount": 2000,
    },
    {
      "id": 6,
      "type": "Expense",
      "section": "Groceries",
      "description": "Groceries",
      "amount": 3000,
    },
    {
      "id": 7,
      "type": "Income",
      "section": "Transport",
      "description": "Transportation",
      "amount": 5000,
    },
    {
      "id": 8,
      "type": "Expense",
      "section": "Electricity",
      "description": "Electricity Bill",
      "amount": 2000,
    },
    {
      "id": 9,
      "type": "Expense",
      "section": "Groceries",
      "description": "Groceries",
      "amount": 3000,
    },
    {
      "id": 10,
      "type": "Income",
      "section": "Transport",
      "description": "Transportation",
      "amount": 5000,
    },
    {
      "id": 11,
      "type": "Expense",
      "section": "Electricity",
      "description": "Electricity Bill",
      "amount": 2000,
    },
    {
      "id": 12,
      "type": "Expense",
      "section": "Groceries",
      "description": "Groceries",
      "amount": 3000,
    },
  ];
  double totalIncome = 0;
  double totalExpenses = 0;
  double budget = 0;

  @override
  void initState() {
    super.initState();
    totalIncome = transactions
        .where((transaction) => transaction['type'] == 'Income')
        .fold(0, (sum, item) => sum + item['amount']);

    totalExpenses = transactions
        .where((transaction) => transaction['type'] == 'Expense')
        .fold(0, (sum, item) => sum + item['amount']);
    budget = totalIncome - totalExpenses;
  }

  String? _selectedTransactionType;
  String? _selectedSection;
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.budgetId.toString()),
        backgroundColor: primaryColor,
        foregroundColor: headerTextColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(totalIncome, totalExpenses, budget),
            // Income Section Heading
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: Colors.green[50], // Light green background
              child: Row(
                children: [
                  Icon(Icons.upload, color: Colors.green[900]), // Income icon
                  SizedBox(width: 8),
                  Text('Income',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900])),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  transactions.where((t) => t['type'] == 'Income').length,
              itemBuilder: (context, index) {
                var transaction = transactions
                    .where((t) => t['type'] == 'Income')
                    .toList()[index];
                return _buildTransactionCard(transaction);
              },
            ),
            Divider(color: Colors.grey[300], thickness: 1, height: 5),
            // Expenses Section Heading
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              color: Colors.red[50], // Light red background
              child: Row(
                children: [
                  Icon(Icons.download, color: Colors.red[900]), // Expenses icon
                  SizedBox(width: 8),
                  Text('Expenses',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900])),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  transactions.where((t) => t['type'] == 'Expense').length,
              itemBuilder: (context, index) {
                var transaction = transactions
                    .where((t) => t['type'] == 'Expense')
                    .toList()[index];
                return _buildTransactionCard(transaction);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Add Budget Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void viewBudgetDetailsAdding(int transactionId) {
    // Handle transaction submission logic
    print('transId: ${transactionId}');
  }

  Widget _buildTransactionCard(Map transaction) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          transaction['type'] == 'Income'
              ? Icons.trending_up
              : Icons.trending_down,
          color: transaction['type'] == 'Income'
              ? const Color.fromARGB(255, 104, 209, 108)
              : Colors.red,
        ),
        title: Text(
          transaction["section"],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(transaction["description"]),
        trailing: Text(
          '${transaction["amount"]}',
          style: TextStyle(
            color: transaction['type'] == 'Income'
                ? Colors.green[700]
                : Colors.red[700],
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
      double totalIncome, double totalExpenses, double budget) {
    return Card(
      color: Colors.teal[100],
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildSummaryItem('Income', totalIncome, Colors.green),
            _buildSummaryItem('Expenses', totalExpenses, Colors.red),
            _buildSummaryItem(
                'Savings', budget, budget >= 0 ? Colors.blue : Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, double value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(title,
            style: TextStyle(
              fontSize: 16,
              color: color,
            )),
        Text('${value.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text('Add Budget Item'),
          content: Container(
            padding: EdgeInsets.all(20), // Control space inside the dialog
            width: double.maxFinite, // Expands the dialog width to the maximum
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  BuildDropdown(
                      'Type', ['Income', 'Expense'], _selectedTransactionType,
                      (newValue) {
                    setState(() => _selectedTransactionType = newValue);
                  }),
                  SizedBox(height: 20),
                  BuildDropdown(
                      'Section',
                      ['Transport', 'Electricity', 'Groceries'],
                      _selectedSection, (newValue) {
                    setState(() => _selectedSection = newValue);
                  }),
                  SizedBox(height: 10),
                  BuildTextField(
                      _amountController, 'Amount', TextInputType.number),
                  SizedBox(height: 10),
                  BuildTextField(_descriptionController, "Description",
                      TextInputType.text),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              onPressed: _addNewBudget,
              buttonText: 'Add Item',
            ),
          ],
        );
      },
    );
  }

  getImageId(int length) {
    int id = length + 1;
    int imageId = id % 10;
    return imageId;
  }

  void _addNewBudget() {
    print('hi');
    if (_amountController.text.isNotEmpty &&
        _selectedFromDate.toString().isNotEmpty &&
        _selectedToDate.toString().isNotEmpty) {
      setState(() {
        transactions.add({
          "id": transactions.length + 1,
          "type": _selectedTransactionType,
          "section": _selectedSection,
          "description": _descriptionController.text,
          "amount": _amountController.text,
        });
        _amountController.clear();
      });
      Navigator.of(context).pop(); // Close the dialog
    }
  }
}
