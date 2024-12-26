import 'package:flutter/material.dart';
import 'package:myfinance/screens/budget_screen.dart';
import 'package:myfinance/screens/expenses_types.dart';
import 'package:myfinance/screens/home_screen.dart';
import 'package:myfinance/screens/income_types.dart';
import 'package:myfinance/screens/transaction_screen.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  File? _profileImage;

  // Function to pick image from the camera
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('User Name'),
            accountEmail: Text('user@example.com'),
            currentAccountPicture: GestureDetector(
              onTap: _pickImage, // Trigger camera to pick an image
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Text('U', style: TextStyle(fontSize: 30.0))
                    : null,
              ),
            ),
            decoration: BoxDecoration(
              color: primaryColor,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.dashboard),
                  title: Text('Dashboard'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet),
                  title: Text('Transactions'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.trending_up),
                  title: Text('Budgets'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BudgetScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money_sharp),
                  title: Text('Income Types'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IncomeTypesScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.money_off),
                  title: Text('Expense Types'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpensesTypesScreen()));
                  },
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign Out'),
            onTap: () {
              handleLogout();
              // Handle sign-out functionality
            },
          ),
        ],
      ),
    );
  }

  void handleLogout() {
    // Handle sign-out functionality
    // Redirect to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }
}
