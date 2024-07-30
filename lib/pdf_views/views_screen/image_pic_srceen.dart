import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {
  List<String> imageFiles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uploaded Files"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takeFile();
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: getImage(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var images = snapshot.data!.docs;
                  return GridView.builder(
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(images[index]['imageurl']);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  takeFile() async {
    var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (fileResult != null) {
      var files = fileResult.files.map((path) => File(path.path!)).toList();
      for (var singleFile in files) {
        await uploadImages(singleFile);
      }
      setState(() {});
    }
  }

  Future<void> uploadImages(File file) async {
    var storage = FirebaseStorage.instance;
    try {
      var uploadTask = await storage
          .ref("profile/images/${file.path.split('/').last}")
          .putFile(file);
      var imageUrl = await uploadTask.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("image").add({
        "imageurl": imageUrl,
      });
      print(imageUrl);
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getImage() {
    return FirebaseFirestore.instance.collection("image").snapshots();
  }
}
