import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/postlist.dart';
import 'package:clicktimes/pages/posttile.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feedspage extends StatefulWidget {
  final Usermodel usermodel;

  const Feedspage({Key key, @required this.usermodel}) : super(key: key);
  @override
  _FeedspageState createState() => _FeedspageState();
}

class _FeedspageState extends State<Feedspage> {
  @override
  Widget build(BuildContext context) {
    final database=Provider.of<Database>(context);
    return  LayoutBuilder(
      builder: (context,BoxConstraints constraints){

       return StreamBuilder<List<Post>>(
          stream: database.postStream(),
          builder: (context, snapshot) {
            return Container(
              child: PostListItemsBuilder<Post>(
              snapshot: snapshot,
              itemBuilder: (context, post)=>StreamBuilder<Usermodel>(
                stream: database.userStream(uid: post.uid),
                builder: (context, snapshot) {
                  if(snapshot.hasData && snapshot.connectionState==ConnectionState.active){
                  return Posttile(post: post,usermodel: widget.usermodel,);}
                  return Container(
                    height: constraints.maxHeight,

                    width: constraints.maxHeight,
                    child: ShimmerPost(itemcount: 1,));
                }
                
              )),
            );
          }
        
        
      );

      },
          
    );
  }
}
