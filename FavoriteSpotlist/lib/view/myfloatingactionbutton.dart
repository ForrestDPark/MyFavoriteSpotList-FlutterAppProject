import 'package:flutter/material.dart';
/*
 
  Description : Floating Actiion Button
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : - 

*/

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FloatingActionButton(
        onPressed: () {
          //
          //setState(() {});
        },
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
