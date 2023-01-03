import 'package:chatroom/screens/chatroom.dart';
import 'package:chatroom/screens/welcome.dart';
import 'package:chatroom/services/database.dart';
import 'package:chatroom/shared/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({required this.username, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String groupTitle = '';

  List<String> OGchatrooms = ['Movies', 'Sports', 'Current Affairs', 'Novels', 'Academics'];
  List<String> chatrooms = ['Movies', 'Sports', 'Current Affairs', 'Novels', 'Academics'];

  void setChatrooms()async{
    List additionalChatrooms = await Database().getChatrooms();
    for(int i = 0; i < additionalChatrooms.length; i++){
      setState(() {
        chatrooms.add(additionalChatrooms[i]['chatroomTitle']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setChatrooms();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatroom'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Welcome()
                ));
            },
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:15, vertical: 8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white10),
                  foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (newContext) => AlertDialog(
                      title: const Text("New Chatroom"),
                      content: TextFormField(
                        cursorWidth: 1,
                        decoration: textInputDecoration.copyWith(
                          hintText: 'Chatroom Title'
                        ),
                        onChanged: (value){
                          setState(() {
                            groupTitle = value;
                          });
                        },
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: (){
                            setState((){
                              Database().addChatroom(groupTitle);
                            });
                            chatrooms = OGchatrooms;
                            setChatrooms();
                            Navigator.of(newContext).pop();
                          },
                          child: const Text("Add group")
                        )
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.add)
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(          
                itemBuilder: (context, index) => Card(
                  elevation: 0,
                  color: Colors.transparent,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.centerLeft
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) => Chatroom(
                            chatroomName: chatrooms[index],
                            username: widget.username,
                          ),
                        )
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical:10),
                      child: ListTile(
                        title: Text(chatrooms[index]),
                        leading: const CircleAvatar(radius: 30,)
                      ),
                    ),
                  ),
                ),
                itemCount: chatrooms.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}