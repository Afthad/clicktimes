import 'package:clicktimes/pages/landing_page.dart';
import 'package:clicktimes/pages/paytm.dart';
import 'package:clicktimes/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
         create: (context) => Auth(),
          child: MaterialApp(
        title: 'ClickTimes',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: LandingPage(),
      ),
    );
  }
}

