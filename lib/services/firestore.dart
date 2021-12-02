import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fireship_app/services/auth.dart';
import 'package:fireship_app/services/models.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Read all documents from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection('topics');
    var snapshot = await ref.get();

    var topics = (
        snapshot.docs
        .map((s) => s.data())
        .map((d) => Topic.fromJson(d))
        .toList()
      );

    return topics;
  }

  // Retrieves a singl quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db.collection('quizzes').doc(quizId);
    var snapshot = await ref.get();
    
    return Quiz.fromJson(snapshot.data() ?? {});
  }

  // Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(user.uid);
        return ref.snapshots().map((doc) => Report.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([Report()]);
      }
    });
  }
}