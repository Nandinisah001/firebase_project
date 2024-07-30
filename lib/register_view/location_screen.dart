import 'package:flutter/material.dart';
class LocationScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  final String locality;
  final String subAdministrativeArea;
  final String administrativeArea;
  final String postalCode;
  final String country;

  const LocationScreen({super.key,
    required this.latitude,
    required this.longitude,
    required this.locality,
    required this.subAdministrativeArea,
    required this.administrativeArea,
    required this.postalCode,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: Center(
        child: Text(
          'Latitude: $latitude\n'
              'Longitude: $longitude\n\n'
              'Locality: $locality\n'
              'Sub Administrative Area: $subAdministrativeArea\n'
              'Administrative Area: $administrativeArea\n'
              'Postal Code: $postalCode\n'
              'Country: $country',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}