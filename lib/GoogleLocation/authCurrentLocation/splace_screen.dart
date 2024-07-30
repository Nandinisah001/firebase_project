import 'dart:async';

import 'package:firebase_project/GoogleLocation/authCurrentLocation/show_login_screen.dart';
import 'package:flutter/material.dart';


class SplacesScreen extends StatefulWidget {

  const SplacesScreen({super.key});

  @override
  _SplacesScreenState createState() => _SplacesScreenState();
}

class _SplacesScreenState extends State<SplacesScreen> {
  ThemeMode _themeMode = ThemeMode.light;
  void _toggleTheme(){
  setState(() {
  _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark: ThemeMode.light;
  });
  }
  // final LocationService _locationService = LocationService();
  // final FirestoreService _firestoreService = FirestoreService();
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
 Timer(Duration(seconds: 3), () {
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowLoginScreen(),));
 },);
  }

  // Future<void> _checkAuth() async {
  //   User? user = _auth.currentUser;
  //   if (user != null) {
  //     try {
  //       Position position = await _locationService.getCurrentLocation();
  //       Placemark place = await _locationService.getPlacemarkFromPosition(position);
  //       await _firestoreService.saveLocationDetails(user.uid, position, place);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ShowMyCurrentLocation(userId: user.uid),
  //         ),
  //       );
  //     } catch (e) {
  //       print(e);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) =>  ShowLoginScreen()),
  //       );
  //     }
  //   } else {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) =>  ShowLoginScreen()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


