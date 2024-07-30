import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/link_view/view_pages/product_details.dart';

class ShareLinkGat extends StatefulWidget {
  const ShareLinkGat({super.key});

  @override
  State<ShareLinkGat> createState() => _ShareLinkGatState();
}

class _ShareLinkGatState extends State<ShareLinkGat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text(
          "Share,Link,Gat",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: ProductService().getAllData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!.docs;
            if (data.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var item = data[index];
                return Container(
                  height: 130,
                  width: 300,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                            docId: item.id, images: "${item['images']??""}", desc: "${item['desc']??""}", title: "${item['title']??""}", price:  "${item['price']??""}",
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Image.network("${item['images']??""}"),
                        title: Text(
                          item['title']??"",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          item['price']??"",
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot> getAllData() {
    return _db.collection('products').get();
  }
}
