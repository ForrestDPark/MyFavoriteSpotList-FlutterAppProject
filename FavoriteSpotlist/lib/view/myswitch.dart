import 'package:flutter/material.dart';

/*
 
  Description : Switch
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    - 기본 function . 향후 수정 

*/
class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Switch(
        activeColor: Colors.red,
        activeTrackColor: Colors.blue,
        inactiveTrackColor: Colors.white,
        inactiveThumbColor: Colors.blueAccent,
        value: true,
        onChanged: (value) {
          //
        },
      ),
    );
  }

  
}// End
