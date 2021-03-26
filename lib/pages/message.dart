import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/chatmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/widgets/chatllist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'messagetile.dart';

class Message extends StatefulWidget {
  final String chatRoomId;
  final Database database;
  final String usermodel;

  const Message({Key key, @required this.chatRoomId,@required this.database,@required this.usermodel}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kchatbackground,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(widget.chatRoomId, style: TextStyle(fontSize: 6,color: Colors.black),),
      ),
       body: 
      Stack(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom:60),
            child: StreamBuilder<List<Chats>>(
             // initialData: null,
              stream: widget.database.chatsStreams(widget.chatRoomId),
              builder: (context, snapshot) {
                return ChatListItemsBuilder<Chats>(
                  snapshot: snapshot,
                  itemBuilder: (snapshots,chats)=>
                                 MessageTile(
                                   message: chats.message,
                                   sendByMe: chats.sendBy==widget.usermodel,
                                   time:chats.time.toDate()
                                 )
                );
              }
         ),
          ),
          Container(
            
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      
                      maxLength: 600,
                      maxLines: null,
                      autocorrect:true,
                      autofocus: false,
                      decoration: InputDecoration(
                       fillColor: Colors.white,
                       hintText: 'Type Something..',
                       filled: true,
                       isDense: true,
                       contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                         focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color:kPrimaryColor,
                          width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      
                      ),),
                        counterText: ''
                      ),
                      
                    ),
                  )),
                  CircleAvatar(
                  
                    backgroundColor: kPrimaryColor,
                    child: SvgPicture.asset('images/Send.svg',color: Colors.white,height: 19,),
                  )
                ],
              ),
            ),
          ),
       ],
      ),
    );
  }
}
