import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/musteatplace.dart';
import '../../vm/musteatplace_db_handler.dart';

/*
 
  Description : Insert MustEatPlace database
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
    2024.04.07 Sun
      - insert test (without image data) 
      - image picker 추가 
  Detail      : 
    

*/
class InsertMustEatPlace extends StatefulWidget {
  const InsertMustEatPlace({super.key});

  @override
  State<InsertMustEatPlace> createState() => _InsertMustEatPlaceState();
}

class _InsertMustEatPlaceState extends State<InsertMustEatPlace> {
  late DatabaseHandler handler;
  // late int seq;
  late String name;
  late String phone;
  late double lat;
  late double lng;
  late String estimate;
  late String initdate;

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController latController;
  late TextEditingController lngController;
  late TextEditingController estimateController;
  late bool addclicked;

  ImagePicker picker = ImagePicker();
  XFile? imageFile;
  List loc_data = Get.arguments ?? [0.0,0.0]; 

  @override
  void initState() {
    super.initState();

    addclicked =false;
    handler = DatabaseHandler();

    // seq = 1; -> auto increase
    name = '';
    phone = '';
    lat = 0.0;
    lng = 0.0;
    estimate = '';
    initdate = DateTime.now().toIso8601String();

    nameController = TextEditingController();
    phoneController = TextEditingController();
    latController = TextEditingController(text: loc_data[0].toString());
    lngController = TextEditingController(text :loc_data[1].toString());
    estimateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '장소 추가',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              top: 3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.25,
                child: imageFile == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: Image.asset('images/pocketmon/noimage.gif'))
                    : Image.file(File(imageFile!.path)),
              ),
            ),

            // 사진 정보 입력
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.amber,
                      shape: RoundedRectangleBorder()),
                  onPressed: () {
                    //사진 받아오는 함수 호출
                    getImageFileFromGallery(ImageSource.gallery);
                    addclicked =true;
                  },
                  child: const Text(
                    '사진추가하기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),

            // 위치 정보 입력
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "위치 : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: latController,
                      decoration: const InputDecoration(
                          labelText: '경도', border: OutlineInputBorder()),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 155,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: lngController,
                      decoration: const InputDecoration(
                          labelText: '위도', border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ],
            ),

            // 이름 입력
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "장소 : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: '이름를 입력하세요'),
                    ),
                  ),
                ),
              ],
            ),
            // 전화번호 입력
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "전화 : ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: '번호를 입력하세요'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // 평가 입력
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    "평가 : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 260,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 5,
                      //expands: true,
                      maxLength: 200,
                      controller: estimateController,
                      decoration: const InputDecoration(
                          labelText: '평가를 입력하세요', border: OutlineInputBorder()),
                    ),
                  ),
                ),
              ],
            ),

            ElevatedButton(
                onPressed: () async {
                  // seq = seq +1;
                  name = nameController.text.toString();
                  lat = double.parse(latController.text.trim().toString());
                  lng = double.parse(lngController.text.trim().toString());
                  phone = phoneController.text.toString();
                  estimate = estimateController.text.toString();

                  MustEatPlaces musteatplace = MustEatPlaces(
                      // seq: seq,
                      name: name,
                      lat: lat,
                      lng: lng,
                      phone: phone,
                      estimate: estimate,
                      image: addclicked
                          ? await imageFile!.readAsBytes()
                          : await getImageBytes('images/pocketmon/noimage.gif'),
                      initdate: initdate);

                  int returnValue =
                      await handler.insertMustEatPlaces(musteatplace);
                  print("입력결과 : $returnValue");
                  _showDialog();
                  // if(returnValue != 1){
                  //   //Snack bar
                  // }else{
                  //   _showDialog();
                  // }
                },
                child: const Text('입력'))
          ],
        ),
      ),
    );
  }

  //functions
  _showDialog() {
    Get.defaultDialog(
        title: '입력결과',
        middleText: "입력이 완료 되었습니다.",
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        barrierDismissible: false,
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: const Text('OK'))
        ]);
  }

  getImageFileFromGallery(imageSource_gallery) async {
    final XFile? pickedImageFile =
        await picker.pickImage(source: imageSource_gallery);
    if (pickedImageFile != null) {
      imageFile = XFile(pickedImageFile.path);
    } else {
      imageFile = null;
    }
    setState(() {});
  }

  // 이미지 파일을 Uint8List로 변환하는 함수
  Future<Uint8List> getImageBytes(String imagePath) async {
    ByteData imageByteData = await rootBundle.load(imagePath);
    return imageByteData.buffer.asUint8List();
  }
} //End
