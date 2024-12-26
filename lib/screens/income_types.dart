import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Ensure this package is in your pubspec.yaml
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/widgets/BuildElevatedButton.dart';
import 'package:myfinance/widgets/BuildTextField.dart'; // For date formatting

class IncomeTypesScreen extends StatefulWidget {
  @override
  _IncomeTypesScreenState createState() => _IncomeTypesScreenState();
}

class _IncomeTypesScreenState extends State<IncomeTypesScreen> {
  final _incomeTypeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Income Types'),
        backgroundColor:
            primaryColor, // Assuming primaryColor is defined in constants.dart
        foregroundColor:
            headerTextColor, // Assuming headerTextColor is defined in constants.dart
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, // Full width
        height: MediaQuery.of(context).size.height, // Full height
        padding: const EdgeInsets.all(20), // You can remove padding if needed
        child: Card(
          elevation: 25,
          margin: EdgeInsets.all(
              3), // Removes margin so the card covers the full area
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(
                25)), // Removes border radius to cover entire screen
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BuildTextField(
                    _incomeTypeController, 'Income Type', TextInputType.text),
                SizedBox(height: 20),
                BuildTextField(_descriptionController, 'Description',
                    TextInputType.multiline),
                SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: _submitIncomeType, // Pass the method here
                  buttonText: 'Save Income Type', // Pass the text here
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitIncomeType() {
    // Handle transaction submission logic
    print('IncomeType: ${_incomeTypeController.text}');
    print('Description: ${_descriptionController.text}');
  }
}
