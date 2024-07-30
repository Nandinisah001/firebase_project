// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'login_auth_screen.dart';
//
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.orange,
//         title: Text("HomePage"),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(
//               'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTsgrKuTTRDz6xheZsKlwlI6UEtlxLcor3iQ&s',
//               height: 200,
//             ),
//             SizedBox(height: 40),
//             Text(
//               "Welcome to HomePage",
//               style: TextStyle(fontSize: 20),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginAuthScreen(),
//                       ));
//                   FirebaseAuth.instance.signOut();
//                   var auth = FirebaseAuth.instance;
//                   if(auth.currentUser ==null){
//                     auth .signOut();
//                   }
//                 },
//                 child: Text("SingOut"))
//           ],
//         ),
//       ),
//     );
//   }
// }
