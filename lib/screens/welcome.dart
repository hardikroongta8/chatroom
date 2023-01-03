import 'package:chatroom/screens/home.dart';
import 'package:chatroom/shared/constants.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome>{

  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  cursorWidth: 1,
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person, color: Colors.indigo[200],)
                  ),
                  onChanged: (value){
                    setState(() {
                      username = value;
                    });
                  },
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(username: username)
                      ),
                    );
                  },
                  child: const Text('Continue')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}