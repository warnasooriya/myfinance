import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/services/message_codec.dart';
import 'package:image_picker/image_picker.dart'; // Ensure this package is in your pubspec.yaml
import 'package:myfinance/screens/budget_item_screen.dart';
import 'package:myfinance/utils/constants.dart'; // Import for constants like primaryColor
import 'package:myfinance/widgets/BuildElevatedButton.dart';
import 'package:myfinance/widgets/BuildTextButton.dart';
import 'package:myfinance/widgets/BuildTextField.dart'; // For date formatting
import 'package:myfinance/widgets/BuildDatePicker.dart';
import 'package:myfinance/widgets/BuildDropdown.dart';

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _expensesTypeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nameController = TextEditingController();
  DateTime _selectedFromDate = DateTime.now();
  DateTime _selectedToDate = DateTime.now();
  List<Map<String, dynamic>> transactions = [
    {
      "id": 1,
      "title": "Budget 1",
      "startDate": "2022-10-01",
      "enddate": "2022-10-31",
      "imageUrl": 1,
    },
    {
      "id": 2,
      "title": "Budget 2",
      "startDate": "2022-11-01",
      "enddate": "2022-11-30",
      "imageUrl": 2,
    },
    {
      "id": 3,
      "title": "Budget 3",
      "startDate": "2022-12-01",
      "enddate": "2022-12-31",
      "imageUrl": 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget'),
        backgroundColor: primaryColor,
        foregroundColor: headerTextColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...transactions
                .map((transaction) => Container(
                        child: InkWell(
                      onTap: () {
                        viewBudgetDetailsAdding(transaction["id"]);
                        // You can perform any action here when the card is tapped
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.zero, // Removes rounded corners
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        transaction["title"].toString(),
                                        style: TextStyle(
                                            color: Colors.blue[900],
                                            fontSize: 20),
                                        softWrap: true,
                                        // Enables wrapping of text
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Image.asset(
                                          'assets/${transaction['imageUrl'].toString()}.png', // Your app logo here
                                          width: 80,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Icon(
                                              Icons.calendar_month_rounded,
                                              color: Colors.green[900],
                                            ),
                                            Text(
                                              ' ${transaction["startDate"].toString().substring(0, 10)}',
                                              style: TextStyle(
                                                  color: Colors.green[900],
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 25),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.calendar_month_rounded,
                                                color: Colors.orange[900],
                                              ),
                                              Text(
                                                ' ${transaction["enddate"].toString().substring(0, 10)}',
                                                style: TextStyle(
                                                    color: Colors.orange[900],
                                                    fontSize: 16),
                                              ),
                                            ])
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: const Color.fromARGB(255, 151, 153,
                                      155), // Color of the divider
                                  height:
                                      30, // Space above and below the divider
                                  thickness: 1, // Thickness of the divider
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'Income',
                                          style: TextStyle(
                                              color: Colors.blue[450],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${Random().nextDouble().toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Colors.blue[450],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Expenses',
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${Random().nextDouble().toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Colors.red[900],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          'Balance',
                                          style: TextStyle(
                                              color: Colors.green[900],
                                              fontSize: 14),
                                        ),
                                        Text(
                                          '${Random().nextDouble().toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Colors.green[900],
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    )))
                .toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        tooltip: 'Add New Budget',
        child: Icon(Icons.add),
      ),
    );
  }

  void viewBudgetDetailsAdding(int budgetId) {
    // Handle transaction submission logic
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BudgetItemScreen(
                  budgetId: budgetId,
                )));
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          title: Text('Add New Budget'),
          content: Container(
            padding: EdgeInsets.all(20), // Control space inside the dialog
            width: double.maxFinite, // Expands the dialog width to the maximum
            child: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  BuildTextField(
                    _nameController,
                    'Budget Title',
                    TextInputType.text,
                  ),
                  DatePickerWidget(
                    selectedDate: _selectedFromDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedFromDate = newDate;
                      });
                    },
                    label: "Start Date",
                  ),
                  SizedBox(height: 10),
                  DatePickerWidget(
                    selectedDate: _selectedToDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedToDate = newDate;
                      });
                    },
                    label: "End Date",
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CustomElevatedButton(
              onPressed: _addNewBudget,
              buttonText: 'Create Budget',
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
    if (_nameController.text.isNotEmpty &&
        _selectedFromDate.toString().isNotEmpty &&
        _selectedToDate.toString().isNotEmpty) {
      setState(() {
        transactions.add({
          "id": transactions.length + 1,
          "title": _nameController.text,
          "startDate": _selectedFromDate.toString(),
          "enddate": _selectedToDate.toString(),
          "imageUrl": getImageId(transactions.length),
        });
        _nameController.clear();
      });
      Navigator.of(context).pop(); // Close the dialog
    }
  }
}
