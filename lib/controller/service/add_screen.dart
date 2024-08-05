import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as lo;
import 'dart:io';
import 'database_db.dart';
import 'model_todo.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  AddTaskScreen({this.task});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imagePath;
  String? _address;
  bool _isLoading = false;

  var taskKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _imagePath = widget.task!.imagePath;
      _address = widget.task!.address;
    }
    _getLocation();
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _getLocation() async {
    setState(() {
      _isLoading = true;
    });
    final location = lo.Location();
    final locData = await location.getLocation();

    if (locData.latitude != null && locData.longitude != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(locData.latitude!, locData.longitude!);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _address = "${place.subLocality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveTask() async {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty && description.isNotEmpty && _imagePath != null && _address != null) {
      if (widget.task == null) {
        final task = Task(
          title: title,
          description: description,
          imagePath: _imagePath!,
          address: _address!,
        );
        await DBHelper().insertTask(task);
      } else {
        final task = Task(
          id: widget.task!.id,
          title: title,
          description: description,
          imagePath: _imagePath!,
          address: _address!,
        );
        await DBHelper().updateTask(task);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(widget.task == null ? 'Add Data' : 'Update Data'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: taskKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: InkWell(
                  onTap: _getImage,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                    child: _imagePath == null
                        ? Icon(Icons.camera_alt, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              if (_address != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Address: $_address', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              SizedBox(height: 20),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : MaterialButton(
                color: Colors.white,
                onPressed: () {
                  if (taskKey.currentState!.validate()) {
                    _saveTask();
                  }
                },
                child: Text(widget.task == null ? 'Add Data' : 'Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
