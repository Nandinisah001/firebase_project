import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'add_to_card.dart';
import 'package:firebase_project/link_view/view_pages/share_service.dart';

class ProductDetails extends StatelessWidget {
  final String docId;
  final String images;
  final String desc;
  final String title;
  final String price;

  const ProductDetails({
    super.key,
    required this.docId,
    required this.images,
    required this.desc,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final dataService = ProductService();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder(
        future: dataService.getSingleData(docId),
        builder: (context, snapshot) {
            final item = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(item?['images']??""),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item?['title']??"",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Price: ${item?['price']??""}",
                    style: const TextStyle(fontSize: 20, color: Colors.green),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    "docId: ${item?['docId']??""}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Center(
                    child: MaterialButton(
                      height: 40,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      color: Colors.teal,
                      onPressed: () {
                        dataService.shareLink(docId);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(Icons.share, color: Colors.black),
                          const SizedBox(width: 20),
                          const Text(
                            "Share",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: MaterialButton(
                      minWidth: 60,
                      height: 40,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      color: Colors.teal,
                      onPressed: () {
                        ProductService().addProduct(docId, images, desc, title, price);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddToCartScreen(),
                          ),
                        );
                      },
                      child: const Text("ADD "),
                    ),
                  ),
                ],
              ),
            );
          }

      ),
    );
  }
}
