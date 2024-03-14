import 'package:flutter/material.dart';
import 'package:note_keeper/controller/notes_controller.dart';
import 'package:note_keeper/model/notes_model.dart';
import 'package:note_keeper/screen/add_note.dart';
import 'package:note_keeper/utils/helper.dart';

class CardDetails extends StatelessWidget {
  const CardDetails({
  super.key,
  required this.note,
  required this.updateList
  });
final NotesModel note;
final VoidCallback updateList;
  @override

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.w500),),
        subtitle: Text(note.date) ,
        leading:ClipRect(
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:getDifficultyColor(note.difficulty),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(getDifficultyIcon(note.difficulty), color: Colors.white,),
          )
        ),
        trailing: Wrap(
          spacing: 2,
          children: [
          IconButton(icon: const Icon(Icons.edit), 
          onPressed: () async {
            dynamic result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen(appTitle: 'Edit Notes',note: note)));
            if(result == true){
              updateList();
              }
          }
        ),
         IconButton(icon: const Icon(Icons.delete), 
          onPressed: () {
          NotesController().deleteNote(context, note);
          updateList();
        }
        )
          ],
        ),
      ),
    );
  }
}