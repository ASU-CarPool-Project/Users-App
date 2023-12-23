import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  Database? mydatabase;

  Future<Database?> checkdata() async {
    if (mydatabase == null) {
      mydatabase = await creating();
      return mydatabase;
    } else {
      return mydatabase;
    }
  }

  int dbVersion = 2;
  String dbName = 'asucarpool_driver_v2.db';

  creating() async {
    String databasepath = await getDatabasesPath();
    String mypath = join(databasepath, dbName);
    Database mydb =
        await openDatabase(mypath, version: dbVersion, onCreate: (db, version) {
      db.execute('''CREATE TABLE IF NOT EXISTS 'USERS'(
      'ID' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      'FIRST_NAME' TEXT NOT NULL,
      'LAST_NAME' TEXT NOT NULL,
      'EMAIL' TEXT NOT NULL,
      'PHONE' TEXT NOT NULL)''');
    });
    return mydb;
  }

  isexist() async {
    String databasepath = await getDatabasesPath();
    String mypath = join(databasepath, dbName);
    await databaseExists(mypath) ? print("it exists") : print("not exist");
  }

  reseting() async {
    String databasepath = await getDatabasesPath();
    String mypath = join(databasepath, dbName);
    await deleteDatabase(mypath);
  }

  reading(sql) async {
    Database? myDB = await checkdata();
    var myResponse = myDB!.rawQuery(sql);
    return myResponse;
  }

  write(sql) async {
    Database? myDB = await checkdata();
    var myResponse = myDB!.rawInsert(sql);
    return myResponse;
  }

  update(sql) async {
    Database? myDB = await checkdata();
    var myResponse = myDB!.rawUpdate(sql);
    return myResponse;
  }

  delete(sql) async {
    Database? myDB = await checkdata();
    var myResponse = myDB!.rawDelete(sql);
    return myResponse;
  }
}
