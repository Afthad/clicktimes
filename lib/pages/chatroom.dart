import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/chatroomlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}


class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    final database=Provider.of<Database>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:20.0 ,left: 10),
            child: Container(
              alignment: Alignment.topLeft,
              
              child: Text('Chats',style: chatroomtitle,),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:60.0),
            child: StreamBuilder<List<ChatRoomModel>>(
              stream: database.chatRoomstreams(),
              builder: (context, snapshot) {
                return ChatRoomsListItemsBuilder<ChatRoomModel> (
                  snapshot: snapshot,
                  itemBuilder:(context ,chatroommodel)=>ListTile( 
                     leading: CircleAvatar(backgroundColor: Colors.grey,
                     radius: 25,

                     
                     ),
                     title: Text('Name'),
                     subtitle: Text('Message'),
                     trailing: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text('5:30 pm'),
                         Text('New')
                       ],
                     ), 
                  ));
              }
            ),
          ),
        ],
      ),
      
    );
  }
}