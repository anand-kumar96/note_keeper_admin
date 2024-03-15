import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:note_keeper/config.dart';
import 'package:note_keeper/model/notes_model.dart';
import 'package:note_keeper/repository/database_repository.dart';

Future<void> postNotesToMongoDbFromSqlite() async {
  try {
     DatabaseRepository databaseRepository = DatabaseRepository();
    var notes = await databaseRepository.getNoteMapList();
    // API endpoint URL
    const String apiUrl = 'https://note-keeper-api-6yg7.onrender.com/createManyNotes';
    // Send POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "notes":notes
      })
    );
    // Check response status
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Notes posted successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to post Notes. Error ${response.statusCode}: ${response.body}');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Failed to post Notes: $error');
    }
  }
}

/// Function to Create a note
Future<void> addNotesToMongoDb(NotesModel note) async {
  try {
    const String apiUrl = createNotesUrl;
    // Send POST request
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(note.toJson())
    );
    // Check response status
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Notes posted successfully');
      }
    } else {
      if (kDebugMode) {
        print('Failed to post Notes. Error ${response.statusCode}: ${response.body}');
      }
    }
  } catch (error) {
    if (kDebugMode) {
      print('Failed to post Notes: $error');
    }
  }
}

// Function to update a note by ID
Future<void> updateNoteToMongoDbById(NotesModel note) async {
  try {
    // Make PUT request to the API endpoint
     const String apiUrl = updateNotesUrl;
    var response = await http.patch(
      Uri.parse('$apiUrl/${note.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(note.toJson()),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Note updated successfully');
      }
    } else {
      // Handle error response
      if (kDebugMode) {
        print('Failed to update note: ${response.body}');
      }
      throw Exception('Failed to update note');
    }
  } catch (error) {
    // Handle network errors
    if (kDebugMode) {
      print('Error updating note: $error');
    }
    rethrow;
  }
}

/// Function to delete a note by ID
Future<void> deleteNoteToMongoDbById(int noteId) async {
  try {
    // Make PUT request to the API endpoint
     const String apiUrl = deleteNotesUrl;
    var response = await http.delete(
      Uri.parse('$apiUrl/$noteId'),
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Note deleted successfully');
      }
    } else {
      // Handle error response
      if (kDebugMode) {
        print('Failed to delete note: $noteId');
      }
      throw Exception('Failed to delete note');
    }
  } catch (error) {
    // Handle network errors
    if (kDebugMode) {
      print('Error deleting note: $error');
    }
    rethrow;
  }
}