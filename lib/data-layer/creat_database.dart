import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CreateDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initializeDb();
    }
    return _db;
  }

  Future<Database> _initializeDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'new.db');
    Database mydb = await openDatabase(path, onCreate: _onCreate, version: 1);
    return mydb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "notes" (
        "id" INTEGER PRIMARY KEY,
        "note" TEXT,
        "title" TEXT,
        "color" TEXT
      )
    ''');
    print("Database created and table initialized.");
  }
}
