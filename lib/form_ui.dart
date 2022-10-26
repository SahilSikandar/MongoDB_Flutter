import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb_config/dbhelper/MongoDBModel.dart';
import 'package:mongodb_config/dbhelper/mongodb_config.dart';

class Form_Ui extends StatefulWidget {
  const Form_Ui({super.key});

  @override
  State<Form_Ui> createState() => _Form_UiState();
}

class _Form_UiState extends State<Form_Ui> {
  var fnameController = TextEditingController();
  var lnameController = TextEditingController();
  var addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mongodb data insertion"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: fnameController,
                decoration: InputDecoration(
                    label: Text("First Name"), border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: lnameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "Last Name",
                    //style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: addressController,
                minLines: 3,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Address"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        _fakerdata();
                      },
                      child: Text("Generate Data")),
                  ElevatedButton(
                      onPressed: () {
                        _insertData(fnameController.text, lnameController.text,
                            addressController.text);
                      },
                      child: Text("insert data"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _insertData(String fname, String lname, String address) async {
    var _id = M.ObjectId();
    final data = MongoDBModel(
        sId: _id, firstname: fname, lastname: lname, address: address);
    var result = await MongoDataBase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Inserted Id" + _id.$oid)));
    _clearall();
  }

  void _clearall() {
    fnameController.text = "";
    lnameController.text = "";
    addressController.text = "";
  }

  void _fakerdata() {
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text =
          faker.address.streetName() + "\n" + faker.address.streetAddress();
    });
  }
}
