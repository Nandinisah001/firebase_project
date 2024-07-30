// import 'package:firebase_database/firebase_database.dart';
// import 'package:uuid/uuid.dart';
// import 'package:flutter/material.dart';
//
// class RealTime extends StatefulWidget {
//   const RealTime({super.key});
//
//   @override
//   State<RealTime> createState() => _RealTimeState();
// }
//
// class _RealTimeState extends State<RealTime> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Center(
//           child: Text(
//             "**RealTime**",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             realTimeDatabase();
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text(
//               "DataAdd",
//               style: TextStyle(color: Colors.pink),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   realTimeDatabase() async {
//     FirebaseDatabase database = FirebaseDatabase.instance;
//     var userId = Uuid().v1();
//     await database.ref("users").child(userId).set({
//       "name": "jyoti kumari",
//       "email": "kumarijyoti58301",
//       "address": {
//         "village": "jagdisha pur",
//         "post": "maker",
//         "distic": "chhapra",
//         "gender": {
//           "male": true,
//           "female": false
//         }
//       }
//     });
//     database.ref('Data added with key: $userId');
//   }
// }
//
//
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
//
// import 'chats_screen.dart';
//
// class UserDetailsScreen extends StatefulWidget {
//   const UserDetailsScreen({super.key});
//
//   @override
//   State<UserDetailsScreen> createState() => _UserDetailsScreenState();
// }
//
// class _UserDetailsScreenState extends State<UserDetailsScreen> {
//   var deviceId = "";
//   final TextEditingController nameController = TextEditingController();
//
//   @override
//   void initState() {
//     _getId();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("User Details"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: "Enter your name",
//                 icon: Icon(Icons.emoji_emotions),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10))
//                 ),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 12),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Device ID: $deviceId",
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => ChatScreen(
//                         userName: nameController.text,
//                         deviceId: deviceId,
//                       ),
//                     ),
//                   );
//                 },
//                 child: const Text("Save"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isAndroid) {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       setState(() {
//         deviceId = androidDeviceInfo.id;
//       });
//     }
//   }
// }
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

import 'chats_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var deviceId = "";
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    _getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,
        title: Center(child: const Text("User Details",)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Type a message",
                prefixIcon: Icon(Icons.emoji_emotions_outlined,
                    color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(87)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Device Id :$deviceId"),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChatScreen(
                            userName: nameController.text,
                            deviceId: deviceId)));
              },
              child: const Text("Add Name",style: TextStyle(color: Colors.white),))
        ],
      ),
    );
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
      setState(() {});
    }
    return null;
  }
}
