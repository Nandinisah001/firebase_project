// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
//
// class Uploadimage extends StatefulWidget {
//   const Uploadimage({super.key});
//
//   @override
//   State<Uploadimage> createState() => _UploadimageState();
// }
//
// class _UploadimageState extends State<Uploadimage> {
//   List<File>? multipalFile =<File>[];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Screen"),
//       ), body: Column(
//       children: [
//         MaterialButton(onPressed: () {
//           takeFile();
//         }),
//         Text("data"),
//         MaterialButton(onPressed: () {
//
//         }),
//         Text("images")
//       ],
//     ),
//     );
//   }
//
//   takeFile() async{
//     var fileResul = await FilePicker.platform.pickFiles(allowMultiple: true);
//     if (fileResul != null) {
//       var files = fileResul.files.map((path) => File(path.path!)).toList();
//       for (var singleFile in files) {
//         multipalFile?.add(singleFile);
//         setState(() {
//
//         });
//       }
//     }
//   }
//
//   uploadImage(File file) async {
//     var storage = FirebaseStorage.instance;
//
//       storage.ref("profileImage").child(file.path.split("/").last).putFile(file).then((value)async{
//       var imagesUrl = await value.ref.getDownloadURL();
//       print(imagesUrl);
//     });
//   }
//
//
// }
//

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Uploadimage extends StatefulWidget {
  const Uploadimage({Key? key}) : super(key: key);
  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  File? selectedImage;
  List<File> multipleFiles = <File>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(child: Text("Upload Images")),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,

              color: Colors.grey[300],
              child: selectedImage != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.teal,
                    ),
            ),

            ElevatedButton(
              style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.pink)),
              onPressed: () {
                takeSingleImage();
              },
              child: Text("Pick Single Image"),
            ),


            SizedBox(height: 20
            ),
            multipleFiles.isNotEmpty
            ?Container(
              height: 330,
              child: GridView.builder(gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: multipleFiles.length,
              itemBuilder: (context,index){
                return Image.file(multipleFiles[index],
                fit: BoxFit.cover,);
              },),
            ):
            Expanded(
              child: ListView.builder(
                itemCount: multipleFiles.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    width: 200,

                    child: Column(
                      children: [
                        Image.file(
                          multipleFiles[index],
                          fit: BoxFit.contain,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white12)),
                onPressed: () {
                  takeMultiImages();
                },
                child: Text(" Multiple** Images")
            ),

            ElevatedButton(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                onPressed: () {
                  takeMultiImages();
                },
                child: Text(" upload** Images")
            ),

    ]
        ),
      ),
    );
  }

  takeSingleImage() async {FilePickerResult? pickerImage = await FilePicker.platform.pickFiles();if (pickerImage != null) {
      File file = File(pickerImage.files.single.path!);
      setState(() {
        selectedImage = file;
      });
      uploadImage(file);
    } else {}
  }

  takeMultiImages() async {FilePickerResult? pickerImages = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (pickerImages != null) {
      var files = pickerImages.files.map((file) => File(file.path!)).toList();
      setState(() {
        multipleFiles.addAll(files);
      });
      for (var multiImage in files) {
        uploadImage(multiImage);
      }
    }
  }

  uploadImage(File file) async {
    var storage = FirebaseStorage.instance;
    storage.ref("profileImage").child(file.path.split("/").last).putFile(file).then((value) async {
      var imagesUrl = await value.ref.getDownloadURL();
      print(imagesUrl);Fluttertoast.showToast(msg:"Images upload");
    }
    );
  }
}
