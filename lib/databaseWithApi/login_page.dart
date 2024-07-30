import 'package:firebase_project/databaseWithApi/ragistration_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'home_api_screen.dart';
import 'notifier_class.dart';

class EshopLogin extends StatefulWidget {
  const EshopLogin({super.key});

  @override
  State<EshopLogin> createState() => _EshopLoginState();
}

class _EshopLoginState extends State<EshopLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 280),
              child: Text(
                "e-Shop",
                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 320),
            _viewTextField("Email", _emailController),
            _viewTextField("Password", _passwordController),
            const SizedBox(height: 150),
            _viewButton(
              "Login",
              onPressed: () {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else {
                  _loginUser(context, email, password);
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here? ", style: TextStyle(color: Colors.black)),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Register()));
                    },
                    child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context, String email, String password) {
    final authProvider = Provider.of<ShopAuthProvider>(context, listen: false);

    authProvider.login(email, password).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeDemoScreen()));
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Failed to log in: $error",
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  Widget _viewTextField(String name, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SizedBox(
            width: 330,
            height: 38,
            child: TextField(
              controller: controller,
              obscureText: name == "Password",
              decoration: InputDecoration(
                hintText: name,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewButton(String name, {required void Function()? onPressed}) {
    return MaterialButton(
      height: 40,
      minWidth: 200,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.indigo),
      ),
      color: Colors.indigo,
      onPressed: onPressed,
      child: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
