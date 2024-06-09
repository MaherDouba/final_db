import '../creat_database.dart';

class InsertDatabase {
  Future<void> insertData(String note, String title, String color) async {
    var db = await CreateDatabase().db;
    await db!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO notes(note, title, color) VALUES("$note", "$title", "$color")');
    });
    print("Data inserted into Sqflite");
  }
}
