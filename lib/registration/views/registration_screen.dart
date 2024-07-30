import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.teal,
      appBar:  AppBar(
        title: Text("RegistrationScreen"),
      ),body: Column(
      children: [
        ElevatedButton(onPressed: (){
          registrationUsers();
        }, child: Text("Registration",style: TextStyle(color: Colors.pink),)),
        ElevatedButton(onPressed: (){
          loginUsers();
        }, child: Text("Login")),
      ],
    ),
    );
  }
  registrationUsers()async{
    var firestore =FirebaseFirestore.instance;
    var exisUsers = await firestore.collection("users").where("email",isEqualTo: "jyoti@gamil.com").get();
    if(exisUsers.docs.isNotEmpty){
      Fluttertoast.showToast(msg: "email already exisi");
    }
    else{
      await firestore.collection("users").add(({
        "email":"jyoti@gamil.com",
        "password":"12345",
      }));
    }
  }
  loginUsers()async{
    var fireStore = FirebaseFirestore.instance;
    var existUsers = await fireStore.collection("users").where("email",isEqualTo: "aashika@gmail.com").get();
    var isValidUsers = existUsers.docs.firstWhere((users)=>users.data()['password'] =='123456').exists;
    if(isValidUsers){
      Fluttertoast.showToast(msg: "login successfull");
    }else{
    Fluttertoast.showToast(msg: "please registion first");
    }
  }

}
