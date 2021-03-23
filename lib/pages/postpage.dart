import 'package:clicktimes/models/usermodel.dart';
import 'package:flutter/material.dart';

class Feedspage extends StatefulWidget {
  final Usermodel usermodel;

  const Feedspage({Key key, @required this.usermodel}) : super(key: key);
  @override
  _FeedspageState createState() => _FeedspageState();
}

class _FeedspageState extends State<Feedspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Text(widget.usermodel.uid)
      
    );
  }
}
