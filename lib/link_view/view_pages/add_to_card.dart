// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class AddToCartScreen extends StatefulWidget {
//   const AddToCartScreen({super.key});
//
//   @override
//   State<AddToCartScreen> createState() => _AddToCartScreenState();
// }
//
// class _AddToCartScreenState extends State<AddToCartScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.white12,
//       appBar: AppBar(
//         title: const Text("Carting"),
//         backgroundColor: Colors.teal,
//       ),
//       body: FutureBuilder<QuerySnapshot>(
//         future: getCartDetails(),
//         builder: (context, snapshot) {
//
//           var data = snapshot.data?.docs;
//           return ListView.builder(
//             itemCount: data?.length,
//             itemBuilder: (context, index) {
//               var product = data?[index];
//               return Card(
//                 elevation: 4,
//                 shadowColor: Colors.cyan,
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Image.network(
//                           product?['images']??"",
//                           height: 150,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         product?['title']??"",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Price: ${product?['price']??""}",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Future<QuerySnapshot<Map<String, dynamic>>> getCartDetails() {
//     final firebase = FirebaseFirestore.instance;
//     return firebase.collection("cart").get();
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddToCartScreen extends StatefulWidget {
  const AddToCartScreen({super.key});

  @override
  State<AddToCartScreen> createState() => _AddToCartScreenState();
}

class _AddToCartScreenState extends State<AddToCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Carting",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: getCartDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No items in cart'));
          }

          var data = snapshot.data?.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.8,
            ),
            itemCount: data?.length,
            itemBuilder: (context, index) {
              var product = data?[index];
              return Card(
                elevation: 4,
                shadowColor: Colors.cyan,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          product?['images'] ?? "",
                          height: 70,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product?['title'] ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Price: ${product?['price'] ?? ""}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _removeFromCart(product?.id),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCartDetails() {
    final firebase = FirebaseFirestore.instance;
    return firebase.collection("cart").get();
  }

  Future<void> _removeFromCart(String? productId) async {
    if (productId != null) {
      final firebase = FirebaseFirestore.instance;
      await firebase.collection("cart").doc(productId).delete();
      setState(() {});
    }
  }
}
