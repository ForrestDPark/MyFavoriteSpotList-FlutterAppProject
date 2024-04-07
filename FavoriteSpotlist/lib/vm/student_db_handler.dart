import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/students.dart';

class DatabaseHandler {
  // 항상 이 함수랑 연결 먼저 시켜줘야한다.
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath(); //어디 위치하는지, 어디에 설치할건지
    return openDatabase(
      join(path, 'student.db'), //현재위치에 student.db로 db를 만들거야

      //우리앱을 제일 먼저 처음 사용하는 사용자일때 테이블을 만들어!!
      onCreate: (db, version) async {
        await db.execute(
            'create table students (id integer primary key autoincrement, code text, name text, dept text, phone text )');
      },
      version: 1, //version은 그냥 1버전
    );
  } //=> 이게 뷰모델이다.

  //검색해오는 작업
  Future<List<Students>> queryStudents() async {
    //매번 initializeDB()이 함수를 실행시키기 귀찮으니 검색해오면서 initializeDB()를 실행한다.
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResults =
        await db.rawQuery('select * from students'); //sqlite은 return 값이 map이므로
    return queryResults
        .map((e) => Students.fromMap(e))
        .toList(); // 가져온 값을 factory를 통해서 가져온 뒤 리스트로 바꿔준다.
  } //=> 이게 뷰모델이다.

  //입력하는 쿼리 0이냔 아니냐로 했냐안했냐를 구분한다.
  //Future<void> : return 값 안받으려면 요로케
  Future<int> insertStudents(Students student) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
        "insert into students (code, name, dept, phone) values (?,?,?,?)",
        [student.code, student.name, student.dept, student.phone]);
    return result;
  }

  updateStudents(Students student) async {
    // int result = 0;
    final Database db = await initializeDB();
    await db.rawUpdate(
        "update students set name =?, dept=?, phone=? where code =?",
        [student.name, student.dept, student.phone, student.code]);
  }

  deleteStudents(String code) async {
    // int result = 0;
    final Database db = await initializeDB();
    await db.rawUpdate("delete from students where code =?", [code]);
  }
}
