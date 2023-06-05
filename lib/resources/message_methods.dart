import 'package:cloud_firestore/cloud_firestore.dart';

class MessagingService {

  Future<void> sendMessageToUser(String recipientUserId, String message) async {
    final messageData = {
      'recipientUserId': recipientUserId,
      'message': message,
      'timestamp': Timestamp.now(),
    };

    // Save the message to the Firestore collection or use your desired messaging service
    await FirebaseFirestore.instance.collection('messages').add(messageData);
  }
}
