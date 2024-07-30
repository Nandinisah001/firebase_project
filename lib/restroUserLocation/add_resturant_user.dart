
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddResturentUser extends StatefulWidget {
  const AddResturentUser({super.key});

  @override
  State<AddResturentUser> createState() => _AddResturentUserState();
}

class _AddResturentUserState extends State<AddResturentUser> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: const Text("Add User"),
      ),
      body: Center(
        child: Card(
          child: Column(
            children: [
              Image.network('https://media-cdn.tripadvisor.com/media/photo-s/12/59/51/9c/wjw-restro-cafe-wah-ji.jpg'),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                    ),
                prefixIcon: const Icon(Icons.person,color: Colors.blueGrey,),
                labelText: 'Name'
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.add_location,color: Colors.blueGrey,),
                    labelText: 'address'
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: const Icon(Icons.description,color: Colors.blueGrey,),
                    labelText: 'description'
                ),
              ),
              ElevatedButton(onPressed: (){
                addUser();
              }, child: const Text("Choose Location")),
            ],
          ),
        ),
      ),
    );
  }

  Future<void>addUser()async{
    var firestore = FirebaseFirestore.instance;
        await firestore.collection("teachers_data").add({
      "name": nameController,
      "address": addressController,
      "description": descriptionController,
    });
  }

}
