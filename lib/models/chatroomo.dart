

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomModelother{
  final String chatRoomId;
  final String message;
  final String sendBy;
  final  bool read;
  final Timestamp time;
  final dynamic users;

  ChatRoomModelother({@required this.chatRoomId, this.message, this.sendBy, this.read, this.time,@required this.users});

  factory ChatRoomModelother.fromMap(Map<String,dynamic>data,String documentID){
      final String chatRoomId =data['chatRoomId'];
  final String message=data['message'];
  final String sendBy=data['sendBy'];
  final  bool read=data['read'];
  final Timestamp time=data['time'];
  final dynamic users =data['users'];
    return ChatRoomModelother(chatRoomId:chatRoomId,message: message,sendBy: sendBy,time: time,users: users,read: read );
  }

  Map<String, dynamic> toMap() {

     return{
           'message':message,
           'sendBy':sendBy,
           'time':time,
           'read':read,
           'users':users,
           'chatRoomId':chatRoomId

     };
   }
}