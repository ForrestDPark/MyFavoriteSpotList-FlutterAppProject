import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateFirebase extends StatefulWidget {
  const UpdateFirebase({super.key});

  @override
  State<UpdateFirebase> createState() => _UpdateFirebaseState();
}

class _UpdateFirebaseState extends State<UpdateFirebase> {

    late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController deptController;
  late TextEditingController phoneController;

  var value = Get.arguments ?? "_" ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    deptController = TextEditingController();
    phoneController = TextEditingController();

    codeController.text =value[1];
    nameController.text =value[2];
    deptController.text =value[3];
    phoneController.text =value[4];
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
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: " 학번을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
                readOnly:  true,
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
                controller: deptController,
                decoration: const InputDecoration(
                  labelText: " 학과을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: " 전번을 입력하세요 "
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Firebase 는 기본적으로 async 작업을 한다. 
                FirebaseFirestore.instance
                  .collection('students')
                  .doc(value[0])
                  .update(
                    {
                      'code'  : codeController.text,
                      'name'  : nameController.text,
                      'dept'  : deptController.text,
                      'phone' : phoneController.text
                    }
                  );
                  Get.back();
              }, 
              child: const Text("수정"))
          ],

        ),
      ),
    );
  }
}