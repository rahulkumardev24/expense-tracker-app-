import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  // Private Constructor
  AppDataBase._privateConstructor();

  static final AppDataBase instance = AppDataBase._privateConstructor();
  Database? myDB;

  /// login pref key
  static final String LOGIN_UID = "uid";

  /// Table
  static final String EXPENSE_TABLE = "notes";
  static final String USER_TABLE = "users";

  /// expense columns
  /// add uid here also


  /// user columns
  static final String COLUMN_USER_ID = "uId";
  static final String COLUMN_USER_NAME = "uName";
  static final String COLUMN_USER_EMAIL = "uEmail";
  static final String COLUMN_USER_NUMBER = "uNumber";
  static final String COLUMN_USER_PASSWORD = "uPassword";

  /// Open database
  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "noteDb.db");
    return await openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      /// Create all table here

          /// Create table for notes
      db.execute("create table "
          "$EXPENSE_TABLE("
          "$COLUMN_USER_ID integer");


      /// Create table for user
          db.execute("create table"
              "$USER_TABLE("
              "$COLUMN_USER_ID primary key autoincrement"
              "$COLUMN_USER_NAME TEXT "
              "$COLUMN_USER_EMAIL TEXT UNIQUE"
              "$COLUMN_USER_NUMBER TEXT"
              "$COLUMN_USER_PASSWORD TEXT");

    });
  }

  // here we get database if database is not created then create else return database
  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    } else {
      myDB = await initDB();
      return myDB!;
    }
  }




}
