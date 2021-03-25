
import 'package:flutter/material.dart';

class InputDropdown extends StatelessWidget {
  const InputDropdown({
    Key key,
    this.valueText,
    this.valueStyle,
    this.onPressed,
  }) : super(key: key);


  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Text(valueText, style: valueStyle),
    );
  }
}
