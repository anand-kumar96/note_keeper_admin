import 'package:flutter/material.dart';
import 'package:note_keeper/controller/notes_controller.dart';
import 'package:note_keeper/model/notes_model.dart';
import 'package:note_keeper/utils/helper.dart';

class AddNoteScreen extends StatefulWidget {
const AddNoteScreen({super.key, required this.appTitle,required this.note});
final String appTitle;
final NotesModel note;
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}
class _AddNoteScreenState extends State<AddNoteScreen> {
  NotesController notesController = NotesController();
  @override
  Widget build(BuildContext context){
    notesController.titleController.text = widget.note.title;
    notesController.descriptionController.text = widget.note.description;
    return Scaffold(
       appBar: AppBar(
        title: Text(widget.appTitle, style: const TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: notesController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const SizedBox(height: 20,),
                // option
               DropdownButtonFormField(
                items: options.map((option) => DropdownMenuItem(value: option, child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(option.name),
                ))).toList(), 
                onChanged:(value) {
                  setState(() {
                  // update Difficulty
                    updateDifficultyAsInt(value!.name, widget.note);
                  });
                },
                validator: (value) {
                  if(value==null || value.name.isEmpty){
                  return 'Please Select Difficulty';
                  }
                  return null;
                },
                value: getDifficultyAsString(widget.note.difficulty, options),
                ),
                 const SizedBox(height: 10,),
                // title
                TextFormField(
                controller: notesController.titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(14),
                  labelText: 'Title',
                ),
                onChanged: (value){
                  // update title
                  setState(() {
                    widget.note.title = value;
                  });
                },
                validator: (value) {
                  if(value==null || value.trim().isEmpty){
                  return 'Title cannot be empty! Please enter title';
                  }
                  return null;
                },
              ),
                const SizedBox(height: 25,),
                // description
                 TextFormField(
                  controller: notesController.descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(14),
                    labelText: 'Description',
                ),
                onChanged: (value){
                  // update description
                  setState(() {
                    widget.note.description = value;
                  });
                },
               validator: (value) {
                  if(value==null || value.trim().isEmpty){
                  return 'Desciption cannot be empty! Please enter Description';
                  }
                  return null;
                },
              ),
                /// Button 
               const SizedBox(height: 30,),
               Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                // Save
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                    setState(() {
                    // Save Notes
                     if (notesController.formKey.currentState!.validate()) {
                      notesController.saveNotes(context, widget.note);
                     }
                    });
                    },
                    style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      child: const Text('Save', style: TextStyle(color: Colors.white),) ),
                ),
                const SizedBox(width: 10),
                // Delete
                Expanded(
                  child: ElevatedButton(
                    onPressed: (){
                      setState(() {
                        // delete Notes
                        notesController.deleteNotes(context, widget.note);
                      });
                    },
                    style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
                      backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary)), 
                      child: const Text('Delete',style: TextStyle(color: Colors.white),) ),
                ),
                ],
               ),
              ],
            ),
          ),
        ),
    );
  }
}