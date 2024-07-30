import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  File? selectedVideo;
  List<File> video = <File>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          takeMultiVideo();
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: getUploadedVideo(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          var videoDocs = snapshot.data?.docs;
          if (videoDocs?.isNotEmpty == true) {
            return ListView.builder(
              itemCount: videoDocs?.length,
              itemBuilder: (context, index) {
                var videoUrl = videoDocs![index]['url'];
                return Container(
                  height: 400,
                  width: double.infinity,
                  color: Colors.blue,
                  child: VideoApp(videoUrl: videoUrl),
                );
              },
            );
          } else {
            return Center(
              child: Text("No videos available"),
            );
          }
        },
      ),
    );
  }

  takeMultiVideo() async {
    FilePickerResult? pickerVideo = await FilePicker.platform.pickFiles(
        allowMultiple: true, type: FileType.video);
    if (pickerVideo != null) {
      var files = pickerVideo.files.map((file) => File(file.path!)).toList();
      for (var multiVideo in files) {
        uploadVideo(multiVideo);
      }
    }
  }

  uploadVideo(File file) {
    var storage = FirebaseStorage.instance;
    storage
        .ref("FOLDER-VIDEO")
        .child(file.path.split("/").last)
        .putFile(file)
        .then((value) async {
      var videoUrl = await value.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("videos").add({"url": videoUrl});
      Fluttertoast.showToast(msg: "Video uploaded");
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUploadedVideo() {
    return FirebaseFirestore.instance.collection("videos").snapshots();
  }
}

class VideoApp extends StatefulWidget {
  final String videoUrl;
  const VideoApp({required this.videoUrl});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
