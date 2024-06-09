import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  Future<List<Map<String, dynamic>>> readData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String? dataString = sharedPrefs.getString('dataList');
    List<Map<String, dynamic>> dataList = [];
    if (dataString != null) {
      List<dynamic> decodedList = json.decode(dataString);
      dataList = List<Map<String, dynamic>>.from(decodedList);
    }
    print("Data read from SharedPreferences");
    return dataList;
  }

  Future<void> insertData(String note, String title, String color) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> dataList = await readData();
  int id = DateTime.now().millisecondsSinceEpoch; // توليد معرف فريد يعتمد على الوقت
  Map<String, dynamic> newData = {'id': id, 'note': note, 'title': title, 'color': color};
  dataList.add(newData);
  String dataStr = json.encode(dataList);
  await sharedPrefs.setString('dataList', dataStr);
  print("Data inserted into SharedPreferences");
}


Future<int> deleteData(int id) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> dataList = await readData();
  int initialLength = dataList.length;
  dataList.removeWhere((element) => element['id'] == id);
  String dataStr = json.encode(dataList);
  await sharedPrefs.setString('dataList', dataStr);
  print("Data deleted from SharedPreferences");
  return dataList.length < initialLength ? 1 : 0; // Return 1 to indicate success, 0 to indicate failure
}


  Future<int> updateData( String note, String title, String color ,int id) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  List<Map<String, dynamic>> dataList = await readData();
  int index = dataList.indexWhere((element) => element['id'] == id);
  if (index != -1) {
    dataList[index] = {'id': id, 'note': note, 'title': title, 'color': color};
    String dataStr = json.encode(dataList);
    await sharedPrefs.setString('dataList', dataStr);
    print("Data updated in SharedPreferences");
    return 1; 
  }
  return 0; 
}

}
