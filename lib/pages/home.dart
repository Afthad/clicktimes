import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/postpage.dart';
import 'package:clicktimes/pages/profile.dart';
import 'package:clicktimes/pages/uploadpage.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/firestore_service.dart';
import 'package:clicktimes/services/tabfreelancer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'booking.dart';
import 'chatroom.dart';
import 'homeScaffold.dart';

class HomePage extends StatefulWidget {
  final Usermodel usermodel;

  const HomePage({Key key, @required this.usermodel}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FTabItem _currentTab = FTabItem.feeds;

  final Map<FTabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    FTabItem.feeds: GlobalKey<NavigatorState>(),
    FTabItem.post: GlobalKey<NavigatorState>(),
    FTabItem.message: GlobalKey<NavigatorState>(),
    FTabItem.profile: GlobalKey<NavigatorState>(),
  };

  Map<FTabItem, WidgetBuilder> get widgetBuilders {
    return {
      FTabItem.feeds: (_) => Feedspage(
            usermodel: widget.usermodel,
          ),
      FTabItem.post: (_) {
        if (widget.usermodel.role == 'Freelancer') {
          return Uploadpage(
            usermodel: widget.usermodel,
          );
        } else if (widget.usermodel.role == 'Customer') {
          return Container();
        } else
          return Booking();
      },
      FTabItem.message: (_) => ChatRoom(
            usermodel: widget.usermodel,
          ),
      FTabItem.profile: (_) {
        return Profile(
          usermodel: widget.usermodel,
        );
      }
    };
  }

  void _select(FTabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'images/logo.svg',
              cacheColorFilter: true,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: widget.usermodel.available == true
                  ? MaterialButton(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.usermodel.uid)
                            .update({'available': false});
                      },
                      child: Text(
                        'AVAILABLE',
                        style: paragraphmedium10,
                      ),
                      color: kSuccessColorPayment,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    )
                  : MaterialButton(
                      onPressed: () async {
                        FirebaseFirestore.instance
                            .collection('Users')
                            .doc(widget.usermodel.uid)
                            .update({'available': true});
                      },
                      child: Text(
                        'ON WORK',
                        style: paragraphmedium10,
                      ),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  iconSize: 13,
                  icon: SvgPicture.asset(
                    'images/Notificationout.svg',
                    color: kPrimaryColor,
                  ),
                  onPressed: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        titlePadding: EdgeInsets.only(top:20,left: 20,right: 20),
                       
                            title: Text(
                              'Want to Change Role ?',
                              style: dialoghead,
                              textAlign: TextAlign.center,
                            ),
                            contentPadding: EdgeInsets.all(10),
                            content: Text(
                              'Are your sure that you want to change your role from' +
                                  ' ${widget.usermodel.role}. By continuing this  will lose all data belongs to you',
                              style: paragraphmedium1,
                              textAlign: TextAlign.center,
                            ),
                            actionsPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            actions: [
                              SizedBox(
                                width: .7 * MediaQuery.of(context).size.width,
                                child: MaterialButton(
                                  onPressed: () {},
                                  child: Text('Continue'),
                                  height: 40,
                                  color: kPrimaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              )
                            ],
                          ));
                },
                child: CircleAvatar(
                  child: widget.usermodel.role == 'Freelancer'
                      ? Text(
                          'FL',
                          style: frcu,
                        )
                      : widget.usermodel.role == 'Customer'
                          ? Text(
                              'CU',
                              style: frcu,
                            )
                          : Text(
                              'CT',
                              style: frcu,
                            ),
                  radius: 13,
                  backgroundColor: kPrimaryColor,
                ),
              ),
            )
          ]),
      body: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab].currentState.maybePop(),
        child: CupertinoHomeScaffold(
          usermodel: widget.usermodel,
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }
}
