import 'package:flutter/material.dart';
import 'package:note_keeper/controller/notes_controller.dart';
import 'package:note_keeper/screen/add_note.dart';
import 'package:note_keeper/screen/note_detail.dart';
import 'package:note_keeper/widgets/cards_detail.dart';
import 'package:note_keeper/model/notes_model.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}
class _NoteScreenState extends State<NoteScreen> {
  NotesController notesController = NotesController();
  List<NotesModel> notes = [];
  int count = 0;
  @override
  void initState() {
    updateNoteList();
    super.initState();
  }
  void updateNoteList() async {
  final notesList =  await notesController.getAllNoteList();
   setState(() {
    notes = notesList;
    count = notesList.length;
  });
  }
  @override
  Widget build(BuildContext context) {
   if(notes == []){
   updateNoteList();
   }
    Widget content = const Center(child: Text('Notes is Empty',style: TextStyle(color: Colors.white),),);
    if(count!=0) {
      content = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => NoteDetailScreen(note: notes[index]),)),
                child: CardDetails(note: notes[index],updateList: updateNoteList,));
            },)
          );
    }
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      appBar: AppBar(
        title: const Text('Note Keeper Admin', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic result =await Navigator.push(context, MaterialPageRoute(builder: (context) => AddNoteScreen(appTitle: 'Add Notes',note: NotesModel(date: '',description: '',title: '',difficulty:1))));
          if(result==true){
            updateNoteList();
          }
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white,),
        ) ,
        //body
        body: content
    );
  }
}

