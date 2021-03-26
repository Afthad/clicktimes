import 'package:clicktimes/pages/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chats{


  final String message;
  final String sendBy;
  final  Timestamp time;

  

  Chats({  @required this.message,@required this.sendBy,@required this.time, });


  factory Chats.fromMap(Map<String,dynamic>data,String documentID){
   
   final String message=data['message'];
  final String sendBy=data['sendBy'];
  final  Timestamp time=data['time'];

 return Chats(message: message, sendBy: sendBy, time: time,);
  }

   Map<String, dynamic> toMap() {

     return{
           'message':message,
           'sendBy':sendBy,
           'time':time,
  
     };
   }
}