import 'package:cloud_firestore/cloud_firestore.dart';
class CustomerFirestoreScreen {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  Future<void> CustomeraddData(String name, String age, String email, String phone) async {
    await _instance.collection("users_data").add({
      "name": name,
      "age": age,
      "email": email,
      "phone": phone
    });
  }

  Future<List<Map<String ,dynamic>>> getData()async{
    QuerySnapshot querySnapshot = await _instance.collection("users_data").get();
    return querySnapshot.docs.map((document) => document.data() as Map<String, dynamic>).toList();
  }
}