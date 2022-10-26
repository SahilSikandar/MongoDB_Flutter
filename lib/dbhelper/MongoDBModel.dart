import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDBModel {
  ObjectId? sId;
  String? firstname;
  String? lastname;
  String? address;

  MongoDBModel({this.sId, this.firstname, this.lastname, this.address});

  MongoDBModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['address'] = this.address;
    return data;
  }
}
