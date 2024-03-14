import 'package:flutter/material.dart';
import 'package:note_keeper/model/notes_model.dart';

class NoteDetailScreen extends StatelessWidget {
const NoteDetailScreen({super.key,required this.note});
final NotesModel note;
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
        title: Text(note.title, style: const TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Card(
          color: const Color.fromARGB(255, 188, 219, 233),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child:  Column(
              mainAxisSize:MainAxisSize.min ,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text('Title : ${note.title}',style: const TextStyle( fontSize: 20)),
                const SizedBox(height: 4),
                //createdAt
                Text('Created At : ${note.date}',style: const TextStyle( fontSize: 16)),
                const SizedBox(height: 4),
                // description
                Text('Description : ${note.description}',style: const TextStyle( fontSize: 18))
              ],
            ),
          ),
          ),
          ),
    );
  }
}