
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../registration/views/registration_screen.dart';
import 'location_screen.dart';

class ShowLoginScreen extends StatefulWidget {
  const ShowLoginScreen({super.key});

  @override
  _ShowLoginScreenState createState() => _ShowLoginScreenState();
}

class _ShowLoginScreenState extends State<ShowLoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks.first;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationScreen(
        latitude: position.latitude,
        longitude: position.longitude,
        locality: place.locality ?? '',
        subAdministrativeArea: place.subAdministrativeArea ?? '',
        administrativeArea: place.administrativeArea ?? '',
        postalCode: place.postalCode ?? '',
        country: place.country ?? '',
      )),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _navigateToRegistration() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.email,color: Colors.purple,),
                  labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.password,color: Colors.purple,),
                  labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _navigateToRegistration,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}