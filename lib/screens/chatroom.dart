import 'package:chatroom/services/database.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  final String chatroomName;
  final String username;
  const Chatroom({required this.chatroomName, required this.username, super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {

  String msg = '';
  List chats = [];

  final database = Database();
  final fieldText = TextEditingController();

  void loadChats(String chatroonName)async{
    List chatList = await database.getChats(chatroonName);

    if(!mounted){return;}

    setState(() {
      chats = chatList;
    });
  }

  @override
  Widget build(BuildContext context) {

    loadChats(widget.chatroomName);

    List<Widget> chatList = [];
    List alignList = [];

    for(int index = 0; index < chats.length; index++){
      if(chats[index]['sender'] == widget.username){
        alignList.add(CrossAxisAlignment.end);
      }
      else{
        alignList.add(CrossAxisAlignment.start);
      }
      chatList.add(SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: alignList[index],
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 300
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                color: Colors.white10,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chats[index]['sender'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo[400]
                        ),
                      ),
                      const SizedBox(height: 2,),
                      Text(chats[index]['msg']),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatroomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: chatList,
                  ),
                ),
              ),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 290,
                      height: 45,
                      child: TextField(                      
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white10,
                          hintText: 'Message',

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.transparent)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.transparent)
                          )
                        ),
                        onChanged: (value){
                          setState(() {
                            msg = value;
                          });
                        },
                        controller: fieldText,
                      ),
                    ),
                    IconButton(
                      onPressed:(){
                        database.addChat(
                          widget.chatroomName,
                          {
                            'sender': widget.username,
                            'msg': msg
                          }
                        );
                        msg = '';
                        fieldText.clear();
                      },
                      icon: const Icon(Icons.send)
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}