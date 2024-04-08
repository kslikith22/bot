import 'package:flutter/material.dart';

void snackBar({required context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
