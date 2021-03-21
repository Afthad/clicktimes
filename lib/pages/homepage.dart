import 'package:clicktimes/login/auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  final AuthBase authBase;

  const Homepage({Key key, this.authBase}) : super(key: key);
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
    );
  }
}