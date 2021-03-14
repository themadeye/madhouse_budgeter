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
  static final transaction_db = 'Transactions';
  //Column name
  static final transType = 'type';
  static final transId = 'id';
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
        // await db.execute(
        //   '''
        //   CREATE TABLE $transaction_db (
        //   $transId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        //   $transType NUM,
        //   $transCategory TEXT,
        //   $transDetail TEXT,
        //   $transAmount NUM,
        //   $transDate TEXT
        //   )
        //   '''
        // );
        await db.execute(
          "CREATE TABLE $transaction_db ("
          "$transId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  ,"
          "$transType INTEGER,"
          "$transCategory TEXT,"
          "$transDetail TEXT,"
          "$transAmount INTEGER,"
          "$transDate TEXT" ")"
        );
      }
    );
  }

  Future<int> insertTransaction(int type, String category, String memo, int amount, String date) async {
    final db = await database;
    var insertResult = await db.rawInsert('INSERT into ${transaction_db} (type, category, detail, amount, date)  VALUES (?,?,?,?,?)', [
      type,
      category,
      memo,
      amount,
      date]
    );
    return insertResult;
  }

  Future<List<Transactions>> getAllTransactionByPeriod() async {
    final db = await database;
    List<Map> results = await db.query('${transaction_db}', columns: ['type', 'category', 'detail', 'amount', 'date']);
    List<Transactions> trans = new List();
    results.forEach((result) {
      Transactions trs = Transactions.fromMap(result);
      trans.add(trs);
    });
     return trans;
  }
}