import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Ensure this package is in your pubspec.yaml
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/widgets/BuildElevatedButton.dart';
import 'package:myfinance/widgets/BuildTextField.dart'; // For date formatting

class ExpensesTypesScreen extends StatefulWidget {
  @override
  _ExpensesTypesScreenState createState() => _ExpensesTypesScreenState();
}

class _ExpensesTypesScreenState extends State<ExpensesTypesScreen> {
  final _expensesTypeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Types'),
        backgroundColor:
            primaryColor, // Assuming primaryColor is defined in constants.dart
        foregroundColor:
            headerTextColor, // Assuming headerTextColor is defined in constants.dart
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Full width
        height: MediaQuery.of(context).size.height, // Full height
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 25,
          margin: EdgeInsets.all(3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                BuildTextField(_expensesTypeController, 'Expenses Type',
                    TextInputType.text),
                SizedBox(height: 20),
                BuildTextField(_descriptionController, 'Description',
                    TextInputType.multiline),
                SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: _submitExpensesType, // Pass the method here
                  buttonText: 'Save Expenses Tyoe', // Pass the text here
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitExpensesType() {
    // Handle transaction submission logic
    print('IncomeType: ${_expensesTypeController.text}');
    print('Description: ${_descriptionController.text}');
  }
}
