import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_registration.dart';
 import 'minix_class.dart';

class CustomerLoginScreen extends StatefulWidget {
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> with CustomerClass {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: ClipOval(
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtMM9P1O04SAekcIPka5rivN8y4kfcddDO2A&s",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            viewTextField(
              emailController,
              "Enter Email",
              const Icon(Icons.person),
              "Email",
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an email';
                }
                return null;
              },
            ),
            viewTextField(
              passwordController,
              "Enter Password",
              const Icon(Icons.lock),
              "Password",
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    String email = emailController.text;
                    String password = passwordController.text;

                    QuerySnapshot querySnapshot = await _firestore
                        .collection('flutter_firestorm')
                        .where('email', isEqualTo: email)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      var user = querySnapshot.docs.first.data()
                          as Map<String, dynamic>;
                      if (user['password'] == password) {

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Incorrect password!')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                              'Email does not exist, please register!'),
                          action: SnackBarAction(
                            label: 'Register',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const CustomerRegisterScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
