import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:myfinance/routes/app_routes.dart';
import 'package:myfinance/utils/constants.dart';

void main() async {
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MyFinance(),
    ),
  );
}

class MyFinance extends StatelessWidget {
  const MyFinance({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: AppRoutes.getRoutes(),
    );
  }
}
