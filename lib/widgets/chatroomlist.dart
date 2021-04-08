import 'package:clicktimes/widgets/shimmer.dart';
import 'package:clicktimes/widgets/shimmerchatroom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clicktimes/constant.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ChatRoomsListItemsBuilder<T> extends StatelessWidget {
  const ChatRoomsListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData ) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return Center(child: Text('No Messages',style: nochats,));
      }
    } else if (snapshot.hasError) {
      return Container(child:Text('Something Went Wrong',style: nochats,),);
    }
    return ShimmerChatroom (itemcount: 9,);
  }

  Widget _buildList(List<T> items) {
     return ListView.separated(
      itemCount: items.length + 2,
      separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
    );
  }
}
