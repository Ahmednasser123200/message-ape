import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User Singinuser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = "chat_Screen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextcontroller = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String? messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        Singinuser = user;
        print(Singinuser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  /*void getMessages() async{
  final messages=await  _firestore.collection("Massages").get();
  for(var massage in messages.docs){
    print(massage.data());
  }
  
  }*/
  void messagesStreams() async {
    await for (var snapsshot in _firestore.collection("Massages").snapshots()) {
      for (var message in snapsshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image(
              image: AssetImage("images/1.png"),
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Messageme")
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
               // messagesStreams();
                 _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("Massages").orderBy("time").snapshots(),
                builder: (context, snapshot) {
                  List<MessageLine> messageWidgets = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                  final messages = snapshot.data!.docs.reversed;
                  for (var message in messages) {
                    final messageText = message.get("text");
                    final messageSender = message.get("sender");
                    final currentUser = Singinuser.email;
                    if (currentUser == messageSender) {}
                    final messageWidget = MessageLine(
                      sender: messageSender,
                      text: messageText,
                      isme: currentUser == messageSender,
                    );
                    messageWidgets.add(messageWidget);
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      children: messageWidgets,
                    ),
                  );
                }),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.orange, width: 2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageTextcontroller,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: "write your message here....",
                          border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        messageTextcontroller.clear();
                        _firestore.collection("Massages").add(
                            {"text": messageText, "sender": Singinuser.email ,"time":FieldValue.serverTimestamp()});
                      },
                      child: Text(
                        "send",
                        style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.text, this.sender, required this.isme, super.key});

  final String? sender;
  final String? text;
  final bool isme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            "$sender",
            style: TextStyle(fontSize: 12, color: Colors.yellow[900]),
          ),
          Material(
              elevation: 5,
              borderRadius: isme
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
              color: isme ? Colors.blue[800] : Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "$text",
                  style: TextStyle(
                      fontSize: 15, color: isme ? Colors.white : Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
