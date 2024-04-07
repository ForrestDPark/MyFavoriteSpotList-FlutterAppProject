import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  const MyTextfield({super.key});

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  late TextEditingController tfcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: tfcontroller,
          decoration: const InputDecoration(
              labelText: "", 
              border: OutlineInputBorder()),
          keyboardType: TextInputType.text,
          // keyboardType: TextInputType.number,
        ));
  }
}
