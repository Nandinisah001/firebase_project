import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firestore_services.dart';

class ShowMyCurrentLocation extends StatelessWidget {
  final String userId;

  const ShowMyCurrentLocation({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: const Text("Show My Current Location"),
        backgroundColor: Colors.teal,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getLocationDetails(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var locations = snapshot.data!.docs;

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              var location = locations[index];
              return Container(
                height: 210, // Set the desired height for the card
                margin: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Latitude: ${location['latitude']}'),
                        Text('Longitude: ${location['longitude']}'),
                        Text('Address: ${location['address']}'),
                        Text('Locality: ${location['locality']}'),
                        Text('Sub Administrative Area: ${location['subAdministrativeArea']}'),
                        Text('Administrative Area: ${location['administrativeArea']}'),
                        Text('Postal Code: ${location['postalCode']}'),
                        Text('Country: ${location['country']}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
