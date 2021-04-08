import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/profilefreelancer.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/messageservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Hirepag.dart';

class Posttile extends StatefulWidget {
  final Post post;
  final Usermodel usermodel;
  final Usermodel userpost;
  final Database database;

  const Posttile(
      {Key key,
      @required this.database,
      @required this.userpost,
      @required this.post,
      @required this.usermodel})
      : super(key: key);
  @override
  _PosttileState createState() => _PosttileState(
      caption: post.caption,
      likes: post.likes,
      postId: post.postId,
      posturl: post.posturl,
      uid: post.uid,
      username: post.username,
      likeCount: post.getLikeCount(post.likes),
      usercurrent: usermodel.uid
      );
}

class _PosttileState extends State<Posttile>   {
  MessageService _service =MessageService();
  final String caption;
  final String posturl;
  final String postId;
  final String uid;
  final String username;
  Map<String,dynamic> likes;
  int likeCount;
  bool isLiked;
  final String usercurrent;

  _PosttileState(
      {this.caption,
      this.posturl,
      this.postId,
      this.uid,
      this.username,
      this.likes,
      this.likeCount,
      this.usercurrent
      });

  handleLikePost() {
    bool _isLiked = likes[usercurrent] == true;

    if (_isLiked) {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.post.postId)
          .update({'likes.$usercurrent': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[usercurrent] = false;
      });
    } else if (!_isLiked) {
      FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.post.postId)
          .update({'likes.$usercurrent': true});
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[usercurrent] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
 

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          horizontalTitleGap: 10,
          leading: CircleAvatar(
            backgroundColor: kSecondary,

            //foregroundColor: Colors.grey,
            radius: 25,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 23,
              backgroundImage: NetworkImage(widget.userpost.profile),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileFreelancer(
                          post: widget.post,
                          usermodel: widget.usermodel,
                          postuser: widget.userpost,
                          database: widget.database,
                        )),
              );
            },
            child: Text(
              widget.userpost.name,
              style: posttitlename,
            ),
          ),
          subtitle: Text(
            widget.userpost.location,
            style: posttitlesub,
          ),
          trailing: widget.usermodel.uid!=widget.userpost.uid? IconButton(
              icon: SvgPicture.asset('images/Messageout.svg'),
              onPressed: () {

                  _service.createRoomMessage(context, widget.database, widget.usermodel, widget.userpost);
              }):IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {

                  _service.createRoomMessage(context, widget.database, widget.usermodel, widget.userpost);
              }),
        ),
        SizedBox(
          height: 5,
        ),
        Center(
            child: Image.network(
          widget.post.posturl,
          frameBuilder: (BuildContext context, Widget child, int frame,
              bool wasSynchronouslyLoaded) {
            return Padding(
              padding: EdgeInsets.all(0.0),
              child: child,
            );
          },
          errorBuilder:
              (BuildContext context, Object exception, StackTrace stackTrace) {
            return Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Icon(Icons.error)),

            
            );
          },
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null)
              return Container(height: 250, child: child);

            return Container(
              height: 250,
              child: Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                                  child: CircularProgressIndicator(
                    strokeWidth: .8,
                    // backgroundColor: kPrimaryColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                ),
              ),
            );
          },
        )),
        SizedBox(
          height: 5,
        ),
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
          leading: IconButton(
            iconSize: 30,
            icon: Icon(
                 likes[usercurrent] == true? Icons.star : Icons.star_border,
              color: kstartcolour,
            ),
            onPressed: handleLikePost,
          ),
          title: Text(
            '$likeCount Clicks',
            style: paragraphmedium2,
          ),
          horizontalTitleGap: 1,
          trailing:widget.usermodel.role!='Customer' ?Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () =>
                Hirepage.show(context, widget.database, widget.usermodel, widget.userpost),
              
              child: Text(
                'Hire',
                style: hirebutton,
              ),
              highlightColor: hirebuttoncolour,
              color: hirebuttoncolour,
              elevation: 0.0,
              highlightElevation: 0.0,
              focusElevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          ):Container(height: 0,width: 0,),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 8),
          child: Text(
            widget.post.caption,
            style: paragraphmedium4,
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
