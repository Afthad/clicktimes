import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/models/chatroomo.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:clicktimes/pages/chatroom.dart';
import 'package:clicktimes/services/database.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
class Allbloc {
  Allbloc({@required this.database});
  final Database database;



  Stream<List<PostUser>> allPostsStream() => CombineLatestStream.combine2(
        database.postStream(),
        database.getuser(),
       _postsUserCombiner,
      );

  static List<PostUser> _postsUserCombiner(
        List<Post> posts, List<Usermodel> user) {
      return posts.map((post) {
        final users = user.firstWhere((user) =>user.uid == post.uid);
        return PostUser(post, users);
      }).toList();
    }


//       Stream<List<ChatUsers>> allChatroomStream() => CombineLatestStream.combine2(
//         database.chatRoomstreams(),
//         database.getuser(),
//         chatUser(chatRoom, user)
//       );

// static List<ChatUsers> chatUser(
//         List<ChatRoomModel> chatRoom, List<Usermodel> user) {
//       return chatRoom.map((chatRoom) {
//         final users = user.firstWhere((user) =>user.uid == chatRoom.chatRoomId.replaceAll("_", "").replaceAll(user.uid, ""));
//         return ChatUsers(chatRoom, users);
//       }).toList();
//     }
  
  
   //
    // Stream<List<EntriesListTileModel>> get entriesTileModelStream =>
    //     _allEntriesStream.map(_createModels);
  
 
    //   // total duration across all jobs
    //   final totalDuration = allDailyJobsDetails
    //       .map((dateJobsDuration) => dateJobsDuration.duration)
    //       .reduce((value, element) => value + element);
  
    //   // total pay across all jobs
    //   final totalPay = allDailyJobsDetails
    //       .map((dateJobsDuration) => dateJobsDuration.pay)
    //       .reduce((value, element) => value + element);
  
    //   return <EntriesListTileModel>[
    //     EntriesListTileModel(
    //       leadingText: 'All Entries',
    //       middleText: Format.currency(totalPay),
    //       trailingText: Format.hours(totalDuration),
    //     ),
    //     for (DailyJobsDetails dailyJobsDetails in allDailyJobsDetails) ...[
    //       EntriesListTileModel(
    //         isHeader: true,
    //         leadingText: Format.date(dailyJobsDetails.date),
    //         middleText: Format.currency(dailyJobsDetails.pay),
    //         trailingText: Format.hours(dailyJobsDetails.duration),
    //       ),
    //       for (JobDetails jobDuration in dailyJobsDetails.jobsDetails)
    //         EntriesListTileModel(
    //           leadingText: jobDuration.name,
    //           middleText: Format.currency(jobDuration.pay),
    //           trailingText: Format.hours(jobDuration.durationInHours),
    //         ),
    //     ]
    //   ];
    // }
  }
  
class PostUser{

final Post post;
final Usermodel usermodel;
  PostUser( this.post,this.usermodel,);
}
class ChatUsers{
final ChatRoomModel chatRoom;
final Usermodel usermodel;
  ChatUsers( this.chatRoom,this.usermodel,);
}