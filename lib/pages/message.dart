import 'package:clicktimes/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Message extends StatefulWidget {
  final String chatRoomId;

  const Message({Key key, @required this.chatRoomId}) : super(key: key);
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
        title: Text('HEllo', style: headerappbar),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text('ddd'),
          ),
          Padding(
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
        ],
      ),
    );
  }
}
