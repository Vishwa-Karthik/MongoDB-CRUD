// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names

import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_crud/MongoDBModel.dart';
import 'package:mongodb_crud/dbHelper/constants.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<void> update(MongoDbModel data) async {
    var result = await userCollection.findOne({"_id": data.id});
    result['firstName'] = data.firstName;
    result['LastName'] = data.lastName;
    result['address'] = data.address;
    var respone = await userCollection.save(result);
    inspect(respone);
  }

  static delete(MongoDbModel user) async {
    await userCollection.remove(where.id(user.id));
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data Inserted";
      } else {
        return "some Error in appending";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
