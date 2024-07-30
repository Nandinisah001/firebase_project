// import 'package:firebase_project/email_auth_and_pasword/views/email_password/registration_auth_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//  import 'home_screen.dart';
//
// class LoginAuthScreen extends StatefulWidget {
//   @override
//   _LoginAuthScreenState createState() => _LoginAuthScreenState();
// }
//
// class _LoginAuthScreenState extends State<LoginAuthScreen> {
//   final _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(child: Text("Email Password Auth")),
//         backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: "Enter your email",
//                 prefixIcon: Icon(Icons.email),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//               ),
//               controller: _emailController,
//               keyboardType: TextInputType.emailAddress,
//             ),
//             SizedBox(height: 30),
//             TextField(
//               decoration: const InputDecoration(
//                 labelText: "Enter your password",
//                 prefixIcon: Icon(Icons.lock),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                 ),
//               ),
//               controller: _passwordController,
//               obscureText: false,
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       UserCredential userCredential =
//                           await _auth.signInWithEmailAndPassword(
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                       );
//                       if (userCredential.user != null) {
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (context) => HomePage()),
//                         );
//                       } else {
//                         print("not login");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(
//                           msg: "ragister now ",
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.CENTER,
//                           timeInSecForIosWeb: 1,
//                           backgroundColor: Colors.white,
//                           textColor: Colors.red,
//                           fontSize: 16.0);
//                     }
//                   },
//                   child: const Text(
//                     "Login",
//                     style: TextStyle(color: Colors.pink),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegisterScreen(),
//                         ));
//                   },
//                   child: const Text(
//                     "Registration",
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
