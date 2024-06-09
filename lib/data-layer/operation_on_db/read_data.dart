
import '../creat_database.dart';

class ReadDatabase {
  Future<List<Map<String, dynamic>>> readData() async {
    var db = await CreateDatabase().db;
    List<Map<String, dynamic>> response = await db!.query('notes');
    print("Data read from Sqflite");
    return response;
  }
}
