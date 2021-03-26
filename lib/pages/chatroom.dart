import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/chatroomlist.dart';
import 'package:clicktimes/widgets/shimmerchatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      body: LayoutBuilder(
      builder: (context,BoxConstraints constraints){ 
        return
        Stack(
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
                                                        widget.usermodel,
                                                    database: database,
                                                    postuser:snapshot.data,
                                                    
                                                  )));
                                    },
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(snapshot.data.profile),
                                    ),
                                    title: Text(snapshot.data.name),
                                    subtitle:chatroommodel.sendBy== widget.usermodel.uid? Text('You : '+ chatroommodel.message
                                    ,overflow: TextOverflow.ellipsis,
                                    ):Text(snapshot.data.name+" : "+chatroommodel.message,overflow: TextOverflow.ellipsis,)
                                    ,
                                    trailing: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        
                                        Text('${dateformat(chatroommodel.time)}',style: timechat,),
                                        SizedBox( height:3), 
                                        chatroommodel.sendBy!=widget.usermodel.uid && chatroommodel.read==false?
                                        Container(
                                          height: 20,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: kPrimaryColor
                                            
                                          ),
                                          alignment: Alignment.center,
                                          child: Text('NEW'
                                          ,
                                          textAlign: TextAlign.center,
                                          style:neW
                                          ),
                                        ):Container(height: 0,width: 0,)
                                        
                                        ],
                                    ),
                                  );
                                } else
                                  return Container(
                                     height: constraints.maxHeight,
                                      child: ShimmerChatroom(itemcount: 1));
                              });
                        });
                  }),
            ),
          ],
        );}
      ),
    );
  }
}


String dateformat(Timestamp date){

 if(DateTime.now().difference(date.toDate()).inDays<=1){
   return DateFormat.jm().format(date.toDate());}
 else if(DateTime.now().difference(date.toDate()).inDays>1 && DateTime.now().difference(date.toDate()).inDays<=7 ){
      return DateFormat.EEEE().format(date.toDate());
 }
 else return DateFormat.yMd().format(date.toDate());
 }

