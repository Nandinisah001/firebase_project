import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'firestore_services.dart';
import 'location_services_class.dart';
import 'show_mycurrent_location.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  _UserRegistrationScreenState createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final LocationService _locationService = LocationService();
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _register() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      await _storeCurrentLocation(userCredential.user!.uid);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ShowMyCurrentLocation(userId: userCredential.user!.uid),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _storeCurrentLocation(String userId) async {
    Position position = await _locationService.getCurrentLocation();
    Placemark place = await _locationService.getPlacemarkFromPosition(position);
    await _firestoreService.saveLocationDetails(userId, position, place);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.purple,
          semanticContainer: true,
          margin: EdgeInsets.only(top: 30, bottom: 90),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView(
              children: [
                Image.network(
                    "https://static.vecteezy.com/system/resources/previews/027/205/841/original/login-and-password-concept-3d-illustration-computer-and-account-login-and-password-form-page-on-screen-3d-illustration-png.png",),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17)),
                    prefixIcon:
                        const Icon(Icons.email, color: Colors.purple),
                  labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17)),
                    prefixIcon: const Icon(Icons.password, color: Colors.purple),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  color: Colors.purple,
                  onPressed: _register,
                  child: const Text('Register',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
