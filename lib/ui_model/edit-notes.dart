import 'package:flutter/material.dart';
import '../data-layer/repository.dart';

class EditNotes extends StatefulWidget {
  final String note;
  final String title;
  final String color;
  final int id;

  EditNotes({
    required this.note,
    required this.title,
    required this.color,
    required this.id,
  });

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  late TextEditingController noteController;
  late TextEditingController titleController;
  late TextEditingController colorController;
  final NotesRepository notesRepository = NotesRepository();
  bool chooseDatabase = false;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.note);
    titleController = TextEditingController(text: widget.title);
    colorController = TextEditingController(text: widget.color);
  }

  @override
  Widget build(BuildContext context) {
     if (ModalRoute.of(context)!.settings.arguments != null) {
      chooseDatabase = ModalRoute.of(context)!.settings.arguments as bool;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: noteController,
              decoration: const InputDecoration(hintText: 'Note'),
            ),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(hintText: 'Color'),
            ),
            ElevatedButton(
              onPressed: () async {
                await notesRepository.updateData(
                  noteController.text,
                  titleController.text,
                  colorController.text,
                  widget.id,
                  chooseDatabase,
                );
                Navigator.of(context).pop();
              },
              child: Text('Update Note'),
            ),
          ],
        ),
      ),
    );
  }
}
