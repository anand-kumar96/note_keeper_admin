import 'package:flutter/material.dart';
import 'package:note_keeper/model/notes_model.dart';
import 'package:note_keeper/repository/database_repository.dart';
import 'package:note_keeper/utils/helper.dart';
import 'package:intl/intl.dart';
class NotesController {
    DatabaseRepository databaseRepository = DatabaseRepository();
    final formKey = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    // Get all Notes
    Future<List<NotesModel>> getAllNoteList() async{
      return await databaseRepository.getNoteList();
    }

    // Delete Existing notes from notelist
    void deleteNote(BuildContext context, NotesModel note) async{
    int result = await databaseRepository.deleteNote(note.id);
    if(result!=0) {
      if(!context.mounted) return;
      showSnackBar(context, 'Note Deleted Successfully');
    }
    }
    // Save and update Notes
    void saveNotes(BuildContext context, NotesModel note) async{
    Navigator.of(context).pop(true);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if(note.id!=0){    // if id is present then update
     result = await databaseRepository.updateNote(note);
    }else {  // id is !=0 then Insert
      result = await databaseRepository.insertNote(note);
    }
    if(result!=0){
      if(!context.mounted) return;
      showSnackBar(context, 'Note Saved Successfully');
    }else{
      if(!context.mounted) return;
      showSnackBar(context, 'Problem While Saving Notes');
    }
    }

  /// Deletes Notes : from detail page
  void deleteNotes (BuildContext context, NotesModel note) async {
  Navigator.of(context).pop(true);
   if(note.id==0) { // User trying to delete new notes
   showSnackBar(context, 'No Note was Deleted');
   return;
   } 
   // else  User trying to delete existing notes
   int result = await databaseRepository.deleteNote(note.id);
   if(result!=0) { //success
     if (!context.mounted) return;
     showSnackBar(context, 'Note Deleted Successfully');
   } else {
    if (!context.mounted) return;
    showSnackBar(context, 'Error Occured While Deleting Note');
   }
  }
}