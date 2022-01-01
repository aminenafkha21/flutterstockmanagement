import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stockmanagementflutter/model/model_component.dart';
import 'package:stockmanagementflutter/model/model_family.dart';
import 'package:stockmanagementflutter/model/model_loan.dart';
import 'package:stockmanagementflutter/model/model_membre.dart';
import 'package:stockmanagementflutter/model/model_returnedloan.dart';
import 'package:stockmanagementflutter/model/model_user.dart';

class DatabaseHelper {
  static DatabaseHelper dbHelper;
  static Database _database;
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (dbHelper == null) {
      dbHelper = DatabaseHelper._createInstance();
    }
      return dbHelper ;
  }

  final String tableName = 'tableFamilyC';
  final String columnId = 'categoryid';
  final String columnFamilyName = 'familyName';


  final String tableName2 = 'User';
  final String column2Id = 'id';
  final String column2Username = 'username';
  final String column2Password = 'password';
  final String column2Email = 'email';


  final String tableName3 = 'Components';
  final String column3Id = 'id';
  final String column3Name = 'namecom';
  final String column3Qte = 'qtestock';
  final String column3Date = 'dateaq';
  final String column3Cat = 'category';


  final String tableName4 = 'Membres';
  final String column4Id = 'id';
  final String column4Name = 'name';
  final String column4Surname = 'surname';
  final String column4phone1 = 'phoneone';
  final String column4phone2 = 'phonetwo';


  final String tableName5 = 'Loans';
  final String column5Id = 'id';
  final String column5Qte = 'qtestockloans';
  final String column5Comp = 'component';
  final String column5Mem = 'membre';

  final String tableName6 = 'ReturnLoan';
  final String column6Id = 'id';
  final String column6Date = 'dateretour';
  final String column6Etat = 'etat';
  final String column6Loan = 'loan';







  Future<Database> get _db async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    Directory databasePath = await getApplicationDocumentsDirectory();
    String path = join(databasePath.path, 'stocknafhac.db');
    print('db location : '+path);

    var database = await openDatabase(path, version: 1, onCreate: _onCreate) ;
    return await database;
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE IF NOT EXISTS $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnFamilyName TEXT)";

    var sql2 = "CREATE TABLE  IF NOT EXISTS $tableName2($column2Id INTEGER PRIMARY KEY, "
        "$column2Username TEXT , "
        "$column2Password TEXT , "
        "$column2Email TEXT)";

    var sql3 = "CREATE TABLE  IF NOT EXISTS $tableName3 ($column3Id INTEGER PRIMARY KEY, "
        "$column3Name TEXT , "
        "$column3Qte INTEGER , "
        "$column3Date TEXT,"
        "category INTEGER ,"
        "FOREIGN KEY (category) REFERENCES $tableName (categoryid) )";

    var sql4 = "CREATE TABLE  IF NOT EXISTS $tableName4($column4Id INTEGER PRIMARY KEY, "
        "$column4Name TEXT , "
        "$column4Surname TEXT , "
        "$column4phone1 TEXT , "
        "$column4phone2 TEXT)";

    var sql5 = "CREATE TABLE  IF NOT EXISTS $tableName5 ($column5Id INTEGER PRIMARY KEY, "
        "$column5Qte  INTEGER , "
        "$column5Mem  INTEGER ,"
        "$column5Comp INTEGER ,"
        "FOREIGN KEY (membre) REFERENCES $tableName4 (id) ,"
        "FOREIGN KEY (component) REFERENCES $tableName3 (id) )";

    var sql6 = "CREATE TABLE  IF NOT EXISTS $tableName6 ($column6Id INTEGER PRIMARY KEY, "
        "$column6Date  TEXT , "
        "$column6Etat TEXT ,"
        "$column6Loan INTEGER ,"
        "FOREIGN KEY (loan) REFERENCES $tableName5 (id) )";


    await db.execute(sql);
    await db.execute(sql2);
    await db.execute(sql3);
    await db.execute(sql4);
    await db.execute(sql5);
    await db.execute(sql6);






  }



  Future<int> saveUser(Modeluser user) async {
    var dbClient = await _db;
    int result = await dbClient.insert(tableName2, user.toMap());
    return result;
  }

  Future<Modeluser> checkLogin(String email, String password) async {
    var dbClient = await _db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $tableName2 WHERE email = '$email' AND password = '$password'");

    if (result.length > 0) {
      return Modeluser.fromMap(result.first);
    }
    return null;
  }

  // Future<List> getAllUser() async {

  // }

  Future<int> saveFamily(ModelFamily family) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName, family.toMap());
  }




  Future<List> getAllFamily() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName, columns: [
      columnId,
      columnFamilyName,

    ]);

    return result.toList();
  }


  getCat(int item)async{
    var dbClient = await _db ;
    List<Map> result = await dbClient.query(tableName,
        columns: [
          columnId, columnFamilyName
        ],
        where: '$columnId = ?', whereArgs: [item]);


    if(result.length > 0 ) return new ModelFamily.fromMap(result.first).familyName;

    return null ;
  }

  getMembre(int item)async{
    var dbClient = await _db ;
    List<Map> result = await dbClient.query(tableName4,
        columns: [
          column4Id , column4Name,column4Surname,column4phone1,column4phone2
        ],
        where: '$column4Id = ?', whereArgs: [item]);


    if(result.length > 0 ) return new ModelMembre.fromMap(result.first);

    return null ;
  }

  getComponent(int item)async{
    var dbClient = await _db ;
    List<Map> result = await dbClient.query(tableName3,
        columns: [
          column4Id , column3Name
        ],
        where: '$column3Id = ?', whereArgs: [item]);


    if(result.length > 0 ) return new ModelComponent.fromMap(result.first);

    return null ;
  }

  getLoan(int item)async{
    var dbClient = await _db ;
    List<Map> result = await dbClient.query(tableName5,
        columns: [
          column5Id , column5Qte
        ],
        where: '$column5Id = ?', whereArgs: [item]);


    if(result.length > 0 ) return new ModelLoan.fromMap(result.first);

    return null ;
  }

  // Read data from Table
  readData() async {
    var connection = await _db;
    return await connection.query(tableName);
  }
  Future<int> updateFamily(ModelFamily family) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName,
      family.toMap(),
      where: '$columnId = ?',
      whereArgs: [family.categoryid],
    );
  }

  Future<int> deleteFamily(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );


  }

  Future<List> getAllComponents() async {
    var dbClient = await _db;
    var result = await dbClient.rawQuery('SELECT Components.*, tableFamilyC.familyName FROM Components INNER JOIN tableFamilyC ON tableFamilyC.categoryid = Components.category');

    return result.toList();
  }


  Future<int> saveComponent(ModelComponent component) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName3, component.toMap());
  }

  createComponenet(ModelComponent component) async {
    final db = await _db;
    db.insert(tableName3, component.toMap());
  }

  Future<int> updateComponent(ModelComponent component) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName3,
      component.toMap(),
      where: '$column3Id = ?',
      whereArgs: [component.id],
    );
  }

  Future<int> deleteComponent(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName3,
      where: '$column3Id = ?',
      whereArgs: [id],
    );


  }


  Future<List> getAllMembres() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName4, columns: [
      column4Id,
      column4Name,
      column4Surname,
      column4phone1,
      column4phone2,

    ]);

    return result.toList();
  }


  Future<int> saveMembre(ModelMembre membre) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName4, membre.toMap());
  }


  Future<int> updateMembre(ModelMembre membre) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName4,
      membre.toMap(),
      where: '$column4Id = ?',
      whereArgs: [membre.id],
    );
  }

  Future<int> deleteMembre(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName4,
      where: '$column4Id = ?',
      whereArgs: [id],
    );


  }




  Future<List> getAllLoans() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName5, columns: [
      column5Id,
      column5Qte ,
      column5Mem,
      column5Comp,

    ]);

    return result.toList();
  }

  Future<int> checkloan(ModelLoan loan) async {
    var dbClient = await _db;
    var vari = await dbClient.rawQuery(
        'SELECT qtestock FROM $tableName3 WHERE qtestock < ? AND  id = ?',
        [loan.qtestockloans, loan.component]);
    if (vari.length > 0) {
      return 0;
    }
      return 1;

  }
  Future<bool> checkbutton(int loan) async {
    var dbClient = await _db;
    var vari = await dbClient.rawQuery("SELECT $tableName5.* , $tableName6.* FROM $tableName5 , $tableName6 WHERE $tableName5.id == $tableName6.loan AND  $tableName5.id == $loan");

    if (vari.length > 0) {
      return true;
    }else {
      return false;
    }

  }
  Future<int> saveLoan(ModelLoan loan) async {
    var dbClient = await _db;
    await dbClient.rawUpdate('UPDATE $tableName3 SET qtestock = qtestock - ? WHERE id = ?', [loan.qtestockloans, loan.component]);
    return await dbClient.insert(tableName5, loan.toMap());

  }


  Future<int> updateLoan(ModelLoan loan) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName5,
      loan.toMap(),
      where: '$column5Id = ?',
      whereArgs: [loan.id],
    );
  }

  Future<int> deleteLoan(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName5,
      where: '$column5Id = ?',
      whereArgs: [id],
    );


  }





  Future<List> getAllReturnedLoans() async {
    var dbClient = await _db;
    var result = await dbClient.query(tableName6, columns: [
      column6Id,
      column6Date,
      column6Etat,
      column6Loan,

    ]);

    return result.toList();
  }

  Future<int> saveReturnedLoan(ModelReturnedLoan returnedloan) async {
    var dbClient = await _db;
    return await dbClient.insert(tableName6, returnedloan.toMap());

  }


  Future<int> updateReturnedLoan(ModelReturnedLoan returnedloan) async {
    var dbClient = await _db;
    return await dbClient.update(
      tableName6,
      returnedloan.toMap(),
      where: '$column6Id = ?',
      whereArgs: [returnedloan.id],
    );
  }

  Future<int> deleteReturnedLoan(int id) async {
    var dbClient = await _db;
    return await dbClient.delete(
      tableName6,
      where: '$column6Id = ?',
      whereArgs: [id],
    );


  }




}
