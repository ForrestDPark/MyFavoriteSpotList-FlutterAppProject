import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyActionSheet extends StatefulWidget {
  const MyActionSheet({super.key});

  @override
  State<MyActionSheet> createState() => _MyActionSheetState();
}

class _MyActionSheetState extends State<MyActionSheet> {
  @override
  Widget build(BuildContext context) {
    return actionSheet();
  }

  //funtioin
  actionSheet() {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context) => CupertinoActionSheet(
        title: const Text("램프끄기"),
        message: const Text("램프를 끄시겠습니까"),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () {
                print('action is pressed');
                //_onOffChange();             
                 },
              child: const Text("예")),
          CupertinoActionSheetAction(
              onPressed: () {
                print('action is pressed');
                Get.back();
              },
              child: const Text("아니오")),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: const Text("Exit"),
        ),
      ),
    );
  }

}