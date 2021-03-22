

import 'package:clicktimes/services/auth.dart';
import 'package:clicktimes/pages/homepage.dart';
import 'package:clicktimes/pages/loginpage.dart';
import 'package:clicktimes/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              child: Homepage(uid:user.uid),
            );;
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
