import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_profile_app/MongoDBModel.dart';

class UserDetail extends StatelessWidget {
  final MongoDbModel userDataModel;

  const UserDetail({Key? key, required this.userDataModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userDataModel.name),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image:  FileImage(File(userDataModel.img)),
                  fit: BoxFit.contain
              ),
            ),
          ),
          new Text("Name: ${userDataModel.name}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
          new Text("Age: ${userDataModel.age}",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20)),
          new Text("Phone no.: ${userDataModel.phone}",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20)),
          new Text("Department: ${userDataModel.dept}",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20)),
        ],
      ),
    );
  }
}

class UserDataModel{
  final String name,age,phone,dept;
  UserDataModel(this.name, this.age, this.phone, this.dept);
}