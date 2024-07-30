import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class UploadFileScreen extends StatefulWidget {
  const UploadFileScreen({super.key});

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

class _UploadFileScreenState extends State<UploadFileScreen> {

  List<File> multiFiles = <File>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,
        title: Text("Uploaded File"),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            takeFile();
          }, child: Text("take file"))
        ],
      ),
    );
  }

  takeFile()async{
    var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(fileResult != null){
      var files = fileResult.files.map((path) => File(path.path!)).toList();
      for(var singleFile in files){
        multiFiles.add(singleFile);
        // uploadImage();
      }
      setState(() {});
    }
  }
  uploadImage(File file){
    var storage = FirebaseStorage.instance;
    storage.ref("UploadFile").child("image").putFile(file).then((value)async{
      var imagesUrl = await value.ref.getDownloadURL();
      print("uploadimag${imagesUrl}");
    });
  }
}







// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// class UploadFileScreen extends StatefulWidget {
//   const UploadFileScreen({super.key});
//
//   @override
//   State<UploadFileScreen> createState() => _UploadFileScreenState();
// }
//
// class _UploadFileScreenState extends State<UploadFileScreen> {
//   List<File> imageFiles = [];
//   List<File> videoFiles = [];
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Uploaded Files"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 takeFile();
//               },
//               child: const Text("Select Files"),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading) CircularProgressIndicator(),
//             Expanded(
//               child: ListView(
//                 children: [
//                   if (imageFiles.isNotEmpty) ...[
//                     const Text(
//                       "Images",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...imageFiles.map((file) => ListTile(
//                           title: Text(file.path.split("/").last),
//                           leading: const Icon(Icons.image),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.cloud_upload),
//                             onPressed: () => uploadFile(file),
//                           ),
//                         )),
//                   ],
//                   if (videoFiles.isNotEmpty) ...[
//                     const Text(
//                       "Videos",
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     ...videoFiles.map((file) => ListTile(
//                           title: Text(file.path.split("/").last),
//                           leading: const Icon(Icons.video_library),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.cloud_upload),
//                             onPressed: () => uploadFile(file),
//                           ),
//                         )),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   takeFile() async {
//     var fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (fileResult != null) {
//       var files = fileResult.files.map((file) => File(file.path!)).toList();
//       for (var singleFile in files) {
//         var extension = singleFile.path.split(".").last.toLowerCase();
//         if (extension == "jpg" || extension == "png") {
//           imageFiles.add(singleFile);
//         } else if (extension == "mp4" || extension == "mkv") {
//           videoFiles.add(singleFile);
//         }
//         print("Extension: $extension");
//       }
//       setState(() {});
//     }
//   }
//
//   uploadFile(File file) async {
//     setState(() {});
//     var storage = FirebaseStorage.instance;
//     var uploadTask = storage
//         .ref("UploadedFiles")
//         .child(file.path.split("/").last)
//         .putFile(file);
//
//     await uploadTask.whenComplete(() async {
//       var fileUrl = await uploadTask.snapshot.ref.getDownloadURL();
//       print("File URL: $fileUrl");
//     });
//
//     setState(() {
//       isLoading = false;
//     });
//   }
// }
