import 'dart:io';
import 'package:note_keeper/model/notes_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

  // Create singleton class
class DatabaseRepository {
   static const _databaseName = 'note.db';
   static const _databaseVersion = 1;
   static const noteTable = 'note_table';
   static const columnId = 'id';
   static const columnTitle = 'title';
   static const columnDescription = 'description';
   static const columnDifficulty = 'difficulty';
   static const columnDate = 'date';


  // it hold the single instance of the class.
   static DatabaseRepository ? _databaseRepository; 

  // a private named constructor _createInstance() to prevent the class from being instantiated outside the class.
   DatabaseRepository._createInstance();

  // to create only one instances : calling this return instance _databaseRepository
  factory DatabaseRepository() {
    _databaseRepository ??= DatabaseRepository._createInstance();
    return _databaseRepository!;
  }

  // only have a single app-wide reference to the database
   static Database  ? _database;
  	Future<Database> get database async {
		_database ??= await initializeDatabase();
		return _database!;
	}

  // this opens the database (and creates it if it doesn't exist) i.e. initialize database
   	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database. using path_provider
		Directory directory = await getApplicationDocumentsDirectory(); 
		String path = '${directory.path}$_databaseName';
		// Open/create the database at a given path
		var notesDatabase = await openDatabase(path, version: _databaseVersion, onCreate: _createDb);
		return notesDatabase;
	}

   // SQL code to create the database Table
  	void _createDb(Database db, int newVersion) async {
		await db.execute(
      '''
       CREATE TABLE $noteTable(
       $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
       $columnTitle TEXT,
		   $columnDescription TEXT, 
       $columnDifficulty INTEGER, 
       $columnDate TEXT
       )
       ''');
	}

  // CURD OPERATION
  
  // Insert Operation: Inserts a row in the database.The return value is the id of the inserted row.
	Future<int> insertNote(NotesModel note) async {
		Database db = await database;
		var result = await db.insert(noteTable, note.toJson());
		return result;
	}
  // Update Operation: Update a Note object and save it to database
	Future<int> updateNote(NotesModel note) async {
		var db = await database;
		var result = await db.update(noteTable, note.toJson(), where: '$columnId = ?', whereArgs: [note.id]);
		return result;
	}

  // Delete Operation: Delete a Note object from database
	Future<int> deleteNote(int id) async {
		var db = await database;
    int result = await db.delete(noteTable,where: '$columnId = ?', whereArgs: [id]);
		return result;
	}

  // Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
		int? result = Sqflite.firstIntValue(x);
		return result ?? 0;
	}


  // Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getNoteMapList() async {
		Database db = await database; // calling database getter
		var result = await db.query(noteTable, orderBy: '$columnDifficulty ASC');
		return result;
	}

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<NotesModel>> getNoteList() async {
		var noteMapList = await getNoteMapList(); // Get 'Map List' from database
		int count = noteMapList.length;       
		List<NotesModel> noteList = [];
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			noteList.add(NotesModel.fromMapObject(noteMapList[i]));
		}
		return noteList;
	}
}

