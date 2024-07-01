import 'package:sqflite/sqflite.dart';
import 'Package:path/path.dart'as Path;
import 'package:test_029/Model/contact_model.dart';
class DbHelper{
  static const String _createTable=''' CREATE TABLE $ContactTable(
  $tblColId INTEGER PRIMARY KEY AUTOINCREMENT,
  $tblColName TEXT,
  $tblColEmail TEXT,
  $tblColPhone TEXT,
  $tblColAddress TEXT,
  $tblColGPO TEXT,
  $tblColCompany TEXT,
  $tblColDesignation TEXT,
  $tblColWebsite TEXT,
  $tblColImage TEXT,
  $tblColFavorite INTEGER
  )''';

  static Future<Database>open()async{
    final rootpath=await getDatabasesPath();
    final dbpath=Path.join(rootpath,"Contact_Db_test029.db");
    return openDatabase(dbpath,version: 2,onCreate:(db,version)async{
      db.execute(_createTable);
    },onUpgrade: (db,oldVersion,newVersion)async{
      if(oldVersion==1){
        db.execute('alter table $ContactTable add column $tblColFavorite integer not null default 0');
      }
    });
  }
  //insert data
  static Future<int >insertdate(ContactModel contactModel)async{
    final db=await open();
    return db.insert(ContactTable,contactModel.toMap());
  }
  //get all data
  static Future<List<ContactModel>>getAlldata()async{
    final db=await open();
    final List<Map<String,dynamic>>maplist=await db.query(ContactTable);
    return List.generate(maplist.length, (index) =>ContactModel.formMap(maplist[index]));
  }
  // get id data
  static Future<ContactModel>getIddata(int id)async{
    final db=await open();
    final List<Map<String,dynamic>>maplist=await db.query(ContactTable,where:'$tblColId=?',whereArgs: [id]);
    return ContactModel.formMap(maplist.first);
  }
  // delete data
  static Future<int>deletedata(int id)async{
    final db=await open();
    return db.delete(ContactTable,where:'$tblColId=?',whereArgs: [id]);
  }
  //Update favorite
  static Future<int>updateFavorite(int id,int value)async{
    final db=await open();
    return db.update(ContactTable,{tblColFavorite:value},where:'$tblColId=?',whereArgs: [id]);
  }
}