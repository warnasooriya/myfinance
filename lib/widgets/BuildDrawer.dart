import 'package:flutter/material.dart';
import 'package:myfinance/screens/budget_screen.dart';
import 'package:myfinance/screens/expenses_types.dart';
import 'package:myfinance/screens/home_screen.dart';
import 'package:myfinance/screens/income_types.dart';
import 'package:myfinance/screens/transaction_screen.dart';
import 'package:myfinance/utils/constants.dart';

Drawer BuildDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('User Name'),
          accountEmail: Text('user@example.com'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('U'),
          ),
          decoration: BoxDecoration(
            color: primaryColor,
          ),
        ),
        ListTile(
          leading: Icon(Icons.dashboard),
          title: Text('Dashboard'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.account_balance_wallet),
          title: Text('Transactions'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TransactionScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.trending_up),
          title: Text('Budgets'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BudgetScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.money_sharp),
          title: Text('Income Types'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => IncomeTypesScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.money_off),
          title: Text('Expense Types'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExpensesTypesScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Sign Out'),
          onTap: () {},
        ),
      ],
    ),
  );
}
