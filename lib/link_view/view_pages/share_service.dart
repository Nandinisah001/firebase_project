import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class ProductService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getAllData() async {
    return await firestore.collection('products').get();
  }

  Future<DocumentSnapshot> getSingleData(String id) async {
    return await firestore.collection('products').doc(id).get();
  }

  Future<void> shareLink(String id) async {
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      link: Uri.parse("https://www.example.com/product?id=$id"),
      uriPrefix: "https://firebaseproject2024.page.link",
      androidParameters: const AndroidParameters(
        packageName: "com.example.firebase_project",
      ),
    );

    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance
        .buildShortLink(dynamicLinkParameters);
    Uri shortUrl = shortDynamicLink.shortUrl;
    await Share.share(shortUrl.toString());
  }

  Future<DocumentReference<Map<String, dynamic>>> addProduct(
      String docId,
      String images,
      String desc,
      String title,
      String price,
      ) async {
    return await firestore.collection("cart").add({
      'docId': docId,
      'images': images,
      'desc': desc,
      'title': title,
      'price':price

    });
  }
}
