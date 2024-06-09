import 'package:flutter/material.dart';
import '../data-layer/repository.dart';
import 'home_page.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  NotesRepository notesRepository = NotesRepository();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bool chooseDatabase = ModalRoute.of(context)?.settings.arguments as bool? ?? true;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: InputDecoration(hintText: "Note"),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(hintText: "Title"),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: InputDecoration(hintText: "Color"),
                    ),
                    Container(height: 10),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        if (formstate.currentState!.validate()) {
                          await notesRepository.insertData(
                            note.text,
                            title.text,
                            color.text,
                            chooseDatabase,
                          );

                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false,
                          );
                        }
                      },
                      child: Text('Add Note'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

