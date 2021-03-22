
import 'package:clicktimes/freelancer/tabfreelancer.dart';
import 'package:flutter/material.dart';

import 'freelancerScaffold.dart';

class HomePage extends StatefulWidget {
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
      FTabItem.feeds: (_) => Container(),
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
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

}
