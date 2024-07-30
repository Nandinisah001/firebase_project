import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String deviceId;

  const ChatScreen({super.key, required this.userName, required this.deviceId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  var chatRef = FirebaseDatabase.instance.ref("chats");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: getMessage(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        var data = snap.data?.snapshot.children.toList();
                        return data?.isNotEmpty != null
                            ? ListView.builder(
                          itemCount: data!.length,
                          itemBuilder: (_, index) {
                            var message = data[index].value as Map;
                            var senderId = message['senderId'];
                            return senderId == widget.deviceId
                                ? Align(
                              alignment: Alignment.bottomRight,
                              child: messageView(message),
                            )
                                : Align(
                              alignment: Alignment.bottomLeft,
                              child: messageView(message),
                            );
                          },

                        )
                            : const Center(
                          child: Text("No message found!"),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Type a message...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.black))),
                    controller: messageController,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  radius: 30,
                  child: IconButton(
                    onPressed: () {
                      addMessage(messageController.text.trim());
                    },
                    icon: Icon(
                      Icons.send,
                      size: 30,color: Colors.green,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget messageView(Map<dynamic, dynamic> message) {
    return
        InkWell(
          onLongPress: () =>TimeDeleteMessage(message['id']) ,
          child: Card(color: Colors.white12,

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message['name'],
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.teal),
                ),
                Text(message['message']),
                Text(
                  message['date'].toString(),
                  style: TextStyle(fontSize: 8),
                ),
              ],
            ),
          ),

              ),
        );
  }

  addMessage(String message) async {
    var id = chatRef.push().key;
    await chatRef.child(id.toString()).set({
      "id": id.toString(),
      "name": widget.userName,
      "message": message,
      'senderId': widget.deviceId,
      "date": DateTime.now().toString()
    }).then((value) {
      messageController.clear();
    });
  }

  Stream<DatabaseEvent> getMessage() {
    return chatRef.onValue;
  }
  TimeDeleteMessage(String messageId)async{
     await chatRef.child(messageId).remove();
    ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text(
      'Message delete successfully!',
      style: TextStyle(color: Colors.white,fontSize: 13),
    ),
      backgroundColor: Colors.pink,
    )
    );
  }
}

