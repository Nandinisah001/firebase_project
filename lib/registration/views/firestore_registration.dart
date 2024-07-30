import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'minix_class.dart';

class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> with CustomerClass {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("  Register Screen", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: Form(
        key: _formKey,
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
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text;
                    String password = passwordController.text;

                    QuerySnapshot querySnapshot = await _firestore
                        .collection('flutter_firestore')
                        .where('email', isEqualTo: email)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email already exists!')),
                      );
                    } else {
                      await _firestore.collection('flutter_firestore').add({
                        'email': email,
                        'password': password,
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registration Successful!')),
                      );

                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text(
                  "Register",
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