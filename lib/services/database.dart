import 'dart:async';

import 'package:clicktimes/models/booking.dart';
import 'package:clicktimes/models/chatmodel.dart';
import 'package:clicktimes/models/chatroommodel.dart';
import 'package:clicktimes/models/chatroomo.dart';
import 'package:clicktimes/models/hiremodel.dart';
import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'apipath.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setUser(Usermodel user);
  // Future<void> deleteJob(Job job);
  // Stream<List<Job>> jobsStream();
  Stream<Usermodel> userStream({@required String uid});
  Stream<List<Post>> postStream();
  Stream<List<Post>> selectedpostStream({@required String userid});
  Future<void> updateUser(Usermodel usermodel);
  Future<void> setHire(Hire hire,String orderid);
  Future<void> setBooking(Bookingmodel booking,String orderid);
  Future<void> createChatRoom(String chatRoomId, ChatRoomModel chatRoomModel);
  Stream<List<Chats>> chatsStreams(String chatRoomId);
  Stream<List<ChatRoomModelother>> chatRoomget();
  Stream<List<ChatRoomModel>> chatRoomstreams();
  Future<void> addChats(Chats chats, String chatRoomId);
  Future<void> addpost(Post post,String postid);
  Stream<List<Usermodel>> getuser();
  Future<void> deleteUser();
  Stream<List<Bookingmodel>> bookingstream();
  Future<void>deleteBooking(String orderid);
  Stream<List<Hire>> hiringstream();
  Future<void> deleteHiring(String orderid);
  Stream<List<Hire>>hiringstreamFreelance();
    Future<void> updateHirepayment(Hire hire,String orderid) ;
    Stream<Hire>hiringstreamselected(String orderid);
  // Future<void> setEntry(Entry entry);
  // Future<void> deleteEntry(Entry entry);
  // Stream<List<Entry>> entriesStream({Job job});

}

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> setUser(Usermodel usermodel) async => await _service.setData(
        path: APIPath.user(
          uid,
        ),
        data: usermodel.toMap(),
      );
  @override
  Future<void> addChats(Chats chats, String chatRoomId) async =>
      await _service.setData(
        path: APIPath.addchats(
          chatRoomId,documentIdFromCurrentDate() 
        ),
        data: chats.toMap(),
      );
  @override
  Future<void> createChatRoom(
          String chatRoomId, ChatRoomModel chatRoomModel) async =>
      await _service.setData(
        path: APIPath.createChatRoom(
          chatRoomId,
        ),
        data: chatRoomModel.toMap(),
      );
      @override
  Future<void> setHire(Hire hire,String orderid) async => await _service.setData(
        path: APIPath.setHire(orderid),
        data: hire.toMap(),
      );
            @override
  Future<void> updateHirepayment(Hire hire,String orderid) async => await _service.update(
        path: APIPath.setHire(orderid),
        data: hire.toMap(),
      );
   @override
  Future<void> setBooking(Bookingmodel booking,String orderid) async => await _service.setData(
        path: APIPath.addbookings(orderid),
        data: booking.toMap(),
      );


      @override
 Future<void> addpost(Post post,String postid) async => await _service.setData(
        path: APIPath.postadd(postid),
        data: post.toMap(),
      );
  @override
  Future<void> updateUser(Usermodel usermodel) async => await _service.setData(
        path: APIPath.user(
          uid,
        ),
        data: usermodel.toMap(),
      );
  @override
  Stream<List<Chats>> chatsStreams(String chatRoomId) =>
      _service.collectionStream(
        path: APIPath.chatStream(chatRoomId),
        builder: (data, documentId) => Chats.fromMap(data, documentId),
        queryBuilder: (query) => query.orderBy('time', descending: true),
      );
  @override
  Stream<List<Bookingmodel>> bookingstream() =>
      _service.collectionStream(
        path: APIPath.bookingstream(),
        builder: (data, documentId) => Bookingmodel.fromMap(data, documentId),
        queryBuilder: (query) => query.where('customeruid',isEqualTo: uid),
      );
 @override
  Stream<List<Hire>>hiringstream() =>
      _service.collectionStream(
        path: APIPath.hiringstream(),
        builder: (data, documentId) => Hire.fromMap(data, documentId),
        queryBuilder: (query) => query.where('customeruid',isEqualTo: uid),
      );
       @override
  Stream<Hire>hiringstreamselected(String orderid) =>
      _service.documentStream(
        path: APIPath.setHire(orderid),
        builder: (data, documentId) => Hire.fromMap(data, documentId),
      //  queryBuilder: (query) => query.where('customeruid',isEqualTo: uid),
      );
       @override
  Stream<List<Hire>>hiringstreamFreelance() =>
      _service.collectionStream(
        path: APIPath.hiringstream(),
        builder: (data, documentId) => Hire.fromMap(data, documentId),
        queryBuilder: (query) => query.where('freelanceruid',isEqualTo: uid),
      );
  // @override
  // Future<void> deleteJob(Job job) async {
  //   // delete where entry.jobId == job.jobId
  //   final allEntries = await entriesStream(job: job).first;
  //   for (Entry entry in allEntries) {
  //     if (entry.jobId == job.id) {
  //       await deleteEntry(entry);
  //     }
  //   }
  //   // delete job
  //   await _service.deleteData(path: APIPath.job(uid, job.id));
  // }

  @override
  Stream<Usermodel> userStream({@required String uid}) =>
      _service.documentStream(
        path: APIPath.user(uid),
        builder: (data, documentId) => Usermodel.fromMap(data, documentId),
      );
  @override
  Stream<List<ChatRoomModelother>> chatRoomget() => _service.collectionStream(
        path: APIPath.chatRoomStream(),
        builder: (data, documentId) =>
            ChatRoomModelother.fromMap(data, documentId),
      );
       @override
  Stream<List<Usermodel>> getuser() => _service.collectionStream(
        path: APIPath.userget(),
        builder: (data, documentId) =>
            Usermodel.fromMap(data, documentId),
      );

  @override
  Stream<List<ChatRoomModel>> chatRoomstreams() => _service.collectionStream(
        path: APIPath.chatRoomStream(),
        builder: (data, documentId) => ChatRoomModel.fromMap(data, documentId),
        queryBuilder: (query) => query.where('users', arrayContains: uid),
      );
  @override
  Stream<List<Post>> postStream() => _service.collectionStream(
        path: APIPath.post(),
        builder: (data, documentId) => Post.fromMap(data, documentId),
      );
  @override
  Stream<List<Post>> selectedpostStream({@required String userid}) =>
      _service.collectionStream(
        path: APIPath.post(),
        builder: (data, documentId) => Post.fromMap(data, documentId),
        queryBuilder: (query) => query.where('uid', isEqualTo: userid),
      );

  
  // @override
  // Future<void> setEntry(Entry entry) async => await _service.setData(
  //       path: APIPath.entry(uid, entry.id),
  //       data: entry.toMap(),
  //     );

  @override
  Future<void> deleteUser() async =>
      await _service.deleteData(path: APIPath.user(uid));
  @override
  Future<void> deleteBooking(String orderid) async =>
      await _service.deleteData(path: APIPath.addbookings(orderid));
       @override
  Future<void> deleteHiring(String orderid) async =>
      await _service.deleteData(path: APIPath.setHire(orderid));
  // @override
  // Stream<List<Entry>> entriesStream({Job job}) =>
  //     _service.collectionStream<Entry>(
  //       path: APIPath.entries(uid),
  //       queryBuilder: job != null
  //           ? (query) => query.where('jobId', isEqualTo: job.id)
  //           : null,
  //       builder: (data, documentID) => Entry.fromMap(data, documentID),
  //       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  //     );
}
