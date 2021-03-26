import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerChatroom extends StatefulWidget {
  final int itemcount;

  const ShimmerChatroom({Key key, this.itemcount}) : super(key: key);
  @override
  _ShimmerChatroomState createState() => _ShimmerChatroomState();
}

class _ShimmerChatroomState extends State<ShimmerChatroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(backgroundColor: Colors.grey,
                     radius: 25,

                     
                     ),
                     title: Container(height: 10,width: 70,color: Colors.white,),

                     subtitle: Container(height: 10,width: 70,color: Colors.white,),
                     trailing: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(height: 10,width: 20,color: Colors.white,),
                        Container(height: 10,width: 20,color: Colors.white,),
                       ],
                     ), 
                      ),
             

                      ),
                      itemCount: widget.itemcount,
                      ),
                    
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}
