import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'peoples.dart';
import 'dart:async';

class DBHelper {

  static Database _db;
  static const String TABLE ='Peoples';
  static const String DB_NAME='peoples.db';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String PHONE = 'phone';
  static const String TIME = 'time';
  static const String COSTPERHOUR = 'costperhour';
  static const String PAIDAMOUNT = 'paidamount';
  static const String TOTAL = 'total';
  static const String REMAINING = 'remaining';

  Future<Database>get db async {
    if(_db!=null){
      return _db;
    }
    _db= await initDb();
    return _db;
  }
  initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version:1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async{
    await
    db.execute("CREATE TABLE"
        " $TABLE($ID INTEGER PRIMARY KEY, $NAME TEXT, $PHONE TEXT, $TIME TEXT, $COSTPERHOUR TEXT, $PAIDAMOUNT TEXT, $TOTAL TEXT, $REMAINING TEXT)");
  }

  Future<peoples>save (peoples people) async{
    var dbClient = await db;
    people.id = await dbClient.insert(TABLE, people.toMap());
    return people;
//     await dbClient.transaction((txn) async{
//   var query ="INSERT INTO $TABLE ($NAME) VALUES ('"+people.name+"')";
// //var query ="INSERT INTO $TABLE ($NAME VALUES ('"+people.name+"'),$PHONE VALUES ('"+people.phone+"'),$TIME, $COSTPERHOUR,$PAIDAMOUNT,$TOTAL,$REMAINING )  ";
//    return await txn.rawInsert(query);
//
//     });
  }
  Future<List<peoples>>getpeoples() async{
    var dbClient = await db;
    List<Map>maps=await dbClient.query(TABLE, columns:[ID,NAME,PHONE,TIME,COSTPERHOUR,PAIDAMOUNT,TOTAL,REMAINING]);
//List<Map> maps = await dbClient.rawQuery("SELECT * FROM STABLE");
  List<peoples> people =[];
  if(maps.length>0){
    for(int i =0; i<maps.length; i++){
      people.add(peoples.fromMap(maps[i]));
    }
  }
  return people;
  }
  Future<int> delete(int id)async{
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID=?', whereArgs: [id]);
  }
  Future<int> update(peoples people)async{
    var dbClient = await db;
    return await dbClient.update(TABLE, people.toMap(),where: '$ID=?',whereArgs:[people.id] );
  }
  Future close()async{
    var dbClient = await db;
    dbClient.close();


  }



}

