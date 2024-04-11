import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InsertFirebase extends StatefulWidget {
  const InsertFirebase({super.key});

  @override
  State<InsertFirebase> createState() => _InsertFirebaseState();
}

class _InsertFirebaseState extends State<InsertFirebase> {

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

  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  File? imgFile; // XFile type 을 바꾸기위함. 
  List loc_data = Get.arguments ?? [0.0,0.0]; 


  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = '';
    phone = '';
    lat = 0.0;
    lng = 0.0;
    estimate = '';
    initdate = DateTime.now().toIso8601String();

    nameController      = TextEditingController();
    phoneController     = TextEditingController();
    latController       = TextEditingController(text: loc_data[0].toString());
    lngController       = TextEditingController(text :loc_data[1].toString());
    estimateController  = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: latController,
                decoration: const InputDecoration(
                  labelText: " 위도을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: lngController,
                decoration: const InputDecoration(
                  labelText: " 경로을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: " 이름을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: " 번호을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: estimateController,
                decoration: const InputDecoration(
                  labelText: " 평가를 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            
            ElevatedButton(
              onPressed: () => getImageFromGallery(ImageSource.gallery), 
              child: const Text("Gallery"))
            ,
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.grey,
              child: Center(
                child: imageFile == null
                ? const Text('image is not selected')
                : Image.file(File(imageFile!.path)),
              ),
            ),
            ElevatedButton(
              onPressed: () => insertAction(),
              child: const Text("입력"))
          ],
        ),
      ),
    );
  }

  //Functions
  getImageFromGallery(imageSource) async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    // 보안상 이유로 직접 xfile 을 들고올수없고 패스를 받아서 다시 사용함. 
    imageFile =XFile(pickedFile!.path);
    imgFile = File(imageFile!.path); // firebase 때문에 만든것!
    setState((){});

  }
  //Function
  insertAction() async{ // why async? 
  //이미지 가 스토리지에 저장이 되어야 쓸수있다. 
    String name = nameController.text;
    String phone = phoneController.text;
    String estimate = estimateController.text;
    double lat = double.parse(latController.text);
    double lng = double.parse(lngController.text);
    String image = await preparingImage(); // Firebase에 올린 파일의 이미지 주소를 기다려서 가져옴

    FirebaseFirestore.instance
      .collection('musteatplace')
      .add({
        'name' : name,
        'phone': phone,
        'lat' : lat,
        'lng' : lng,
        'image' : image,
        'estimate' : estimate,
        'initdate': initdate
      });

      Get.back();

  }
  Future<String> preparingImage() async{
    //store 가 아님.!!
    final firebaseStorage = FirebaseStorage.instance
        .ref()
        .child('images') //storage 이름 
        .child('${nameController.text}.png');// 
    await firebaseStorage.putFile(imgFile!); // 파일을 업로드함. 
    String downloadURL = await firebaseStorage.getDownloadURL(); // d안기다리면 입력할때 주소를 못집어넣음
    return downloadURL;
  }
}// End