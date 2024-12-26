import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:myfinance/widgets/AttachImageButton.dart';
import 'package:myfinance/widgets/BuildDatePicker.dart';
import 'package:myfinance/widgets/BuildDropdown.dart';
import 'package:myfinance/widgets/BuildElevatedButton.dart';
import 'package:myfinance/widgets/BuildTextField.dart';

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedTransactionType;
  String? _selectedSection;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        backgroundColor: primaryColor,
        foregroundColor: headerTextColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 25,
            margin: EdgeInsets.all(
                3), // Removes margin so the card covers the full area
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(
                  25)), // Removes border radius to cover entire screen
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  BuildDropdown('Transaction Type', ['Income', 'Expense'],
                      _selectedTransactionType, (newValue) {
                    setState(() => _selectedTransactionType = newValue);
                  }),
                  SizedBox(height: 20),
                  BuildDropdown(
                      'Section',
                      ['Transport', 'Electricity', 'Groceries'],
                      _selectedSection, (newValue) {
                    setState(() => _selectedSection = newValue);
                  }),
                  SizedBox(height: 20),
                  DatePickerWidget(
                    selectedDate: _selectedDate,
                    onDateChanged: (newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                    label: "Date",
                  ),
                  SizedBox(height: 20),
                  BuildTextField(
                      _amountController, 'Amount', TextInputType.number),
                  SizedBox(height: 20),
                  BuildTextField(
                      _remarksController, 'Remarks', TextInputType.text),
                  SizedBox(height: 20),
                  AttachImageButton(
                    onImageSelected: (image) {
                      setState(() {
                        _imageFile = image; // Update state with selected image
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  buildImagePreview(),
                  SizedBox(height: 20),
                  CustomElevatedButton(
                    onPressed: _submitTransaction,
                    buttonText: 'Submit Transaction',
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImagePicker() => AttachImageButton(
        onImageSelected: (image) => setState(() => _imageFile = image),
      );

  Widget buildImagePreview() => _imageFile != null
      ? kIsWeb
          ? Image.network(_imageFile!.path, height: 200, width: 200)
          : Image.file(File(_imageFile!.path), height: 200, width: 200)
      : Text('No image selected.');

  void _submitTransaction() {
    // Transaction submission logic
    print('Transaction Type: $_selectedTransactionType');
    print('Section: $_selectedSection');
    print('Date: $_selectedDate');
    print('Amount: ${_amountController.text}');
    print('Remarks: ${_remarksController.text}');
    print('Image Path: ${_imageFile?.path}');
  }
}
