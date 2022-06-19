import 'package:flutter/material.dart';

class DialogAction {
  DialogAction(
      {required this.text, required this.callback, required this.isPositive});
  bool isPositive;
  String text;
  VoidCallback callback;
}
