import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'location_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _register() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocode to get address details
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks.first;


      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': _emailController.text,
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': place.street,
          'locality': place.locality,
          'subAdministrativeArea': place.subAdministrativeArea,
          'administrativeArea': place.administrativeArea,
          'postalCode': place.postalCode,
          'country': place.country,
        },
      });

      // Navigate to LocationScreen with location data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LocationScreen(
                latitude: position.latitude,
                longitude: position.longitude,
                locality: place.locality ?? '',
                subAdministrativeArea: place.subAdministrativeArea ?? '',
                administrativeArea: place.administrativeArea ?? '',
                postalCode: place.postalCode ?? '',
                country: place.country ?? '',
              ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.email,color: Colors.teal,),
                  labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.password,color: Colors.teal,),
                  labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

 }