import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:mongodb_config/dbhelper/MongoDBModel.dart';
import 'package:mongodb_config/dbhelper/constants.dart';

//mongo_db="I53xHGuhNSRvGl7t"
class MongoDataBase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoDBModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      }
      return "Something went wrong";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
