// import 'package:cloud_firestore/cloud_firestore.dart';
//  import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// class DynamicLink extends StatefulWidget {
//   const DynamicLink({Key? key}) : super(key: key);
//
//   @override
//   State<DynamicLink> createState() => _DynamicLinkState();
// }
//
// class _DynamicLinkState extends State<DynamicLink> {
//   @override
//   void initState() {
//     super.initState();
//     initDynamicLinks();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Share, ",
//           style: TextStyle(color: Colors.white, fontSize: 18),
//         ),
//         backgroundColor: Color(0xE4095087878750),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('share_link').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final data = snapshot.requireData;
//           return ListView.builder(
//             itemCount: data.size,
//             itemBuilder: (context, index) {
//               var document = data.docs[index];
//               return Card(
//                 color: Colors.white12,
//                 child: ListTile(
//                   leading: Image.network(document["imageUrl"]),
//                   title: Text(document['title'],style: TextStyle(fontSize: 20,
//                       color: Color(0xE4095050)),), // Replace 'field_name' with your field name
//                   subtitle: Text(document['price'].toString()),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//     initDynamicLinks() async {
//     FirebaseDynamicLinks.instance.onLink;
//     final PendingDynamicLinkData? initialLink =
//     await FirebaseDynamicLinks.instance.getInitialLink();
//     final Uri? deepLink = initialLink?.link;
//     if (deepLink != null) {
//       print('Received deep link on initial launch: $deepLink');
//     }
//   }
//
//   shareLink() async {
//     var dynamicLinkParams = DynamicLinkParameters(
//       link: Uri.parse("https://firebaseproject2024.page"),
//       uriPrefix: "https://firebaseproject2024.page.link",
//       androidParameters: const AndroidParameters(
//         packageName: "com.example.firebase_project"),);
//     Uri dynamicLink = await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);
//     await Share.share(dynamicLink.toString());
//   }
// }