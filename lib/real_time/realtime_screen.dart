// import 'package:flutter/animation.dart';
// import 'package:flutter/material.dart';
//
// class RealtimeScreen extends StatefulWidget {
//   const RealtimeScreen({super.key});
//
//   @override
//   State<RealtimeScreen> createState() => _RealtimeScreenState();
// }
//
// class _RealtimeScreenState extends State<RealtimeScreen> {
//   TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQt0dsKLMb85ue86iZ3PYrOK5Fdl7mKaJNXmA&s"),
//             ),
//             SizedBox(width: 70, ),
//             Center(child: Text("Message",style: TextStyle(color: Colors.white),)),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: Container()),
//           Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,bottom: 20
//                   ),
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       labelText: "Type a message",
//                       prefixIcon: Icon(
//                         Icons.emoji_emotions_outlined,
//                         color: Colors.teal,
//                       ),
//
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                       ),
//                     ),
//
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: Icon(Icons.send),
//                 color: Colors.teal,
//                 onPressed: () {
//
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimeScreen extends StatefulWidget {
  const RealtimeScreen({super.key});

  @override
  State<RealtimeScreen> createState() => _RealtimeScreenState();
}


class _RealtimeScreenState extends State<RealtimeScreen> {
  TextEditingController _controller = TextEditingController();
  DatabaseReference _chatsRef = FirebaseDatabase.instance.ref().child('chat');

  _addchats(String chat) {
    _chatsRef.push().set({'text': chat});
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "file:///C:/Users/rahul/Downloads/WhatsApp%20Image%202024-07-15%20at%201.27.29%20PM.jpeg"),
            ),
            SizedBox(width: 80),
            Center(child: Text("Messages", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatsRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data!.snapshot.value != null) {
                  Map data = snapshot.data!.snapshot.value as Map;
                  List messages = data.values.toList();
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only( left:140),
                        child: SizedBox(
                          height: 40,
                          child: Card(
                            color: Colors.white,
                            child: Center(child: Text(messages[index]['text'])),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No messages"));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: "Type a message",
                      prefixIcon: Icon(Icons.emoji_emotions_outlined,
                          color: Colors.black),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.teal),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addchats(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
