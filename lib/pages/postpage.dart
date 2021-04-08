import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/blocs/feedsbloc.dart';
import 'package:clicktimes/widgets/postlist.dart';
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
  Allbloc postsbloc =Allbloc(database:database);
       return StreamBuilder<List<PostUser>>(
          stream:postsbloc.allPostsStream(),
          builder: (context, snapshot) {
            return PostListItemsBuilder<PostUser>(
            snapshot: snapshot,
            itemBuilder: (context, post)=>
            Posttile(
              userpost: post.usermodel,
              post: post.post,usermodel: widget.usermodel,database:database,));
            
            }
      );

  }
    
  
}
