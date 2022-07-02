// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unused_local_variable, library_prefixes

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongodb_crud/MongoDBModel.dart';
import 'package:mongodb_crud/dbHelper/mongodb.dart';

import 'package:mongo_dart/mongo_dart.dart' as M;

class MongoDbInsert extends StatefulWidget {
  const MongoDbInsert({Key? key}) : super(key: key);

  @override
  State<MongoDbInsert> createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();

  var _checkInsertUpdate = "Insert";
  @override
  Widget build(BuildContext context) {
    MongoDbModel data =
        ModalRoute.of(context)!.settings.arguments as MongoDbModel;

    if (data != null) {
      fnameController.text = data.firstName;
      lnameController.text = data.lastName;
      addressController.text = data.address;
      _checkInsertUpdate = "Update";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("MongoDB"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                _checkInsertUpdate,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: fnameController,
                decoration: InputDecoration(labelText: "First Name"),
              ),
              TextField(
                controller: lnameController,
                decoration: InputDecoration(labelText: "Last Name"),
              ),
              TextField(
                minLines: 3,
                maxLines: 5,
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _fakeData();
                      },
                      child: Text("Generate Data")),
                  ElevatedButton(
                      onPressed: () {
                        if (_checkInsertUpdate == "Update") {
                          _updateData(data.id, fnameController.text,
                              lnameController.text, addressController.text);
                        } else {
                          _insertData(fnameController.text,
                              lnameController.text, addressController.text);
                        }
                      },
                      child: Text(_checkInsertUpdate))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateData(
      var id, String fName, String lName, String address) async {
    final updateData = MongoDbModel(
        id: id, firstName: fName, lastName: lName, address: address);
    await MongoDatabase.update(updateData)
        .whenComplete(() => Navigator.pop(context));
  }

  Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(
        id: _id, firstName: fName, lastName: lName, address: address);
    var result = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted ID" + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakeData() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetName() + "\n" + faker.address.streetAddress();
    });
  }
}
