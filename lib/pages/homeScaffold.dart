import 'package:clicktimes/services/tabfreelancer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.widgetBuilders,
    @required this.navigatorKeys,
  }) : super(key: key);

  final FTabItem currentTab;
  final ValueChanged<FTabItem> onSelectTab;
  final Map<FTabItem, WidgetBuilder> widgetBuilders;
  final Map<FTabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    //int index=0;
    return CupertinoTabScaffold(
      
      backgroundColor: Colors.white,
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              activeIcon: SvgPicture.asset('images/Home.svg'),
              icon: SvgPicture.asset('images/Homeout.svg')),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('images/Postout.svg'),
              activeIcon: SvgPicture.asset('images/Post.svg')),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('images/Messageout.svg'),
              activeIcon: SvgPicture.asset('images/Message.svg')),
          BottomNavigationBarItem(
              icon: CircleAvatar(
            radius: 12,
          ))
        ],
        onTap: (index) => onSelectTab(FTabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final item = FTabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item],
          builder: (context) => widgetBuilders[item](context),
        );
      },
    );
  }
}
