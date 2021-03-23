import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/postlist.dart';
import 'package:clicktimes/pages/posttile.dart';
import 'package:clicktimes/services/database.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<List<Post>>(
        stream: database.postStream(),
        builder: (context, snapshot) {
          return PostListItemsBuilder<Post>(
          snapshot: snapshot,
          itemBuilder: (context, post)=>Posttile(post: post,));
        }
      )
      
    );
  }
}
