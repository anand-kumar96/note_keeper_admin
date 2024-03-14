// ignore: constant_identifier_names
enum Difficulty {Easy, Medium, Hard }

final options = [Difficulty.Easy, Difficulty.Medium, Difficulty.Hard];
class NotesModel {
  NotesModel( {
    required this.title, 
    required this.date,
    required this.difficulty,
    required this.description,
    this.id = 0
    });

  int id;
  String date;
  String title;
  String description;
  int difficulty;

  // convert note object to json
  Map<String,dynamic> toJson () {
    return {
    if(id!=0) 'id':id,
    'title':title,
    'description' : description,
    'date':date,
    'difficulty': difficulty
    };
  }

  // convert json to map using namedConstructor 
 NotesModel.fromMapObject(Map<String,dynamic> notes) : 
 id = notes['id'],
 title = notes['title'],
 description = notes['description'],
 date = notes['date'],
 difficulty = notes['difficulty'];
}