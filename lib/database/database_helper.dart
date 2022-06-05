import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/model/todo.dart';

const databaseName = "todo.db";
const table = "todo";
const columnId = 'id';
const columnTitle = 'title';
const columnTask = 'task';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (!(_database != null)) _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    print("DB Creating...");
    final databasesPath = join(await getDatabasesPath(), "todo.db");
    return await openDatabase(
      databasesPath,
      version: 1,
      onCreate: (Database db, int version) async {
        print('DB created!!');
        await db.execute(
            'CREATE TABLE IF NOT EXISTS Todo(id String PRIMARY KEY, title TEXT, task TEXT, completed INTEGER)');
      },
    );
  }

  Future<List<Todo>> getAll() async {
    Database? db = await instance.database;
    var res = await db!.rawQuery('SELECT * FROM Todo');
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> getAllCompleted() async {
    Database? db = await instance.database;
    var res = await db!.rawQuery('SELECT * FROM Todo where completed = 1');
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  Future<List<Todo>> getAllProcessing() async {
    Database? db = await instance.database;
    var res = await db!.rawQuery('SELECT * FROM Todo where completed = 0');
    return res.map((e) => Todo.fromMap(e)).toList();
  }

  Future<bool> addTodo(Todo todo) async {
    Database? db = await instance.database;
    var res = await db!.insert(table, todo.toMap());
    return true;
  }

  Future<bool> updateTodo(Todo todo) async {
    Database? db = await instance.database;
    var res = await db!
        .update(table, todo.toMap(), where: 'id =?', whereArgs: [todo.id]);
    return true;
  }

  Future<bool> deleteTodo(String? id) async {
    Database? db = await instance.database;
    await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
    return true;
  }

  Future<void> clearTable() async {
    Database? db = await instance.database;
    await db!.rawQuery("DELETE FROM $table");
    return;
  }
}
