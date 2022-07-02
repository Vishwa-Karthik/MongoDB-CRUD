// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:mongodb_crud/dbHelper/mongodb.dart';
import 'package:mongodb_crud/delete.dart';
import 'package:mongodb_crud/display.dart';
import 'package:mongodb_crud/insert.dart';
import 'package:mongodb_crud/update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MongoDB',
      theme: ThemeData.dark(),
      home: MongoDbUpdate(),
    );
  }
}
