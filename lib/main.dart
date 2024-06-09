import 'package:flutter/material.dart';
import 'package:finalexample/ui_model/home_page.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'ui_model/add-notes.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
    
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqflite',
      home: HomePage(),
      routes: {
        "addnotes": (context) => AddNotes(),
      },
    );
  }
}
