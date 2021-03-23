import 'package:clicktimes/constant.dart';
import 'package:flutter/material.dart';

class Profilecontents extends StatefulWidget {
  final String contentname;
  final String content;
  final VoidCallback onPressed;

  const Profilecontents(
      {Key key,
      @required this.contentname,
      @required this.content,
      this.onPressed})
      : super(key: key);
  @override
  _ProfilecontentsState createState() => _ProfilecontentsState();
}

class _ProfilecontentsState extends State<Profilecontents> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: widget.onPressed,
      title: Text(
        widget.contentname,
        style: prodilecontent1,
      ),
      trailing: Text(widget.content, style: paragraphmedium2),
    );
  }
}
