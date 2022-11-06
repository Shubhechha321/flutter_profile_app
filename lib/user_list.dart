import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_profile_app/MongoDBModel.dart';
import 'package:flutter_profile_app/mongodb.dart';
import 'package:flutter_profile_app/user_detail.dart';

class UserListPage extends StatefulWidget {
  UserListPage({Key? key}) : super(key: key);

  @override
  UserListPageState createState() => UserListPageState();
}

class UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Container(
          child: new Center(
            child: FutureBuilder(
              future: MongoDBDatabase.getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else {
                    if (snapshot.hasData) {
                      return new ListView.builder(
                        // itemCount: snapshot.data.length(),
                        itemBuilder: (BuildContext context, index) {
                          var data = MongoDbModel.fromJson(snapshot.data[index]);
                          return new Card(
                            child: new ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:  FileImage(File(data.img)),
                                      fit: BoxFit.contain
                                  ),
                                ),
                              ),
                              title: Text(data.name),
                              subtitle: Text(data.dept),

                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserDetail(userDataModel: data,)));
                              },
                            )
                          );
                        },
                        // itemCount: beers == null ? 0 : beers.length,
                        itemCount: snapshot.data.length,
                      );
                    }
                    else {
                      return Center(
                        child: Text("No Data Available"),
                      );
                    }
                  }
                }
                ),
          ),
        ));
  }
}