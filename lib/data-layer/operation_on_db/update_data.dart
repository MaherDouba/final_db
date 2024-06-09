import '../creat_database.dart';

class UpdateDatabase {
  Future<int> updateData(String note, String title, String color, int id) async {
    var db = await CreateDatabase().db;
    int response = await db!.update('notes', {'note': note, 'title': title, 'color': color},
        where: 'id = ?', whereArgs: [id]);
    print("Data updated in Sqflite");
    return response;
  }
}
