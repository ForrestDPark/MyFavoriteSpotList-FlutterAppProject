import 'dart:typed_data';
/*
 
  Description : MustEatPlace Database model 
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
    2024.04.07 Sun
       - factory 에서 res['seq']  가 아니라 res['id'] 로 되있던것 수정 
  Detail      : 
    - 

*/
class MustEatPlaces{
  // key ( auto increament )
  int? seq; // 입력할때는  nUll  -> 불러올때는 키값

  //values
  String name;
  String phone;
  double lat;
  double lng;
  Uint8List image;// image 모양을 글자로 바꾸어 가져옴 
  String? estimate;
  String? initdate;

  MustEatPlaces({
      this.seq, // optional 은 required 필요 x
      required this.name,
      required this.phone,
      required this.lat,
      required this.lng,
      required this.image,
      this.estimate,
      this.initdate
  });
  // factory 생략
  MustEatPlaces.fromMap(Map<String, dynamic> res) //{ // String -> column name, dynamic 은 row 값?
      :
      seq = res['seq'],
      phone = res['phone'], 
      name = res['name'], 
      lat = res['lat'], 
      lng = res['lng'],
      image = res['image'],
      estimate = res['estimate'],
      initdate = res['initdate'];

}