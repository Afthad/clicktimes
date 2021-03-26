import 'package:clicktimes/constant.dart';
import 'package:clicktimes/models/chatmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/services/database.dart';
import 'package:clicktimes/services/messageservice.dart';
import 'package:clicktimes/widgets/chatllist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'messagetile.dart';

class Message extends StatefulWidget {
  final String chatRoomId;
  final Database database;
  final Usermodel usermodel;
  final Usermodel postuser;

  const Message({Key key,@required this.chatRoomId, @required this.postuser,@required this.database,@required this.usermodel}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController controller =TextEditingController();
  MessageService _service=MessageService();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: kchatbackground,
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(color:kPrimaryColor),
        backgroundColor: Colors.white,
        leadingWidth: 27,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(widget.postuser.profile),
            
            radius: 20,
            ),
            SizedBox(width: 10,),
            
            
                      Text(widget.postuser.name,style: headerappbar,)
          ],
        ),
        
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
                                   sendBy: chats.sendBy,
                                   time:chats.time.toDate(),
                                   chatRoomId:widget.chatRoomId,
                                   database:widget.database,
                                   usermodel:widget.usermodel,
      
                            
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
                      keyboardType: TextInputType.multiline,
                      controller: controller,
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
                  GestureDetector(
                    onTap: (){
               _service.addmessages(context, controller,widget.database,widget.chatRoomId,widget.usermodel.uid);
               controller.text=" " ;
                    },
                                      child: CircleAvatar(
                    
                      backgroundColor: kPrimaryColor,
                      child: SvgPicture.asset('images/Send.svg',color: Colors.white,height: 19,),
                    ),
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
