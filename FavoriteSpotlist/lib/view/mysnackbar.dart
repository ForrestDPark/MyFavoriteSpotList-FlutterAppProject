import 'package:flutter/material.dart';

/*
 
  Description : MySnackbar class
  Date        : 2024.03.21
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    - 모든 sanck bar 종류를 여기서 다쓸수 있게 정리  

*/

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () => snacBarFunction(context, Colors.red),
          child: const Text("Snack Bar Button")),
    );
  }

  // -=-=-=-=-Functions =-=-=-=--=-
  snacBarFunction(BuildContext context, Color color1) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Elevated Button is clicked."),
      backgroundColor: color1,
      duration: Duration(seconds: 1),
    ));
  }

  errorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("숫자를 입력하세요 "),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}
