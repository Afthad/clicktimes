import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/chatroomlist.dart';
import 'package:clicktimes/widgets/shimmerchatroom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message.dart';

class ChatRoom extends StatefulWidget {
  final Usermodel usermodel;

  const ChatRoom({Key key, this.usermodel}) : super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 10),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Chats',
                style: chatroomtitle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: StreamBuilder<List<ChatRoomModel>>(
                stream: database.chatRoomstreams(),
                builder: (context, snapshot) {
                  return ChatRoomsListItemsBuilder<ChatRoomModel>(
                      snapshot: snapshot,
                      itemBuilder: (context, chatroommodel) {
                        final String uid = chatroommodel.chatRoomId
                            .replaceAll("_", "")
                            .replaceAll(widget.usermodel.uid, "");
                        return StreamBuilder<Usermodel>(
                            stream: database.userStream(uid: uid),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) => Message(
                                                  chatRoomId:
                                                      chatroommodel.chatRoomId,
                                                  usermodel:
                                                      widget.usermodel.uid,
                                                  database: database,
                                                  
                                                )));
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(snapshot.data.profile),
                                  ),
                                  title: Text(snapshot.data.name),
                                  subtitle: Text(chatroommodel.message),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Text('5:30 pm'), Text('New')],
                                  ),
                                );
                              } else
                                return Container(
                                    height: double.infinity,
                                    child: ShimmerChatroom(itemcount: 1));
                            });
                      });
                }),
          ),
        ],
      ),
    );
  }
}
