// // import 'package:flutter/material.dart';
// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});
// //
// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }
// //
// // class _SplashScreenState extends State<SplashScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("SplashScreen"),backgroundColor: Colors.orange,
// //       ),
// //       body: Column(
// //         children: [
// //           Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTsgrKuTTRDz6xheZsKlwlI6UEtlxLcor3iQ&s"),
// //           Text("Radhe...Radhe"),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//  import 'home_screen.dart';
// import 'login_auth_screen.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       checkLoginStatus();
//     });
//   }
//
//   void checkLoginStatus() {
//     var traditional=FirebaseAuth.instance;
//     if (traditional.currentUser !=null) {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => HomePage()),
//             (Route<dynamic> route) => false,
//       );
//     } else {
//       Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(builder: (context) => LoginAuthScreen()),
//             (Route<dynamic> route) => false,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: FlutterLogo(
//           style: FlutterLogoStyle.horizontal,
//           size: 200,
//           textColor: Colors.green,
//         ),
//       ),
//     );
//   }
// }