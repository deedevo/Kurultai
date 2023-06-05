import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String uid;
  final String username;
  final DateTime date;
  final String messageUrl;
  final String messageId;

  const Message(
      {required this.message,
        required this.uid,
        required this.username,
        required this.date,
        required this.messageUrl,
        required this.messageId
      });

  static Message fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Message(
        message: snapshot["message"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        date: snapshot["date"],
        messageUrl: snapshot['messageUrl'],
        messageId: snapshot['messageId'],

    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "uid": uid,
    "username": username,
    "date": date,
    'messageUrl': messageUrl,
    'messageId': messageId
  };

}