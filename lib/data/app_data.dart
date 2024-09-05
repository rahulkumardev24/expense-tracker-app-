import 'package:expense_tracker_app/model/expense_model.dart';
import 'package:expense_tracker_app/model/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  // Private Constructor
  AppDataBase._privateConstructor();

  static final AppDataBase instance = AppDataBase._privateConstructor();
  Database? myDB;

  /// login pref key
  static final String LOGIN_UID = "uid";

  /// expanse
  static final String TABLE_EXPENSE = "expanseTable";
  static final String TABLE_USER = "usersTable";

  /// expense columns
  /// add uid here also
  static final String COLUMN_EXPENSE_ID = "expenseID";
  static final String COLUMN_EXPENSE_TITLE = "expanseTitle";
  static final String COLUMN_EXPENSE_DESCRIPTION = "expanseDescription";
  static final String COLUMN_EXPENSE_AMOUNT = "expanseAmount";
  static final String COLUMN_EXPENSE_BALENCE = "expanseBalence";
  static final String COLUMN_EXPENSE_PAYMENT_TYPE = "expansePaymentType";
  static final String COLUMN_EXPENSE_CATOGRY = "expanseCatogry";
  static final String COLUMN_EXPENSE_DATE = "expanseDate";

  /// user columns
  static final String COLUMN_USER_ID = "uId";
  static final String COLUMN_USER_NAME = "uName";
  static final String COLUMN_USER_EMAIL = "uEmail";
  static final String COLUMN_USER_NUMBER = "uNumber";
  static final String COLUMN_USER_PASSWORD = "uPassword";

  /// Open database
  Future<Database> initDB() async {
    var docDirectory = await getApplicationDocumentsDirectory();
    var dbPath = join(docDirectory.path, "expenseDB.db");
    return await openDatabase(dbPath, version: 1,
    onCreate: (db, version) async {
      // Create table for expenses
      await db.execute("CREATE TABLE $TABLE_EXPENSE ("
          "$COLUMN_EXPENSE_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$COLUMN_USER_ID INTEGER, "
          "$COLUMN_EXPENSE_TITLE TEXT, "
          "$COLUMN_EXPENSE_DESCRIPTION TEXT, "
          "$COLUMN_EXPENSE_AMOUNT REAL, "
          "$COLUMN_EXPENSE_BALENCE REAL, "
          "$COLUMN_EXPENSE_CATOGRY INTEGER, "
          "$COLUMN_EXPENSE_PAYMENT_TYPE INTEGER, "
          "$COLUMN_EXPENSE_DATE TEXT)");

      // Create table for users
      await db.execute("CREATE TABLE $TABLE_USER ("
          "$COLUMN_USER_ID INTEGER PRIMARY KEY AUTOINCREMENT, "
          "$COLUMN_USER_NAME TEXT, "
          "$COLUMN_USER_EMAIL TEXT UNIQUE, "
          "$COLUMN_USER_NUMBER TEXT, "
          "$COLUMN_USER_PASSWORD TEXT)");
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

  /// queries

  /// register new user
  Future<bool> registerUser(UserModel newUser) async {
    var db = await getDB();
    bool haveAccount = await isUserAlreadyRegistered(newUser.user_email);
    bool accountCreated = false;
    if (!haveAccount) {
      var rowEffected = await db.insert(TABLE_USER, newUser.toMap());
      accountCreated = rowEffected > 0;
    }
    return accountCreated;
  }

  /// check user is registered or not
  Future<bool> isUserAlreadyRegistered(String email) async {
    var db = await getDB();
    var data = await db.query(TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ? ", whereArgs: [email]);
    return data.isNotEmpty;
  }

  /// user login
  Future<bool> authenticateUser(String email, String password) async {
    var db = await getDB();
    var mData = await db.query(TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ? AND $COLUMN_USER_EMAIL = ? ",
        whereArgs: [email, password]);
    if (mData.isNotEmpty) {
      setUID(UserModel.fromMap(mData[0]).user_id);
    }
    return mData.isNotEmpty;
  }

  /// get UUID
  Future<int> getUID() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt("UID")!;
  }

  /// set UUID
  void setUID(int uid) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("UID", uid);
  }


  /// expense

/// Add Expense
 Future<bool> addExpense({required ExpenseModel newExpense}) async {
    var db = await getDB() ;
   int rowEffected = await db.insert(TABLE_EXPENSE, newExpense.toMap()) ;
   return rowEffected > 0 ;
 }

 /// get All Expense
 Future<List<ExpenseModel>> getAllExpense() async{
    var db = await getDB();
    List<Map<String , dynamic>> mData = await db.query(TABLE_EXPENSE) ;

    List<ExpenseModel> mExpense = [] ;
    for(Map<String , dynamic> eachExp in mData) {
      mExpense.add(ExpenseModel.fromMap(eachExp));
    }
    return mExpense ;

 }

}
