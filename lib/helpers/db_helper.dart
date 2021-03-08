import 'package:flutter_sqflite_note/models/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = 'notes';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'note.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title STRING NOT NULL, description TEXT NOT NULL, dateTimeEdited TEXT NOT NULL,dateTimeCreated TEXT NOT NULL)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(NoteModel noteModel) async =>
      await _db.insert(_tableName, noteModel.toJson());

  static Future<int> delete(NoteModel noteModel) async =>
      await _db.delete(_tableName, where: 'id = ?', whereArgs: [noteModel.id]);

  static Future<int> deleteAllNotes() async => await _db.delete(_tableName);

  static Future<List<Map<String, dynamic>>> query() async =>
      _db.query(_tableName);

  static Future<int> update(NoteModel noteModel) async => _db.update(
        _tableName,
        noteModel.toJson(),
        where: "id = ?",
        whereArgs: [noteModel.id],
      );
}
