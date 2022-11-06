import 'dart:developer';

import 'package:flutter_profile_app/MongoDBModel.dart';
import 'package:flutter_profile_app/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDBDatabase{
  static var db, userCollection;
  static connect() async{
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(COLLECTION_NAME);
    print(await userCollection.find().toList());
  }


//  function to fetch data from mongodb database
  static Future<List<Map<String, dynamic>>>getData() async{
    final arrData = await userCollection.find().toList();
    return arrData;
  }
//  creating function for button click to send data
static Future<String> insert(MongoDbModel data) async{
    try{
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted successfully";
      }
      else {
        return "Something went wrong";
      }
    }catch(e){
      print(e.toString());
      return e.toString();
    }
}
}