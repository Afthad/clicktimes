import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/home.dart';
import 'package:clicktimes/pages/registrationpage.dart';
import 'package:clicktimes/pages/splashscreen.dart';
import 'package:clicktimes/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Selectorpage extends StatefulWidget {
  final String uid;
  final String photourl;

  const Selectorpage({Key key, @required this.uid, @required this.photourl}) : super(key: key);
  @override
  _SelectorpageState createState() => _SelectorpageState();
}

class _SelectorpageState extends State<Selectorpage> {
  @override
  Widget build(BuildContext context) {
    final database =Provider.of<Database>(context);
return StreamBuilder<Usermodel>(
  stream: database.userStream(uid: widget.uid),
  builder: (context, snapshot) {
    if(snapshot.hasData && snapshot.connectionState==ConnectionState.active){
  return      HomePage(usermodel: snapshot.data,userurl:widget.photourl,);}
    if(snapshot.data==null && snapshot.connectionState==ConnectionState.active){
      return Registrationpage(uid: widget.uid,photourl:widget.photourl);
    } 
    if(snapshot.hasError  || !snapshot.hasData || snapshot.connectionState==ConnectionState.none){
      return SplashScreen();
    }
    else  return SplashScreen();
  }
);
  }
}