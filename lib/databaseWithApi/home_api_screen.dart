import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "e-shop",
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white,),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            var data = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.60, // Adjust this ratio to fit your design
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                var product = data[index];
                return Card(
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      product['thumbnail'] != null && product['thumbnail'].isNotEmpty
                          ?CachedNetworkImage(
                    imageUrl:  product['thumbnail'],
                     placeholder: (context, url) => Center(child: const CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ) : Container(
                        height: 120,
                        color: Colors.grey[200],
                        child: Center(child: Text('No Image')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title'] ?? 'No Title',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Brand: ${product['brand'] ?? 'No Brand'}",
                            ),
                            SizedBox(height: 4),
                            Text(
                              "\$${product['price'] ?? '0'}", // Assuming price is a number
                              style: TextStyle(color: Colors.green),
                            ),
                            SizedBox(height: 4),

                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  final String baseUrl = 'https://dummyjson.com/products';

  Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productsJson = data['products'];
        return productsJson;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to fetch products: $e");
      throw Exception('Failed to fetch products: $e');
    }
  }
  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EshopLogin()),
    );

    Fluttertoast.showToast(
      msg: "Successfully logged out",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.green,
      fontSize: 16.0,
    );
  }
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(child: Text("Profile Page")),
    );
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EshopLogin()),
      );

      Fluttertoast.showToast(
        msg: "Successfully logged out",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.green,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error logging out: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}