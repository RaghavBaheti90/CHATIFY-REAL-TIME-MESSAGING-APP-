import 'package:chat_me/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatservice {
  // get instance of firerstore & auth
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshort) {
      return snapshort.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String reciverID, message) async {
    // get a current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new mssage
    Message newMessage = Message(
      senderID: currentUserId,
      senderEmail: currentUserEmail,
      receiverID: reciverID,
      message: message,
      timestamp: timestamp,
    );
    // construct chat room ID for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, reciverID];
    ids.sort();
    String chatRoomId = ids.join('_');

    // add the message to database
    await _firestore
        .collection("Chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom ID for the two users
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection("Chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
