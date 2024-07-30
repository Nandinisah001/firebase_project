import 'package:flutter/material.dart';
mixin class FirestoreMixin{
  viewTextFild(String name,TextEditingController controller,[IconData?icon,String?level]){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: name,
        labelText: level,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))
        )
      ),
    );
  }

}