import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPost extends StatefulWidget {
  final int itemcount;

  const ShimmerPost({Key key, this.itemcount}) : super(key: key);
  @override
  _ShimmerPostState createState() => _ShimmerPostState();
}

class _ShimmerPostState extends State<ShimmerPost> {
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           ListTile(
          horizontalTitleGap: 10,
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
           
          ),
          title: Container(height: 10,width: 60,color: Colors.white,),
          subtitle: Container(height: 10,width: 30,color: Colors.white,),
          trailing: IconButton(
              icon: SvgPicture.asset('images/Messageout.svg'),
              onPressed: () {}),
        ),
        SizedBox(
          height: 5,
        ),

           Container(color: Colors.white,height: 200,width: MediaQuery.of(context).size.width,),

SizedBox(
          height: 5,
        ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Row(

    children: [
      Container(height: 20,width: 20,color: Colors.white,),
      SizedBox(width: 10,),
         Container(height: 10,width: 50,color: Colors.white,),
    ],
  ),
),
            
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Container(height: 10,width: MediaQuery.of(context).size.width,color: Colors.white,),
),
Padding(
  padding: const EdgeInsets.symmetric(horizontal:8.0),
  child:   Container(height: 10,width: MediaQuery.of(context).size.width,color: Colors.white,),
),

             ],

                      ),),
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
