

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoomModel{
  final String chatRoomId;
  final String message;
  final String sendBy;
  final  bool read;
  final Timestamp time;
  final List<String>users;

  ChatRoomModel({@required this.chatRoomId, this.message, this.sendBy, this.read, this.time,@required this.users});

  factory ChatRoomModel.fromMap(Map<String,dynamic>data,String documentID){
      final String chatRoomId =data['chatRoomId'];
  final String message=data['message'];
  final String sendBy=data['sendBy'];
  final  bool read=data['read'];
  final Timestamp time=data['time'];
  final List<String>users =data['users'];
    return ChatRoomModel(chatRoomId:chatRoomId,message: message,sendBy: sendBy,time: time,users: users,read: read );
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