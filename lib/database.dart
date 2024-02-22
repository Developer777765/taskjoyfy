import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  initializeDatabse() async {
    var path = await getApplicationDocumentsDirectory();
    var databasePath = join(path.path, 'mydatabase.db');
    Database database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE joyfy(id integer primary key autoincrement, name text, password text, mail text, mobnumber text, dateOfBirth text)',
        );
      },
    );

    return database;
  }

  insertingIntoTableValues(String name, String password, String mail,
      String mobNumber, String dateOfBirth) async {
    Database db = await initializeDatabse();
    await db.insert('joyfy', {
      'name': name,
      'password': password,
      'mail': mail,
      'mobnumber': mobNumber,
      'dateOfBirth': dateOfBirth
    });
  }

  Future<List<Map<String, Object?>>> queryFromTable() async {
    var db = await initializeDatabse();
    int? count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM joyfy'));
    if (count != null) {
      if (count > 0) {
        List<Map<String, dynamic>> retrieved = await db.query('joyfy');
        if (retrieved.isNotEmpty) {
          return retrieved;
        }
      }
    }

    return [
      {'empty': 'retrievedEmpty'}
    ];
  }

  updateInfo(String updatedPassWord,int id) async {
    var db = await initializeDatabse();
    await db.update(
    'joyfy',
    // Set the new values.
    {'password': updatedPassWord},
    // Specify the record to update based on the ID.
    where: 'id = ?',
    // Provide the ID as the whereArg to prevent SQL injection.
    whereArgs: [id],
  );
  }
}
