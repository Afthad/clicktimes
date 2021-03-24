import 'package:clicktimes/widgets/shimmer.dart';
import 'package:clicktimes/widgets/shimmergrid.dart';
import 'package:flutter/material.dart';


typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class GridListItemsBuilder<T> extends StatelessWidget {
  const GridListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      } else {
        return ShimmerPostGrid(itemcount: 9,);
      }
    } else if (snapshot.hasError) {
      return ShimmerPostGrid(itemcount: 9,);
    }
    return ShimmerPostGrid(itemcount: 9,);
  }

  Widget _buildList(List<T> items) {
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
       
      ), 
      itemCount: items.length ,
        key: PageStorageKey(key),
      itemBuilder: (context, index) {
       
        return itemBuilder(context, items[index]);
      },
    );
  }
}