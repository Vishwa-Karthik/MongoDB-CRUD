// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_import

import 'package:flutter/material.dart';
import 'package:mongodb_crud/MongoDBModel.dart';
import 'package:mongodb_crud/dbHelper/mongodb.dart';
import 'package:mongodb_crud/insert.dart';
import 'dart:core';

class MongoDbUpdate extends StatefulWidget {
  const MongoDbUpdate({Key? key}) : super(key: key);

  @override
  State<MongoDbUpdate> createState() => _MongoDbUpdateState();
}

class _MongoDbUpdateState extends State<MongoDbUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MongoDB Update"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return displayCard(
                              MongoDbModel.fromJson(snapshot.data[index]));
                        });
                  } else {
                    return Center(
                      child: Text("No Data Available"),
                    );
                  }
                }
              })),
    );
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${data.id}"),
                const SizedBox(
                  height: 5,
                ),
                Text(data.firstName),
                const SizedBox(
                  height: 5,
                ),
                Text(data.lastName),
                const SizedBox(
                  height: 5,
                ),
                Text(data.address),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MongoDbInsert();
                          },
                          settings: RouteSettings(arguments: data)));
                },
                icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
