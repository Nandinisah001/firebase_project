import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  var firestore = FirebaseFirestore.instance;
  Future<void> dataStore(String name,String email,int phone,String
  village,String post,String police,) async {
    try {
      await firestore.collection("teachers_data").add({
        "name": name,
        "email": email,
        "phone":phone,
        "useraddress":{
          "village":village,
          "post":post,
          "police_station":police,
        }
      });
      print("Data added successfully.");
    } catch (e) {
      print("Error adding data: $e");
    }

  }



  Future<void> updateTeacher(String docId, String name, String email, int phone) async {
    try {
      await firestore.collection("teachers_data").doc(docId).update({
        "name": name,
        "docId": docId,
        "email": email,
        "phone": phone,
        "timestamp": Timestamp.now(),  
      });
      print("Teacher data updated successfully.");
    } catch (e) {
      print("Error updating teacher data: $e");
      throw e;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllTeachers()  {
    try {
      var data = firestore.collection("teachers_data").orderBy('name',descending: true ).snapshots();
      return data;
    } catch (e) {
      print("Error retrieving teachers data: $e");
      return null;
    }
  }
  Future<void> deleteTeacher(String docId) async {
    try {
      await firestore.collection("teachers_data").doc(docId).delete();
      print("Document deleted successfully");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}