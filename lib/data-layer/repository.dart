import 'operation_on_db/delete_data.dart';
import 'operation_on_db/insert_data.dart';
import 'operation_on_db/read_data.dart';
import 'operation_on_db/update_data.dart';
import 'shared_prefrence_helper.dart';

class NotesRepository {
  final InsertDatabase _insertDb = InsertDatabase();
  final ReadDatabase _readDb = ReadDatabase();
  final UpdateDatabase _updateDb = UpdateDatabase();
  final DeleteDatabase _deleteDb = DeleteDatabase();
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  Future<List<Map<String, dynamic>>> readData(bool fromDatabase) async {
    if (fromDatabase) {
      return await _readDb.readData();
    } else {
      return await _prefsHelper.readData();
    }
  }

  Future<void> insertData(String note, String title, String color, bool toDatabase) async {
    if (toDatabase) {
      await _insertDb.insertData(note, title, color);
    } else {
      await _prefsHelper.insertData(note, title, color);
    }
  }

  Future<int> updateData(String note, String title, String color, int id, bool toDatabase) async {
    if (toDatabase) {
      return await _updateDb.updateData(note, title, color, id);
    } else {
      return await _prefsHelper.updateData(note, title, color, id);
    }
  }

  Future<int> deleteData(int id, bool fromDatabase) async {
    if (fromDatabase) {
      return await _deleteDb.deleteData(id);
    } else {
      return await _prefsHelper.deleteData(id);
    }
  }
}
