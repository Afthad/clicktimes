import 'package:clicktimes/login/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class Loginpage extends StatefulWidget {

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  @override
  Widget build(BuildContext context) {
    final auth =Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
    
          children: [
          ///  SvgPicture.asset('images/logo.svg',),
            Text('Click Times',style: kHeading,),
            SizedBox(height: 20,),
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50) ,
              child: MaterialButton(onPressed: (){
              auth.signInWithGoogle();
              },
              color: kPrimaryColor,
              splashColor: null,
              elevation: 1,
              highlightColor: null,
              focusElevation: 0.0,
              highlightElevation: 0.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    IconButton(icon: SvgPicture.asset('images/google.svg',color: Colors.white,), onPressed:null),
                    Text('Signup with Google ',style: paragraphmedium,)
                ],
              ),
              
              ),
            )


          ],
        ),
      ),
      
    );
  }
}