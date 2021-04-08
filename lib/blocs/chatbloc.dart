// import 'package:clicktimes/models/chatmodel.dart';
// import 'package:clicktimes/pages/message.dart';
// import 'package:clicktimes/pages/messagetile.dart';
// import 'package:clicktimes/services/database.dart';
// import 'package:flutter/material.dart';

// class Chatbloc{

//   Chatbloc({this.chatRoomId, @required this.database});
//   final Database database;
//   final String chatRoomId;

// Stream<List<Chats>> get _allchatbydate => database.chatsStreams(chatRoomId);



//   Stream<List<MessageTile>> get messageTileModelStream =>
//       _allchatbydate.map(_createModels);


  
//    List<MessageTile> _createModels(List<Chatbydate> allchats) {
//     final allchats = Chatbydate;




//     }}
// class Chatbydate{
//   final List<Chats> chats;
//   final DateTime time;

//   Chatbydate(this.chats, this.time,);


//  static Map<DateTime, List<Chats>> _entriesByDate(List<Chats> chats) {
//     Map<DateTime, List<Chats>> map = {};
//     for (var chatstime in chats) {
//       final entryDayStart = DateTime(chatstime.time.toDate().year,
//           chatstime.time.toDate().year, chatstime.time.toDate().year);
//       if (map[entryDayStart] == null) {
//         map[entryDayStart] = [chatstime];
//       } else {
//         map[entryDayStart].add(chatstime);
//       }
//     }
//     return map;
//   }


//   static List<Chatbydate> all(List<Chats> chats) {
//     final byDate = _entriesByDate(chats);
//     List<Chatbydate> list = [];
//     for (var date in byDate.keys) {
//       final chatByDate = byDate[date];
//       final chats = chatByDate.toList();
//       list.add(Chatbydate(chats,chatByDate));
//     }
//     return list.toList();
//   }

// }