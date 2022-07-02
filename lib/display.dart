// ignore_for_file: prefer_const_constructors, avoid_print, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:mongodb_crud/MongoDBModel.dart';
import 'package:mongodb_crud/dbHelper/mongodb.dart';

class MongoDbDisplay extends StatefulWidget {
  const MongoDbDisplay({Key? key}) : super(key: key);

  @override
  State<MongoDbDisplay> createState() => _MongoDbDisplayState();
}

class _MongoDbDisplayState extends State<MongoDbDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MongoDB Display"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  var totalData = snapshot.data.length;
                  print("Total Data" + totalData.toString());
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return displayCard(
                            MongoDbModel.fromJson(snapshot.data[index]));
                      });
                } else {
                  return Center(
                    child: Text("No Data"),
                  );
                }
              }
            }),
      )),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Text("${data.id}"),
          SizedBox(
            height: 5,
          ),
          Text("${data.firstName}"),
          SizedBox(
            height: 5,
          ),
          Text("${data.lastName}"),
          SizedBox(
            height: 5,
          ),
          Text("${data.address}"),
        ]),
      ),
    );
  }
}
