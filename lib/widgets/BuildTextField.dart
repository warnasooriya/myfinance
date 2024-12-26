import 'package:flutter/material.dart';

Widget BuildTextField(TextEditingController controller, String label,
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
