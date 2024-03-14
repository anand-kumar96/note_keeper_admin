// get difficulty Color
import 'package:flutter/material.dart';
import 'package:note_keeper/model/notes_model.dart';

// show Snackbar
void showSnackBar(BuildContext context, String message) {
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Color getDifficultyColor(int difficulty){
  switch(difficulty) {
    case 1:
    return Colors.lightGreen;
    case 2:
    return Colors.lightBlue;
    case 3:
    return Colors.red;
    default :
    return Colors.lightGreen;
  }
}

IconData getDifficultyIcon(int difficulty) {
  switch(difficulty) {
    case 1:
    return Icons.check;
    case 2 :
    return Icons.arrow_forward_outlined;
    case 3 :
    return Icons.play_arrow;
    default :
    return Icons.check;
  }
}

// convert String difficulty in the form of integer
 void updateDifficultyAsInt(String value, NotesModel note){
  switch(value) {
    case'Easy':
     note.difficulty = 1;
     break;
    case'Medium':
     note.difficulty = 2;
     break;
    case'Hard':
     note.difficulty = 3;
     break;
  }
 }
 // convert integer difficulty in the form of String
  Difficulty getDifficultyAsString(int value, List options){
  Difficulty difficulty = Difficulty.Easy;
  switch(value) {
    case 1:
     difficulty = options[0];
     break;
    case 2:
    difficulty = options[1];
     break;
    case 3:
    difficulty = options[2];
     break;
  }
  return difficulty;
 }
