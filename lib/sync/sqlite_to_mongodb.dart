import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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
