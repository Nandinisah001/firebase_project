import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Future<DocumentReference<Map<String, dynamic>>>> saveLocationDetails(String userId, Position position, Placemark place) async {
    return _firestore.collection('users').doc(userId).collection('locations').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': place.street,
      'locality': place.locality,
      'subAdministrativeArea': place.subAdministrativeArea,
      'administrativeArea': place.administrativeArea,
      'postalCode': place.postalCode,
      'country': place.country,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getLocationDetails(String userId) {
    return _firestore.collection('users').doc(userId).collection('locations').snapshots();
  }
}

