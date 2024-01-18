import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:logger/logger.dart';
import 'package:proacademy_app/models/objects.dart';

class ChatController {
  //creates the user collection refference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // ----- retrive and listen to users collection in real time using a stream

  Stream<QuerySnapshot> getUsers(String currentUserId) =>
      users.where('uid', isNotEqualTo: currentUserId).snapshots();

  // -------------- create conversation

  //creates the user collection refference
  CollectionReference conversations =
      FirebaseFirestore.instance.collection('conversations');

  Future<ConversationModel> createConversation(
      UserModel me, UserModel peeruser) async {
    //-check if the conversation exists first
    ConversationModel? model = await checkConvExist(me.uid, peeruser.uid);

    if (model == null) {
      String docid = conversations.doc().id;

      await conversations
          .doc(docid)
          .set({
            'id': docid,
            'users': [me.uid, peeruser.uid],
            'userArray': [me.toJson(), peeruser.toJson()],
            'lastMassage': 'started a conversation',
            'lastMassageTime': DateTime.now().toString(),
            'createdBy': me.uid,
            'createdAt': DateTime.now(),
          })
          .then((value) => Logger().i("Conversation saved"))
          .catchError((error) => Logger().e("Failed to save data: $error"));

      DocumentSnapshot snapshot = await conversations.doc(docid).get();
      return ConversationModel.fromJson(
          snapshot.data() as Map<String, dynamic>);
    } else {
      return model;
    }
  }

  Future<ConversationModel?> checkConvExist(String myId, String peerId) async {
    try {
      Logger().wtf(myId);
      Logger().wtf(peerId);

      // ----- first check in the db for matched conversation with given user id list
      QuerySnapshot result = await conversations
          .where('users', arrayContainsAny: [myId, peerId]).get();

      // ------ checking the fetched result
      for (var item in result.docs) {
        // ----- first mapping single document data to the conversation model
        var model =
            ConversationModel.fromJson(item.data() as Map<String, dynamic>);
        // ----- then check
        if (model.users.contains(myId) && model.users.contains(peerId)) {
          Logger().i('the conversation already exists');
          return model; // Return the matching conversation immediately
        }
      }

      Logger().i('the conversation does not exist');
      return null; // No matching conversation found
    } catch (e) {
      Logger().i(e);
      return null;
    }
  }

  // ----- retrive conversations

  Stream<QuerySnapshot> getConversations(String currentUserId) => conversations
      .orderBy('createdAt', descending: true)
      .where('users', arrayContainsAny: [currentUserId]).snapshots();

  // ------- send messages
  //creates the user collection refference
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  Future<void> sendMessage(
    String conId,
    String senderName,
    String senderId,
    String receiverId,
    String message,
  ) async {
    try {
      // ---- save a messaging db

      await messages.add({
        "conId": conId,
        "senderName": senderName,
        "senderId": senderId,
        "receiverId": receiverId,
        "message": message,
        "messageTime": DateTime.now().toString(),
        "createdAt": DateTime.now(),
      });
      //---- update the conversation last message and time

      await conversations.doc(conId).update({
        'lastMassage': message,
        'lastMassageTime': DateTime.now().toString(),
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  // ----- retrive messages by conversation id

  Stream<QuerySnapshot> getMessages(String conId) => messages
      .orderBy('createdAt', descending: true)
      .where('conId', isEqualTo: conId)
      .snapshots();

  // ----- listen to peer user uid

  Stream<DocumentSnapshot> getPeeruserOnlinestatus(String uid) =>
      users.doc(uid).snapshots();
}
