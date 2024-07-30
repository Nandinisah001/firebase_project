import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/pdf_views/views_screen/pdf_screen.dart';
import 'package:firebase_project/pdf_views/views_screen/video_srceen.dart';
import 'package:flutter/material.dart';

import 'image_pic_srceen.dart';

class FolderScreen extends StatefulWidget {
  const FolderScreen({super.key});

  @override
  State<FolderScreen> createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  var folders = <Map>[];
  var folderTypes = ["Image", "Video", "Pdf"];
  var selectedType = "";
  TextEditingController folderNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Folders Select",style: TextStyle(
          color: Colors.teal,fontSize: 18
      ),)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewFolderDialog();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: getFolders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var folders = snapshot.data?.docs;
            return folders!.isNotEmpty
                ? ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    gotoNextScreenBasedOnType(folders[index]["type"]);
                  },
                  leading: Icon(Icons.folder),
                  title: Text(folders[index]["name"]),
                  subtitle: Text(folders[index]["type"]),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: folders.length,
            )
                : Center(
              child: Text("No folder found"),
            );
          } else {
            return Center(
              child: Text("No folder found"),
            );
          }
        },
      ),
    );
  }

  createNewFolderDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Create new folder"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField(
                items: folderTypes.map((type) {
                  return DropdownMenuItem(child: Text(type), value: type);
                }).toList(),
                onChanged: (type) {
                  selectedType = type ?? "";
                  setState(() {});
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: folderNameController,
                decoration: InputDecoration(hintText: 'Folder Name'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                addFolder();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  gotoNextScreenBasedOnType(String type) {
    if (type == folderTypes[0]) {
      // go to images screen
      goToNext(UploadFileScreen());
    } else if (type == folderTypes[1]) {
      // go to video screen
      goToNext(VideoScreen());
    } else {
      goToNext(PdfScreen());
    }
  }

  goToNext(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  addFolder() async {
    await FirebaseFirestore.instance
        .collection("folders")
        .add({"name": folderNameController.text, "type": selectedType}).then((v) {
      folderNameController.clear();
      selectedType = "";
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFolders() {
    return FirebaseFirestore.instance.collection("folders").snapshots();
  }
}