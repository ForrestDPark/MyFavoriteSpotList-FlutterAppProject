import 'package:flutter/material.dart';
/*
 
  Description : Image rotation 
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : - 

*/
class Myrotation extends StatefulWidget {
  const Myrotation({super.key});

  @override
  State<Myrotation> createState() => _MyrotationState();
}

class _MyrotationState extends State<Myrotation> {
    //properties
  late String _lampImage; // Image file name
  late double _lampWidth; // Image width
  late double _lampHight; // Image Height
  late String _buttonName; // Button title
  late bool _switch; // switch 의 상태
  late String _lampSizeStatus; // 현재 화면의 lamp 크기
  late double _rotation; // 회전 각도

  @override
  void initState() {
    super.initState();
    _lampImage = "images/lamp2/lamp_on.png";
    _lampHight = 150;
    _lampWidth = 300;
    _buttonName = "Image 확대";
    _lampSizeStatus = 'small';
    _switch = true;
    _rotation = 0;
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
                    turns: AlwaysStoppedAnimation(_rotation / 360),
                    child: Image.asset(
                      _lampImage,
                      width: _lampWidth,
                      height: _lampHight,
                    ),
                  );
  }
}