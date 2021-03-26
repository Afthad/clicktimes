import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/pages/chatroom.dart';
import 'package:clicktimes/pages/message.dart';
import 'package:clicktimes/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageService {
  createRoomMessage(BuildContext context, Database database, String userid,
      String chaterid) async {
    List<String> users = [userid, chaterid];

    String chatRoomId = getChatRoomId(userid, chaterid);

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
                usermodel: userid,
                database: database,
              )));
    } else {
      print('false');
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => Message(
                chatRoomId: chatRoomId,
                usermodel: userid,
                database: database,
              )));
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
