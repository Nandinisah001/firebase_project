import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'home_api_screen.dart';
import 'login_page.dart';
import 'notifier_class.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
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
              padding: EdgeInsets.only(right: 260),
              child: Text(
                "e-Shop",
                style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 100),
            _viewTextField("Name", _nameController),
            _viewTextField("Email", _emailController),
            _viewTextField("Password", _passwordController),
            const SizedBox(height: 150),
            _viewButton(
              "Sign Up",
              onPressed: () {
                String name = _nameController.text.trim();
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                if (name.isEmpty || email.isEmpty || password.isEmpty) {
                  Fluttertoast.showToast(
                    msg: "Please fill all fields",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else if (password.length < 8) {
                  Fluttertoast.showToast(
                    msg: "Password must be at least 8 characters long",
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.white,
                    textColor: Colors.red,
                    fontSize: 16.0,
                  );
                } else {
                  _signUpUser(context, name, email, password);
                }
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: Colors.black)),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  EshopLogin()));
                  },
                  child: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _signUpUser(BuildContext context, String name, String email, String password) {
    final authProvider = Provider.of<ShopAuthProvider>(context, listen: false);

    authProvider.signUp(email, password).then((_) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeDemoScreen()));
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: "Failed to register: $error",
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
