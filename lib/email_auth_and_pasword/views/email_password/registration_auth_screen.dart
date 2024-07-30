// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'login_auth_screen.dart';
// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Register page'),backgroundColor: Colors.orange,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:[
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: "Enter your email ",
//                   prefixIcon: Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//               ),
//             ),
//              Padding(
//                padding: const EdgeInsets.only(top:20),
//                child: TextField(
//                 decoration: InputDecoration(
//                   labelText: "Enter your password",
//                   prefixIcon: Icon(Icons.password),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//                 controller: _passwordController,
//                            ),
//              ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     try {
//                       UserCredential Credential =
//                       await _auth.createUserWithEmailAndPassword(
//                         email: _emailController.text,
//                         password: _passwordController.text,
//                       );
//                       if (Credential.user != null) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginAuthScreen(),
//                             ));
//                       } else {
//                         print("not verify");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(
//                                   msg: "${e}",
//                                   toastLength: Toast.LENGTH_SHORT,
//                                   gravity: ToastGravity.CENTER,
//                                   timeInSecForIosWeb: 1,
//                                   backgroundColor: Colors.red,
//                                   textColor: Colors.white,
//                                   fontSize: 16.0
//                               );
//                     }
//                   },
//                   child: SizedBox(
//                       height: 20,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 1),
//                         child: Text(
//                           "Registration",
//                           style: TextStyle(color: Colors.orange),
//                         ),
//                       )),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//
// }