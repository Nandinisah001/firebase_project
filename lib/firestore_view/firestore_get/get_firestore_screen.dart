// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../firestore_screen.dart';
//
// class StudentsScreen extends StatefulWidget {
//   const StudentsScreen({super.key});
//
//   @override
//   State<StudentsScreen> createState() => _StudentsScreenState();
// }
//
// class _StudentsScreenState extends State<StudentsScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.teal,
//         title: Center(
//           child: Text(
//             'ShowData',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: "Enter your name",
//                   prefixIcon: Icon(Icons.near_me),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//                 controller: nameController,
//                 keyboardType: TextInputType.text,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: "Enter your email",
//                   prefixIcon: Icon(Icons.email),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20,right: 20,top: 30),
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: "Enter your phone number",
//                   prefixIcon: Icon(Icons.phone),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                   ),
//                 ),
//                 controller: phoneController,
//
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await addStudentData(nameController.text, emailController.text, phoneController.text);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => GetUserScreen(users: '',)
//                   ),
//                 );
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top:10),
//                 child: Text("Add Student"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> addStudentData(String name, String email, String phone) async {
//     var firestore = FirebaseFirestore.instance;
//     var students = firestore.collection("students");
//
//     await students.add({
//       "name": name,
//       "email": email,
//       "phone": phone,
//       "gender": "Female",
//       "age": 3,
//     }).then((ref) {
//       Fluttertoast.showToast(msg: "Document added with ID: ${ref.id}");
//       print("DocId: ${ref.id}");
//     }).catchError((FirebaseException error) {
//       Fluttertoast.showToast(msg: "Error: ${error.message}");
//     });
//   }
//
//   Stream<QuerySnapshot<Map<String, dynamic>>>? getAllTeachers()  {
//     var firestore = FirebaseFirestore.instance;
//     try {
//       var data = firestore.collection("student").orderBy('name',descending: true ).snapshots();
//       return data;
//     } catch (e) {
//       print("Error retrieving teachers data: $e");
//       return null;
//     }
//   }
//
//   Future<void> updateStudentData(String docId) async {
//     var firestore = FirebaseFirestore.instance;
//     var students = firestore.collection("students");
//
//     await students.doc(docId).update({
//       "name": "Kajal",
//       "email": "kajol@gmail.com",
//       "address": "Amnour",
//     }).then((_) {
//       Fluttertoast.showToast(msg: "Document updated successfully");
//       print("Document updated successfully");
//     }).catchError((error) {
//       Fluttertoast.showToast(msg: "Error: ${error}");
//     });
//   }
//
//   void showMyBottomSheet(String docId) {
//     var editNameController = TextEditingController();
//     var editEmailController = TextEditingController();
//     var editPhoneController = TextEditingController();
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Card(
//             color: Colors.teal,
//             child: Column(
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Enter your name",
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                   controller: editNameController,
//                 ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Enter your email",
//                     prefixIcon: Icon(Icons.email),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                   controller: editEmailController,
//                 ),
//                 const SizedBox(height: 15),
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Enter your phone",
//                     prefixIcon: Icon(Icons.phone),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     ),
//                   ),
//                   controller: editPhoneController,
//                 ),
//                 const SizedBox(height: 15),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await updateStudentData(docId);
//                     editNameController.text = '';
//                     editEmailController.text = '';
//                     editPhoneController.text = '';
//                     Navigator.pop(context);
//                     setState(() {
//
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Text(
//                       "Update",
//                       style: TextStyle(color: Colors.yellow),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }



 import 'package:flutter/material.dart';

import '../firestore_services_class.dart';
import '../update_firestore.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({Key? key}) : super(key: key);

  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  var docController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text(
          "GetData",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestoreService().getAllTeachers(),
          builder: (context, snapshot) {
            var teacherdata = snapshot.data?.docs.toList();
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: teacherdata?.length,
                itemBuilder: (context, index) {
                  var item = teacherdata![index];
                  return Card(
                    color: Colors.white60,
                    elevation: 20,
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] ?? 'No name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(item['email'] ?? 'No email'),
                          Text(item['phone']?.toString() ?? 'No phone'),
                          Text(item['useraddress']['village']?.toString() ?? 'No village'),
                          Text(item['useraddress']['post']?.toString() ?? 'No police'),
                          Text(item['useraddress']['police_station']?.toString() ?? 'No post'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              print("${item["name"]}");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateScreen(
                                      name: "${item['name']}",
                                      docId: item.id,
                                      phone: item['phone'],
                                      email: "${item['email']}",
                                    ),
                                  ));
                            },
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                FirebaseFirestoreService().deleteTeacher(teacherdata[index].id);
                              }
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }
}