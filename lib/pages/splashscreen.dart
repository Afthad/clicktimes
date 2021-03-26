import 'package:clicktimes/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
    
          children: [
           SvgPicture.asset('images/logo.svg',height: 70,fit: BoxFit.fill,),
            SizedBox(height: 10,),
            Text('Click Times',style: kHeading,),
            SizedBox(height: 20,),
            CircularProgressIndicator(backgroundColor: kPrimaryColor,)
          ]
              
              ),
            )

        
    
      
    );
  }
}