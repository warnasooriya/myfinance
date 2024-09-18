import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Ensure this package is in your pubspec.yaml
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:intl/intl.dart'; // For date formatting

class TransactionScreen extends StatefulWidget {
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final _amountController = TextEditingController();
  final _remarksController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String? _selectedTransactionType;
  String? _selectedSection;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        backgroundColor:
            primaryColor, // Assuming primaryColor is defined in constants.dart
        foregroundColor:
            headerTextColor, // Assuming headerTextColor is defined in constants.dart
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 240, 240)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _buildDropdown('Transaction Type', ['Income', 'Expense'],
                        _selectedTransactionType, (newValue) {
                      setState(() => _selectedTransactionType = newValue);
                    }),
                    SizedBox(height: 20),
                    _buildDropdown(
                        'Section',
                        ['Transport', 'Electricity', 'Groceries'],
                        _selectedSection, (newValue) {
                      setState(() => _selectedSection = newValue);
                    }),
                    SizedBox(height: 20),
                    _buildDatePicker(context),
                    SizedBox(height: 20),
                    _buildTextField(
                        _amountController, 'Amount', TextInputType.number),
                    SizedBox(height: 20),
                    _buildTextField(
                        _remarksController, 'Remarks', TextInputType.text),
                    SizedBox(height: 20),
                    _buildAttachButton(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitTransaction,
                      child: Text('Submit Transaction'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      value: selectedValue,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return ListTile(
      title: Text('Date: ${DateFormat.yMd().format(_selectedDate)}'),
      trailing: Icon(Icons.calendar_today),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() => _selectedDate = picked);
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        keyboardType: keyboardType,
      ),
    );
  }

  Widget _buildAttachButton() {
    return OutlinedButton.icon(
      icon: Icon(Icons.camera),
      label: Text('Attach Image'),
      onPressed: _pickImage,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  void _submitTransaction() {
    // Handle transaction submission logic
    print('Transaction Type: $_selectedTransactionType');
    print('Section: $_selectedSection');
    print('Date: $_selectedDate');
    print('Amount: ${_amountController.text}');
    print('Remarks: ${_remarksController.text}');
    print('Image Path: ${_imageFile?.path}');
  }
}
