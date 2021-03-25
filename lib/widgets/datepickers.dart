import 'dart:async';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key key,

    this.selectedDate,

    this.onSelectedDate, this.labelText,
 
  }) : super(key: key);

  final String  labelText;
  final DateTime selectedDate;

  final ValueChanged<DateTime> onSelectedDate;
 

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      onSelectedDate(pickedDate);
    }
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   final pickedTime = await showTimePicker(context: context, initialTime: selectedTime);
  //   if (pickedTime != null && pickedTime != selectedTime) {
  //     onSelectedTime(pickedTime);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(labelText,style: hiresubtitlename,),
            Text(DateFormat.yMEd().format(selectedDate),style:hiresubtitlename ,),

          ],
        ),
      onTap: () => _selectDate(context),
    );
  }
}
