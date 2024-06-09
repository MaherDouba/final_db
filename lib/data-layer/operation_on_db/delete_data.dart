import 'package:sqflite/sqflite.dart';
import '../creat_database.dart';

class DeleteDatabase {
  final CreateDatabase _dbHelper = CreateDatabase();

  Future<int> deleteData(int id) async {
    Database? mydb = await _dbHelper.db;
    int response = await mydb!.delete('notes', where: 'id = ?', whereArgs: [id]);
    print("Data deleted from SQLite");
    return response;
  }
}
