import 'package:galeri_teknologi_bersama/data/model/bio.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _instance;
  static Database _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblUsers = 'family';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/d93e38491636a26acc70e8380eaf8d49c89c4979.db',
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $_tblUsers (
              id integer primary key autoincrement, 
      identityNumber TEXT,
   identityParentNumber TEXT,
  name TEXT,
  gender TEXT ,
  birthDay TEXT,
  birthPlace TEXT,
  nationality TEXT,
  address TEXT,
  phone TEXT,
  email TEXT
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

  Future<void> insertData(Bio bio) async {
    final db = await database;
    await db.insert(_tblUsers, bio.toJson());
  }

  Future<List<Bio>> getData() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblUsers);

    return results.map((res) => Bio.fromJson(res)).toList();
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
}
