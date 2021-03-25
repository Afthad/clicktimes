import 'package:flutter/material.dart';

class Snackbar extends StatelessWidget {
  final String label;

  const Snackbar({Key key, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Text(label));
  }
}