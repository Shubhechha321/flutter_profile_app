import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_profile_app/MongoDBModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

import 'mongodb.dart';
enum ImageSourceType { gallery, camera }
class MongoDBInsert extends StatefulWidget {
  MongoDBInsert({Key? key}) : super(key: key);

  @override
  _MongoDBInsertState createState() => _MongoDBInsertState();
}

class _MongoDBInsertState extends State<MongoDBInsert>{
  var nameController = new TextEditingController();
  var ageController = new TextEditingController();
  var phController = new TextEditingController();
  late String fileName;
  File? pickedImage;
  bool isPicked = false;
  // Default Drop Down Item.
  String dropdownValue = 'HR';

  // To show Selected Item in Text.
  String holder = '' ;

  List <String> deptName = [
    'HR',
    'Finance',
    'Housekeeping',
    'Marketing'
  ] ;

  void getDropDownItem(){

    setState(() {
      holder = dropdownValue ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
        Expanded(
        child: Container(
            child: isPicked
              ? Image.file(
              pickedImage!,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 2,
            )
                : Container(
          color: Colors.blueGrey[100],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * (4 / 3),
          ),
            ),),

            SizedBox(
              height: 50,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: phController,
              decoration: InputDecoration(labelText: "Phone number"),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.red, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: deptName.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(onPressed: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image =
              await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                pickedImage = File(image.path);
                setState(() {
                  isPicked = true;
                });
                fileName = image.path;
              }

            }, child: Text("Upload Photo")),
            ElevatedButton(onPressed: () {
              _insertData(nameController.text, ageController.text, phController.text, dropdownValue, fileName);
            }, child: Text("Insert Data"))
          ],
        )
      ))
    );
  }

  Future<void> _insertData(String name, String age, String phone, String dept, String img) async{
    var _id = M.ObjectId();
    final data = MongoDbModel(id: _id, name: name, age: age, phone: phone, dept: dept, img: img);
    var result = await MongoDBDatabase.insert(data);
  }
}

