import 'dart:async';

import 'package:clicktimes/models/postmodel.dart';
import 'package:clicktimes/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'apipath.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setUser(Usermodel user);
  // Future<void> deleteJob(Job job);
  // Stream<List<Job>> jobsStream();
 Stream<Usermodel> userStream({@required String uid});
 Stream<List<Post>> postStream();
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
        path: APIPath.user(uid,),
        data: usermodel.toMap(),
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
  Stream<Usermodel> userStream({@required String uid}) => _service.documentStream(
        path: APIPath.user(uid),
        builder: (data, documentId) => Usermodel.fromMap(data, documentId),
      );

  @override
  Stream<List<Post>> postStream() => _service.collectionStream(
        path: APIPath.post(),
        builder: (data, documentId) => Post.fromMap(data, documentId),
      );

  // @override
  // Future<void> setEntry(Entry entry) async => await _service.setData(
  //       path: APIPath.entry(uid, entry.id),
  //       data: entry.toMap(),
  //     );

  // @override
  // Future<void> deleteEntry(Entry entry) async =>
  //     await _service.deleteData(path: APIPath.entry(uid, entry.id));

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