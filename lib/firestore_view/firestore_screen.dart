// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class GetUserScreen extends StatefulWidget {
//   const GetUserScreen({super.key, required this.users});
//
//   final String users;
//
//   @override
//   State<GetUserScreen> createState() => _GetUserScreenState();
// }
//
// class _GetUserScreenState extends State<GetUserScreen> {
//   @override
//   void initState() {
//     super.initState();
//     getAllTeachers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(child: Text('User List')),
//         backgroundColor: Colors.orange[800],
//       ),
//       body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//         stream: FirebaseFirestore.instance.collection("students").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return const Center(child: Text("Something went wrong"));
//           }
//
//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No users found"));
//           }
//
//           var users = snapshot.data!.docs;
//
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               var user = users[index].data();
//               return Card(
//                 color: Colors.teal,
//                 child: ListTile(
//                   title: Text(user['name']),
//                   subtitle: Text(user['email']),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.edit),color: Colors.black,
//                         onPressed: () {
//                           showMyBottomSheet(context, users[index].id, user);
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.delete),color: Colors.black,
//                         onPressed: () {
//                           deletestudent(users[index].id);
//                         },
//                       ),
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
//   void showMyBottomSheet(BuildContext context, String docId, Map<String, dynamic> userData) {
//     var editNameController = TextEditingController(text: userData['name']);
//     var editEmailController = TextEditingController(text: userData['email']);
//     var editAgeController = TextEditingController(text: userData['age'].toString());
//     var editGenderController = TextEditingController(text: userData['gender']);
//
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: editNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Edit Name',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: editEmailController,
//                 decoration: InputDecoration(
//                   labelText: 'Edit Email',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 controller: editAgeController,
//                 decoration: InputDecoration(
//                   labelText: 'Edit Age',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextField(
//                 style: TextStyle(color: Colors.red),
//                 controller: editGenderController,
//                 decoration: InputDecoration(
//                   labelText: 'Edit Gender',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
//                 onPressed: () async {
//                   await updateUser(
//                     docId,
//                     editNameController.text,
//                     editEmailController.text,
//                     editAgeController.text,
//                     editGenderController.text,
//                   );
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Update"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> updateUser(String docId, String name, String email, String age,
//       String gender) async {
//     var firestore = FirebaseFirestore.instance;
//     var students = firestore.collection("students");
//     await students.doc(docId).update({
//       "name": name,
//       "email": email,
//       "age": age,
//       "gender": gender,
//     }).then((_) {
//       Fluttertoast.showToast(msg: "User updated successfully");
//     }).catchError((error) {
//       Fluttertoast.showToast(msg: "Error updating user: $error");
//     });
//   }
//
//   Future<void> deletestudent(String docId) async {
//     var firestore = FirebaseFirestore.instance;
//     try {
//       await firestore.collection("students").doc(docId).delete();
//       Fluttertoast.showToast(msg: "Document deleted successfully");
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error deleting document: $e");
//     }
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>>? getAllTeachers() {
//     var firestone = FirebaseFirestore.instance;
//     try {
//       var data = firestone.collection("students").orderBy('name', descending: true).snapshots();
//       return data;
//     } catch (e) {
//       print("Error retrieving teachers data: $e");
//       return null;
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'firestore_get/get_firestore_screen.dart';
import 'firestore_services_class.dart';
import 'mixin_screen.dart';

class FireStoreData extends StatelessWidget with FirestoreMixin {
  FireStoreData({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var villageController = TextEditingController();
  var postController = TextEditingController();
  var policeController = TextEditingController();
  var services = FirebaseFirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            "users",
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzHMDlwRCHOHZP_tX7jRYNxV8W8MpNEog45w&s"),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  viewTextFild("name", nameController, Icons.person, 'name'),
                  SizedBox(height: 10),
                  viewTextFild("email", emailController, Icons.email, 'email'),
                  SizedBox(height: 10),
                  viewTextFild("phone", phoneController, Icons.phone, 'phone'),
                  SizedBox(height: 10),
                  viewTextFild("village", villageController,
                      Icons.holiday_village_outlined, 'village'),
                  SizedBox(height: 10),
                  viewTextFild("post", postController, Icons.post_add, 'post'),
                  SizedBox(height: 10),
                  viewTextFild(
                      "police", policeController, Icons.policy, 'police'),
                  SizedBox(height: 20),
                  Center(
                    child: MaterialButton(
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      minWidth: 340,
                      color: Colors.teal,
                      onPressed: () {
                        final name = nameController.text;
                        final email = emailController.text;
                        final phone = int.parse(phoneController.text);
                        final village = villageController.text;
                        final post = postController.text;
                        final poloce = policeController.text;

                        services
                            .dataStore(
                                name, email, phone, village, post, poloce)
                            .then((_) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GetScreen(),
                              ));
                        });
                      },
                      child: Text(
                        "Add Data",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
