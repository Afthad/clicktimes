import 'package:clicktimes/models/chatmodel.dart';
import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/chatroom.dart';
import 'package:clicktimes/pages/message.dart';
import 'package:clicktimes/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageService {
  createRoomMessage(BuildContext context, Database database,
      Usermodel usermodel, Usermodel postuser) async {
    List<String> users = [usermodel.uid, postuser.uid];

    String chatRoomId = getChatRoomId(usermodel.uid, postuser.uid);

    final chatroom = ChatRoomModel(
      chatRoomId: chatRoomId,
      users: users,
    );

    final chatrooms = await database.chatRoomget().first;
    final allchat = chatrooms.map((chatrooms) => chatrooms.chatRoomId).toList();
    if (!allchat.contains(chatRoomId)) {
      print('true');
      await database.createChatRoom(chatRoomId, chatroom);
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => Message(
                chatRoomId: chatRoomId,
                usermodel: usermodel,
                postuser: postuser,
                database: database,
              )));
    } else {
      print('false');
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => Message(
                chatRoomId: chatRoomId,
                usermodel: usermodel,
                database: database,
                postuser: postuser,
              )));
    }
  }

  addmessages(BuildContext context, TextEditingController controller,
      Database database, String chatRoomId, String uid) async {
    final chats = Chats(
        message: controller.text,
        sendBy: uid,
        time: Timestamp.fromDate(DateTime.now()));
    try {
      await FirebaseFirestore.instance.collection('ChatRoom').doc(chatRoomId).update({'message':controller.text,'time':DateTime.now(),'read':false,'sendBy':uid});
      await database.addChats(chats, chatRoomId);
      print(controller.text);
    
    } catch (e) {}
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
