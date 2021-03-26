import 'package:clicktimes/widgets/shimmer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ChatListItemsBuilder<T> extends StatelessWidget {
  const ChatListItemsBuilder({
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
        return Text('No Chats');
      }
    } else if (snapshot.hasError) {
      return Container(child:Text(snapshot.error.toString()),);
    }
    return Text('Something Went Wrong');
  }

  Widget _buildList(List<T> items) {
    
    return ListView.builder(
      reverse: true,
      dragStartBehavior: DragStartBehavior.start,
      itemCount: items.length,
      
     //separatorBuilder: (context, index) => Divider(height: 0.5),
      itemBuilder: (context, index) {
     
        return itemBuilder(context, items[index]);
      },
    );
  }
}
