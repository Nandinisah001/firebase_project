import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/databaseWithApi/home_api_screen.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    var traditional=FirebaseAuth.instance;
    if (traditional.currentUser !=null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => EshopLogin()),
            (Route<dynamic> route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Demo()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 200,
          textColor: Colors.green,
        ),
      ),
    );
  }
}