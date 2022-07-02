// ignore_for_file: avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:mongodb_crud/MongoDBModel.dart';
import 'package:mongodb_crud/dbHelper/mongodb.dart';

class MongoDbDelete extends StatefulWidget {
  const MongoDbDelete({Key? key}) : super(key: key);

  @override
  State<MongoDbDelete> createState() => _MongoDbDeleteState();
}

class _MongoDbDeleteState extends State<MongoDbDelete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MongoDb Delete"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _dataCard(
                              MongoDbModel.fromJson(snapshot.data[index]));
                        });
                  } else {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }
                }
              })),
    );
  }

  Widget _dataCard(MongoDbModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.firstName,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.lastName,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.address,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            IconButton(
                onPressed: () async {
                  await MongoDatabase.delete(data);
                  setState(() {});
                },
                icon: const Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}
