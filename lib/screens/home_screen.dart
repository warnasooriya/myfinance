import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myfinance/services/auth_service.dart';
import 'package:myfinance/utils/constants.dart';
import 'package:graphic/graphic.dart';
import 'package:myfinance/widgets/BuildBarChart.dart';
import 'package:myfinance/widgets/BuildDrawer.dart';
import 'package:myfinance/widgets/BuildRoseChart.dart';

import '../widgets/MyDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Random random = Random();
  List<Map> barAnimData = [];
  List<Map> roseData = [];
  List<List> scatterAnimData = [];

  @override
  void initState() {
    super.initState();
    _initializeChartData();
  }

  void _initializeChartData() {
    barAnimData = List.generate(
        5,
        (index) => {
              'genre': [
                'Sports',
                'Strategy',
                'Action',
                'Shooter',
                'Other'
              ][index],
              'sold': random.nextInt(300)
            });
    roseData = List.generate(
        10,
        (index) => {
              'name': String.fromCharCode(65 + index),
              'value': random.nextDouble()
            });
    scatterAnimData = List.generate(
        14,
        (index) => [
              random.nextInt(50000),
              random.nextDouble() * 80,
              random.nextInt(1000000000),
              'Country',
              random.nextInt(2) * 2 - 1
            ]);
  }

  Widget _buildChartCard(Widget chart, String title) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 250,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var isDarkMode = themeData.brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Finance'),
        backgroundColor: primaryColor,
        foregroundColor: headerTextColor,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: _buildBalanceTile(
                      'Income',
                      '500000',
                      Icon(
                        Icons.account_balance_wallet,
                        color: Colors.green[700],
                        size: 30,
                      ),
                      Colors.white as Color),
                ),
                Expanded(
                  child: _buildBalanceTile(
                      'Expenses',
                      '75500000',
                      Icon(
                        Icons.inbox,
                        color: Colors.red[700],
                        size: 30,
                      ),
                      Colors.white as Color),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _buildBalanceTile(
                      'Savings',
                      '500000',
                      Icon(
                        Icons.account_balance,
                        color: const Color.fromARGB(255, 196, 9, 202),
                        size: 30,
                      ),
                      Colors.white as Color),
                ),
                Expanded(
                  child: _buildBalanceTile(
                      'Budget',
                      '500000',
                      Icon(
                        Icons.account_balance_wallet,
                        color: const Color.fromARGB(255, 116, 16, 205),
                        size: 30,
                      ),
                      Colors.white as Color),
                ),
              ],
            ),
            // Generated code for this Column Widget...
            _buildChartCard(BuildRoseChart(roseData), 'Expenditure'),
            // _buildChartCard(BuildBarChart(barAnimData), 'Income'),
            Column(
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceTile(label, value, icon, Color color) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x4B1A1F24),
              offset: Offset(
                0.0,
                2,
              ),
            )
          ],
          gradient: LinearGradient(
            colors: [primaryColor, color],
            stops: [0, 1],
            begin: AlignmentDirectional(0.94, -1),
            end: AlignmentDirectional(-0.94, 1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: <Widget>[
              ListTile(
                title:
                    Text(label, style: TextStyle(fontStyle: FontStyle.italic)),
                subtitle: Text(
                  double.parse(value).toStringAsFixed(2),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                leading: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingBillsTile() {
    return ListTile(
      title:
          Text('Upcoming Bills', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('\$200 due on 15th Nov'),
      leading: Icon(Icons.calendar_today, color: primaryColor),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
