import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'package:app/sqflite/HistorySQL.dart';
import 'package:app/sqflite/StockSQL.dart';
import 'package:app/sqflite/SalesSQL.dart';

import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
 
  factory DatabaseHelper() => _instance;
 
  final String tableStock = 'StockSQL';
  final String columnIdS = 'id';
  final String columnName = 'name';
  final String columnQuantity = 'quantity';

  final String tableHistory = 'HistorySQL';
  final String columnIdH = 'id';
  final String columnDay = 'day';
  final String columnMonth = 'month';
  final String columnYear = 'year';
  final String columnSum = 'sum';  
 
  final String tableSales = 'SalesSQL';
  final String columnSalesId = 'saleId';
  final String columnSalesP = 'saleP';
  final String columnSalesQ = 'saleQ';
  final String columnSalesS = 'saleS';
 
  var lock = Lock();
  static Database _db;
 
  DatabaseHelper.internal();
 
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }else{
      _db = await initDb();
    }
    return _db;
  }
 
  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'wigo.db');
 
    //await deleteDatabase(path); // just for testing
 
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
 
  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableStock($columnIdS INTEGER PRIMARY KEY, $columnName TEXT, $columnQuantity INTEGER)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableHistory($columnIdH INTEGER PRIMARY KEY, $columnDay INTEGER, $columnMonth INTEGER, $columnYear INTEGER, $columnSum NUMERIC)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $tableSales($columnSalesId INTEGER PRIMARY KEY, $columnSalesP TEXT, $columnSalesQ INTEGER, $columnSalesS INTEGER)');
  }

  void onUpgrade(Database db,int oldVersion,int newVersion){
    db.execute("DROP TABLE IF EXISTS $tableStock");
    db.execute("DROP TABLE IF EXISTS $tableHistory");
    db.execute("DROP TABLE IF EXISTS $tableSales");
  }
 
  Future<int> saveHistory(HistorySQL history) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableHistory, history.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
 
    return result;
  }
  Future<int> saveStock(StockSQL stock) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableStock, stock.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
 
    return result;
  }
  Future<int> saveSales(SalesSQL sale) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableSales, sale.toMap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
 
    return result;
  }
 
  Future<List> getAllHistory() async {
    var dbClient = await db;
    //var result = await dbClient.query(tableHistory, columns: [columnIdH, columnDay ,columnMonth, columnYear, columnSum]);
    var result = await dbClient.rawQuery('SELECT day, month, year, SUM(sum) as sum FROM $tableHistory GROUP BY year, month, day ' );
 
    return result.toList();
  }
  Future<List> getAllStock() async {
    var dbClient = await db;
    //var result = await dbClient.query(tableStock, columns: [columnIdS, columnName, columnQuantity]);
    var result = await dbClient.rawQuery("SELECT name,SUM(quantity) as quantity FROM $tableStock GROUP BY name");
 
    return result.toList();
  }
  Future<List> getAllSale() async {
    var dbClient = await db;
    //var result = await dbClient.query(tableStock, columns: [columnIdS, columnName, columnQuantity]);
    var result = await dbClient.rawQuery("SELECT saleP as saleP,SUM(saleQ) as saleQ , SUM(saleS) as saleS FROM $tableSales GROUP BY saleP ORDER BY saleS DESC");
 
    return result.toList();
  }
 
  Future<int> getCountH() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) as total FROM $tableHistory'));
  }
  Future<int> getCountS() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) as total FROM $tableStock'));
  }
 
  Future<HistorySQL> getHistory(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableHistory,
        columns: [columnIdH, columnDay, columnMonth, columnYear, columnSum],
        where: '$columnIdH = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
 
    if (result.length > 0) {
      return new HistorySQL.fromMap(result.first);
    }
 
    return null;
  }
  Future<StockSQL> getStock(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableStock,
        columns: [columnIdH, columnName, columnQuantity],
        where: '$columnIdS = ?',
        whereArgs: [id]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
 
    if (result.length > 0) {
      return new StockSQL.fromMap(result.first);
    }
 
    return null;
  }
 
  Future<int> deleteHistory(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableHistory, where: '$columnIdH = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
  Future<int> deleteStock(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableHistory, where: '$columnIdS = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
 
  Future<int> updateHistory(HistorySQL history) async {
    var dbClient = await db;
    return await dbClient.update(tableStock, history.toMap(), where: "$columnIdH = ?", whereArgs: [history.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
  Future<int> updateStock(StockSQL stock) async {
    var dbClient = await db;
    return await dbClient.update(tableStock, stock.toMap(), where: "$columnIdS = ?", whereArgs: [stock.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
  

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}