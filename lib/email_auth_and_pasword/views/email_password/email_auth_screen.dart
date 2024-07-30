import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailAuthScreen extends StatefulWidget {
  @override
  _EmailAuthScreenState createState() => _EmailAuthScreenState();
}

class _EmailAuthScreenState extends State<EmailAuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("User signed up: ${userCredential.user?.email}");
      // setState(() {
      //
      // });
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
    } catch (e) {
      print(e);
    }
  }

  void _signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print(": ${userCredential.user?.email}");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Firebase Auth Email")),backgroundColor: Colors. orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Enter your phone number",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                controller: _passwordController,

              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(

                  onPressed: _signUp,style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange)),

                  child: Text("Sign Up"),
                ),
                // ElevatedButton(
                //   onPressed: _signIn,
                //   child: Text("Sign In"),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.orange)),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
