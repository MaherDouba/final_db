import 'package:flutter/material.dart';
import '../data-layer/repository.dart';
import 'edit-notes.dart';



class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  bool chooseDatabase = true;
  NotesRepository notesRepository = NotesRepository();
  List<Map<String, dynamic>> notes = [];

  Future<void> readData() async {
    List<Map<String, dynamic>> response = await notesRepository.readData(chooseDatabase);
    setState(() {
      notes = response;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes', arguments: chooseDatabase).then((_) => readData());
        },
        child: Icon(Icons.add),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView(
                children: <Widget>[
                  const Center(
                      child: Text(
                    "Choose how to save data",
                    style: TextStyle(fontSize: 25),
                  )),
                  RadioListTile(
                    activeColor: Colors.green,
                    title: const Text("Sqflite"),
                    value: true,
                    groupValue: chooseDatabase,
                    onChanged: (val) {
                      setState(() {
                        chooseDatabase = val!;
                        readData(); 
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: Colors.green,
                    title: const Text("Shared Preferences"),
                    value: false,
                    groupValue: chooseDatabase,
                    onChanged: (val) {
                      setState(() {
                        chooseDatabase = val!;
                        readData(); 
                      });
                    },
                  ),
                  Container(
                    height: 30,
                    color: Colors.blueGrey,
                    child: Center(
                        child: Text(
                      'Your data will now be stored using ${chooseDatabase ? "Sqflite" : "Shared Preferences"}',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                  ListView.builder(
                      itemCount: notes.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                          child: ListTile(
                              title: Text('${notes[i]['title']}'),
                              subtitle: Text('${notes[i]['note']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        if (notes[i]['id'] != null) {
                                          int response = await notesRepository.deleteData(
                                              notes[i]['id'], chooseDatabase);
                                          if (response > 0) {
                                            await readData(); 
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Cannot delete note with null id')),
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                   IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => EditNotes(
                                              color: notes[i]['color'],
                                              title: notes[i]['title'],
                                              note: notes[i]['note'],
                                              id: notes[i]['id'],
                                            ),
                                            settings: RouteSettings(arguments: chooseDatabase),
                                          ),
                                        ).then((_) => readData());
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      )),
                                ],
                              )),
                        );
                      }),
                ],
              ),
            ),
    );
  }
}
