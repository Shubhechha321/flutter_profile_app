import 'dart:convert';

import 'dart:ffi';

import 'package:mongo_dart/mongo_dart.dart';


MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  MongoDbModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.dept,
    required this.img,
});

  ObjectId id;
  String name;
  String age;
  String phone;
  String dept;
  String img;

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(id: json["_id"], name: json["name"], age: json["age"], phone: json["phone"],dept: json["dept"], img: json["img"]);
  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "name": name,
        "age": age,
        "phone": phone,
        "dept": dept,
        "img": img,
      };
}