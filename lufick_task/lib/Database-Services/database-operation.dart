import 'dart:convert';

import 'package:lufick_task/Database-Services/database-helper.dart';

class DatabaseOperations {
  DatabaseHelper dbHelper;

  DatabaseOperations() {
    dbHelper = new DatabaseHelper();
    dbHelper.initDb();
  }

  Future<void> cleanDatabase() async {
    try{
      final db = await dbHelper.db;
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete("Currancy");
        await batch.commit();


      });
    } catch(error){
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

  saveIntoDB(model) async {
    final db = await dbHelper.db;
    for (int i = 0; i < model.length; i++) {
      await db.insert("Currancy", model[i].toJson());
    }
  }
}
