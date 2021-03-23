
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/postpage.dart';
import 'package:clicktimes/services/tabfreelancer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

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
      FTabItem.feeds: (_) => Feedspage(usermodel: widget.usermodel,),
      FTabItem.post: (_) => Container(),
      FTabItem.message: (_) => Container(),
      FTabItem.profile: (_) => Container(),
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
        title: SvgPicture.asset('images/logo1.svg',cacheColorFilter: true,color: Colors.white,)

      ),
          body: WillPopScope(
        onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
        child: CupertinoHomeScaffold(

          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }

}
