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
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _initializeChartData();
    _setupTimer();
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

  void _setupTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        _initializeChartData();
      });
    });
  }

  Widget _buildChartCard(Widget chart, String title) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
              height: 300,
              child: chart,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Finance'),
        backgroundColor: primaryColor,
      ),
      drawer: BuildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildChartCard(BuildBarChart(barAnimData), 'Monthly Income'),
            _buildChartCard(BuildRoseChart(roseData), 'Income Vs Expenditure'),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceTile() {
    return ListTile(
      title: Text('Balance', style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('\$5000'),
      leading: Icon(Icons.account_balance_wallet, color: primaryColor),
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
    timer.cancel();
    super.dispose();
  }
}
