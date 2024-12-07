

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static  DBHelper getInstance () => DBHelper._();
  Database? mDB;
  Future<Database> getDB() async{
   mDB = mDB  ?? await openDB();
   return mDB!;
  }

  Future<Database> openDB() async  {
    var appDir  = await getApplicationDocumentsDirectory();
    String dbpath = join(appDir.path, "mainDB.db");

    return await openDatabase(dbpath,version: 1, onCreate: (db,version){
      ///table create
      db.execute("create table table1( note_id integer primary key autoincrement , note_title text, note_desc text )");
    });
}

///queries
   Future<bool> addNote ({required String title ,required String desc})async{
    var db = await getDB();
    int rowsEffected = await db.insert("table1",{
      "note_title":title,
      "note_desc" : desc,
    });
    return rowsEffected>0;
}
   Future <List <Map <String,dynamic>>> fetchAllNotes () async{
var db = await getDB();
     List<Map<String,dynamic>> mData = await db.query("table1");
     return mData;
}

}