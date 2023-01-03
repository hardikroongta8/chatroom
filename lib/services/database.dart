import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  void addChatroom(String chatroomName)async{
    final chatroomCollection = FirebaseFirestore.instance.collection('chatrooms');

    await chatroomCollection.doc(DateTime.now().toString()).set({
      'chatroomTitle': chatroomName
    });
  }

  Future getChatrooms()async{
    final chatroomCollection = FirebaseFirestore.instance.collection('chatrooms');

    final snapshot = await chatroomCollection.get();

    List chatrooms = [];

    chatrooms = snapshot.docs.map((e) => e.data()).toList();

    return chatrooms;
  }

  Future getChats(String chatroomName)async{
    final chatroomCollection = FirebaseFirestore.instance.collection(chatroomName);

    final snapshot = await chatroomCollection.get();

    List chats = [];

    chats = snapshot.docs.map((doc){
      return doc.data();
    }).toList();

    return chats;
  }

  void addChat(String chatroomName, Map chatBody)async{
    final chatroomCollection = FirebaseFirestore.instance.collection(chatroomName);

    await chatroomCollection.doc(DateTime.now().toString()).set({
      'sender': chatBody['sender'],
      'msg': chatBody['msg']
    });
  }
}