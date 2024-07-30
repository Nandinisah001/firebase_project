// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageScreen extends StatefulWidget {
//   const ImageScreen({super.key});
//
//   @override
//   State<ImageScreen> createState() => _ImageScreenState();
// }
//
// class _ImageScreenState extends State<ImageScreen> {
//   XFile? imageFile;
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Take Image",
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         ),
//         backgroundColor: Colors.deepOrangeAccent,
//       ),
//       body: ListView(
//         children: [
//           Column(
//             children: [
//               imageFile == null
//                   ? Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Center(
//                   child: ClipOval(
//                     child: Container(
//                       height: 220,
//                       width: 200,
//                       color: Colors.blue,
//                       child: Image.network(
//                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtMM9P1O04SAekcIPka5rivN8y4kfcddDO2A&s",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//                   : Image.file(File(imageFile?.path ?? "")),
//               ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStatePropertyAll(Colors.teal),
//                   ),
//                   onPressed: () {
//
//                     imageTake();
//                   },
//                   child: Text(
//                     "Take Image",
//                     style: TextStyle(color: Colors.white),
//                   )),
//               ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: WidgetStatePropertyAll(Colors.pink)),
//                   onPressed: () {
//                     cameraTake();
//                   },
//                   child: Text(
//                     "Take Camera",
//                     style: TextStyle(color: Colors.black),
//                   )),
//               TextField(
//                 controller: nameController,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20))),
//               ),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20))),
//               ),
//               ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: WidgetStatePropertyAll(Colors.orange)),
//                   onPressed: () {
//                     uploadImage(nameController.text, emailController.text);
//                   },
//                   child: Text(
//                     "Upload",
//                     style: TextStyle(color: Colors.white),
//                   ))
//             ],
//           ),
//         ],
//       )
//
//     );
//   }
//
//   imageTake() async {
//     var imagePicker = ImagePicker();
//     var image = await imagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       imageFile = image!;
//     });
//   }
//
//   cameraTake() async {
//     var imagePicker = ImagePicker();
//     var image = await imagePicker.pickImage(source: ImageSource.camera);
//     setState(() {
//       imageFile = image!;
//     });
//   }
//
//   uploadImage(String name, String email) async {
//     var storage = FirebaseStorage.instance;
//     await storage.ref("profileImage").child(imageFile?.name ?? "").putFile(File(imageFile?.path ?? "")).then((value) async {
//       var imageUrl = await value.ref.getDownloadURL();
//       FirebaseFirestore.instance.collection("profiles")
//           .add({"name": name, "email": email, "  imageUrl": imageUrl});
//     });
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  XFile? imageFile;
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Take Image",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                imageFile == null
                    ? Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipOval(
                    child: Container(
                      height: 220,
                      width: 200,
                      color: Colors.blue,
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtMM9P1O04SAekcIPka5rivN8y4kfcddDO2A&s",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    : ClipOval(
                  child: Container(
                    height: 220,
                    width: 200,
                    child: Image.file(File(imageFile?.path ?? ""), fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.teal),
                    ),
                    onPressed: () {
                      imageTake();
                    },
                    child: Text(
                      "Take_Image",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      cameraTake();
                    },
                    child: Text(
                      "Take_Camera",
                      style: TextStyle(color: Colors.black),
                    ),
                ) ,
                ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.pink)),
                  onPressed: () {
                  },
                  child: Text(
                    "Image_get",
                    style: TextStyle(color: Colors.black),
                  ),
                ) ,

                SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black)),
                    onPressed: () {
                      uploadImage(nameController.text, emailController.text);
                    },
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  imageTake() async {
    var imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = image!;
    });
  }

  cameraTake() async {
    var imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = image!;
    });
  }

  uploadImage(String name, String email) async {
    var storage = FirebaseStorage.instance;
    await storage
        .ref("profileImage")
        .child(imageFile?.name ?? "")
        .putFile(File(imageFile?.path ?? ""))
        .then((value) async {
      var imageUrl = await value.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("profiles").add({
        "name": name,
        "email": email,
        "imageUrl": imageUrl,
      });
    });
  }
}

