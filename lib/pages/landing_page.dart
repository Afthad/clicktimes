

import 'package:clicktimes/pages/selctorpage.dart';
import 'package:clicktimes/pages/splashscreen.dart';
import 'package:clicktimes/services/auth.dart';
import 'package:clicktimes/pages/registrationpage.dart';
import 'package:clicktimes/pages/loginpage.dart';
import 'package:clicktimes/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Loginpage();
            }
             return Provider<Database>(
              create: (_) => FirestoreDatabase(uid: user.uid),
              child: Selectorpage(uid:user.uid)
            );;
          } else {
            return SplashScreen();
          }
        });
  }
}
