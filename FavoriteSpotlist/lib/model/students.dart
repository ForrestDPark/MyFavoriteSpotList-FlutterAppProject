import 'dart:typed_data';

class Students{
  // key ( auto increament )
  int? id; // 입력할때는  nUll  -> 불러올때는 키값

  //values
  String code;
  String name;
  String dept;
  String phone;
  Uint8List image;// image 모양을 글자로 바궈서 가져옴 

  Students({
      this.id, // optional 은 required 필요 x
      required this.code,
      required this.name,
      required this.dept,
      required this.phone,
      required this.image
  });
  // factory 생략
  Students.fromMap(Map<String, dynamic> res) //{ // String -> column name, dynamic 은 row 값?
      :
      id = res['id'],
      code= res['code'], 
      name= res['name'], 
      dept= res['dept'], 
      phone= res['phone'],
      image = res['image'];

}