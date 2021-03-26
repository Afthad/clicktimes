import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sendBy;
  final String chatRoomId;
final DateTime time;
final Usermodel usermodel;
final Database database;

bool sendByMe;

  MessageTile({ @required this.message, @required this.sendBy,@required this.time,@required this.chatRoomId,@required this.database,@required this.usermodel});

reads()async{
  if(sendBy!=usermodel.uid ){
     await  FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomId).update({'read':true});
  }
}
  @override
  Widget build(BuildContext context) {
 
    if(usermodel.uid==sendBy){
      sendByMe=true;
    }else {sendByMe=false;}
    reads();
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 8,
              bottom: 3,
              left: sendByMe ? 0 : 24,
              right: sendByMe ? 24 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: sendByMe
                ? EdgeInsets.only(left: 30)
                : EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(
                top: 17, bottom: 17, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: sendByMe ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23)
                ) :
                BorderRadius.only(
            topLeft: Radius.circular(23),
              topRight: Radius.circular(23),
              bottomRight: Radius.circular(23)),
                color: sendByMe?kPrimaryColor:kPrimaryColor
                ),
          
            child: Text(message,
                textAlign: TextAlign.start,
                style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300)),
          ),
        ),

        sendByMe?
        Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              
              Text( DateFormat.yMd().add_jm().format(time),style: times,),
            ],
          ),
        ):  Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Text( DateFormat.yMd().add_jm().format(time),style: times,),
            ],
          ),
        )
      ],
    );
  }
}