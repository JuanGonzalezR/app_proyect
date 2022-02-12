import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:app/src/utils/consts_utils.dart' as util;

class DBHelper {

  static Database? _db;
  static const _version = 1;

  Future<Database?> get database async{
    if (_db != null) return _db;
    _db = await initDB();
    return _db;
  }

  Future<Database> initDB() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path= join(documentDirectory.path,'Database.db');
    Database dbCon= await openDatabase(path,version: _version,onCreate:  _onCreate);
    return dbCon;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
      util.constante.createTables
      );
  }
}