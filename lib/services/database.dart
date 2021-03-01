import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:madhouse_budgeter/model/transaction.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService db = DatabaseService._();
  //Table name
  static final transaction_db = 'Transaction';
  //Column name
  static final transId = 'id';
  static final transType = 'type';
  static final transCategory = 'category';
  static final transDetail = 'detail';
  static final transAmount = 'amount';
  static final transDate = 'date';
  static Database _database;

  Future<Database> get database async {
    if(_database != null){
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "Transaction.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          '''
           CREATE TABLE ${transaction_db} (
           ${transId}  INTEGER PRIMARY KEY,
           ${transType}  TEXT,
           ${transCategory}  TEXT,
           ${transDetail}  TEXT,
           ${transAmount}   INTEGER,
           ${transDate}  text ),
          '''
        );
      }
    );
  }
}