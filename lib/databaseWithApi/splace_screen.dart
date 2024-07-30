import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_page.dart';
import 'home_api_screen.dart';
import 'notifier_class.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing ShopAuthProvider instance
    final shopAuthProvider = Provider.of<ShopAuthProvider>(context, listen: false);

    // Delay for 2 seconds before deciding navigation
    Future.delayed(const Duration(seconds: 2), () async {
      // Check if user is authenticated
      bool isAuthenticated = await shopAuthProvider.isAuthenticated;

      if (isAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  EshopLogin()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeDemoScreen()),
        );
      }
    });

    return const Scaffold(
      body: Center(
        child: FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 200,
          textColor: Colors.blue,
        ),
      ),
    );
  }
}
