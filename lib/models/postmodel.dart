import 'package:flutter/material.dart';

class Post {
  final String caption;
  final String posturl;
  final String postId;
  final String uid;
  final String username;
  final dynamic likes;

  Post(
      {@required this.caption,
      @required this.posturl,
      @required this.postId,
      @required this.uid,
      @required this.username,
      @required this.likes});
  factory Post.fromMap(Map<String, dynamic> data, String documentId) {
    final String caption = data['caption'];
    final String posturl = data['posturl'];
    final String postId = data['postId'];
    final String uid = data['uid'];
    final String username = data['username'];
    final dynamic likes = data['likes'];
    return Post(
        caption: caption,
        posturl: posturl,
        postId: postId,
        uid: uid,
        username: username,
        likes: likes);
  }
  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'postId': postId,
      'posturl': posturl,
      'uid': uid,
      'username': username,
      'likes': {}
    };
  }
}
