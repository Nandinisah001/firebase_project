import 'package:flutter/material.dart';

import 'firestore_services_class.dart';
import 'mixin_screen.dart';


class UpdateScreen extends StatefulWidget with FirestoreMixin{
  String docId;
  String name;
  String email;
  num phone;

  UpdateScreen(
      {Key? key,
        required this.docId,
        required this.phone,
        required this.name,
        required this.email})
      : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController docIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.email;
    emailController.text=widget.name;
    phoneController.text = int.parse("${widget.phone}").toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Update Screen",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.viewTextFild("name", nameController,Icons.person),
            SizedBox(height: 10),
            widget. viewTextFild("email", emailController,Icons.email),
            SizedBox(height: 10),
            widget. viewTextFild("phone", phoneController,Icons.phone),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestoreService().updateTeacher(
                    widget.docId,
                    nameController.text,
                    emailController.text,
                    int.parse(phoneController.text));
                Navigator.pop(context);
              },
              child: Text('Update'),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.blueGrey) ),
            ),
          ],
        ),
      ),
    );
  }
}