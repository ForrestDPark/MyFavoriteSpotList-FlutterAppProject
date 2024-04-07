import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/musteatplace.dart';

/*
 
  Description : MustEatPlace Database Handler (sql query execution )
  Date        : 2024.04.06 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun

    2024.04.07 Sun
      - image 기능 삭제 => query_test
  Detail      : 
    - DB initialization  => db open 
    - question : image 는 blob? 이미지 주소로 해야하는 거 아닌가?
    - type 은 text 

*/
class DatabaseHandler {

  // Fields 
  String dbName = 'musteatplace';

  // Methods

  // DB Initialiation ( Must call this on all query executions)
  Future<Database> initializeDB() async {
    // 1. Get DB path on memory of user device
    String path = await getDatabasesPath();
    

    //2. Query Gen
    String query_test = '''create table $dbName
                        (seq integer primary key autoincrement, 
                        name text(30), 
                        phone text(14), 
                        lat real(20), 
                        lng real(20), 
                        image blob,
                        estimate txt, 
                        initdate date )''';

    return openDatabase(
      join(path, '$dbName.db'), // make db file on current memory path

      //If first user -> create else, don't
      onCreate: (db, version) async {
        await db.execute(query_test);
      },
      version: 1, 
    );
  } 

  // READ Query Execution
  Future<List<MustEatPlaces>> queryMustEatPlaces() async {
    String selectQuery = 'select * from $dbName';
    // db initialization
    final Database db = await initializeDB();
    
    // Query return : map
    final List<Map<String, Object?>> queryResults = await db.rawQuery(selectQuery); 
    print('select query : $selectQuery');
    print(queryResults);
    // Convert Map => List 
    return queryResults.map(
      (e) => MustEatPlaces.fromMap(e)).toList(); 
   
  } 
  // Insert Query Execution
  Future<int> insertMustEatPlaces(MustEatPlaces musteatplace) async {
    int result = 0; // If insertion success then return 1

    // Insert Query Gen.
    String insertQuery = '''insert into $dbName 
                            ( name, phone, lat, lng, image, estimate, initdate) 
                            values (?,?,?,?,?,?,?)''';
    // String insertQuery_test= '''insert into $dbName 
    //                         (name, phone, lat, lng, estimate, initdate) 
    //                         values (?,?,?,?,?,?)''';

    // DB OPEN
    final Database db = await initializeDB();
    print("DataBase open...");
    result = await db.rawInsert(
        insertQuery,
        [
          musteatplace.name, 
          musteatplace.phone,
          musteatplace.lat,
          musteatplace.lng,
          musteatplace.image,
          musteatplace.estimate,
          musteatplace.initdate,
         ]);
    return result;
  }

  updateMustEatPlaces(MustEatPlaces musteatplace) async {
    // int result = 0;
    final Database db = await initializeDB();

    String updateQuery_test =
      ''' 
      update $dbName 
      set name =?, 
      phone=?, 
      lat=?, 
      lng=?, 
      estimate=? 
      where seq =?
      ''';

    await db.rawUpdate(
        updateQuery_test,
        [
          musteatplace.name, 
          musteatplace.phone, 
          musteatplace.lat, 
          musteatplace.lng,
          // musteatplace.image,
          musteatplace.estimate,
          musteatplace.seq,
          ]);
  }

  deleteMustEatPlaces(String code) async {
    // int result = 0;
    String deleteQuery ='delete from $dbName where code =?';
    final Database db = await initializeDB();
    await db.rawUpdate(deleteQuery, [code]);
  }
}
