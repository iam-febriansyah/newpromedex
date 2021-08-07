//import 'package:galeri_teknologi_bersama/data/model/historyorder.dart';
import 'package:galeri_teknologi_bersama/data/model/historyorderhomecare.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHistoryOrderHelper {
  static DatabaseHistoryOrderHelper _instance;
  static Database _database;

  DatabaseHistoryOrderHelper._internal() {
    _instance = this;
  }

  factory DatabaseHistoryOrderHelper() =>
      _instance ?? DatabaseHistoryOrderHelper._internal();

  static const String _tblUsers = 'historyOrder';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/d93e38491636a26acc70e8380eaf8d49c89c497901.db',
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tblUsers (
              id integer primary key autoincrement, 
           idReservation TEXT,
        invoiceNumber TEXT,
        customerName TEXT,
        customerEmail TEXT,
        customerPhone TEXT,
        address TEXT,
        latitude TEXT,
        longitude TEXT,
        status TEXT,
        status_string TEXT,
        reservationType TEXT,
        transactionId TEXT,
        vaNumber TEXT,
        totalPrice integer,
        channel TEXT,
        expiredTime TEXT,
        successTime TEXT,
        idswabber TEXT,
        name TEXT,
        phone TEXT,
        email TEXT,
        lastUpdateLocation TEXT
           )     
        ''');
      },
      version: 3,
    );

    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }
    return _database;
  }

  Future<void> insertData(HistoryOrderHomeCare bio) async {
    final db = await database;
    await db.insert(_tblUsers, bio.toJson());
  }

  Future<List<HistoryOrderHomeCare>> getData() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblUsers);

    return results.map((res) => HistoryOrderHomeCare.fromJson(res)).toList();
  }

  Future<List<HistoryOrderHomeCare>> getDataLimitDesc() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tblUsers, orderBy: "id DESC", limit: 1);

    return results.map((res) => HistoryOrderHomeCare.fromJson(res)).toList();
  }

  Future<Map> getDataByUnique(String url) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblUsers,
      where: 'id = ?',
      whereArgs: [url],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeData(String url) async {
    final db = await database;

    await db.delete(
      _tblUsers,
      where: 'id = ?',
      whereArgs: [url],
    );
  }

  Future<void> removeDataAll(String url) async {
    final db = await database;

    await db.delete(_tblUsers);
  }
}
