import 'package:clicktimes/constant.dart';
import 'package:clicktimes/widgets/shimmer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class SearchItemsBuilder<T> extends StatelessWidget {
  const SearchItemsBuilder({
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
        return Center(child: Text('No data',style: nochats,));
      }
    } else if (snapshot.hasError) {
      return Container(child:Text('Something Went Wrong',style: nochats,),);
    }
    return Center(child: CircularProgressIndicator(backgroundColor: kPrimaryColor,strokeWidth: 1,),);
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
