import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPickerview extends StatefulWidget {
  const MyPickerview({super.key});

  @override
  State<MyPickerview> createState() => _MyPickerviewState();
}

class _MyPickerviewState extends State<MyPickerview> {
  // properties
  late List _imageName;
  late int _selectedItem;
  late int pikerSize;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageName =[
      'w1.jpg',
      'w2.jpg',
      'w3.jpg',
      'w4.jpg',
      'w5.jpg',
      'w6.jpg',
      'w7.jpg',
      'w8.jpg',
      'w9.jpg',
      'w10.jpg',
    ];
    _selectedItem=0;
  
  }  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Picker View로 이미지 선택',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: CupertinoPicker(
                itemExtent: 100, 
                scrollController: FixedExtentScrollController(initialItem: 4),
                onSelectedItemChanged: (value) {
                  _selectedItem = value;
                  setState(() {});
                }, 
                children: List.generate(10, (index) => Center(
                  child: Image.asset('images/picker/${_imageName[index]}',
                  width: 100,),
                ))
                  // Image.asset('images/${_imageName[0]}',
                  // width: 100,
                  // height: 50,),
                  // Image.asset('images/${_imageName[1]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[2]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[3]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[4]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[5]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[6]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[7]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[8]}',
                  // width: 50,),
                  // Image.asset('images/${_imageName[9]}',
                  // width: 50,),
              
                 

                  // Text(_imageName[0]),
                  // Text(_imageName[1]),
                  // Text(_imageName[2]),
                  // Text(_imageName[3]),
                  // Text(_imageName[4]),
                  // Text(_imageName[5]),
                  // Text(_imageName[6]),
                  // Text(_imageName[7]),
                  // Text(_imageName[8]),
                  // Text(_imageName[9]),
                ),
            ),
            Text(
              'Selectead Item : ${_imageName[_selectedItem]}'
            ),
            SizedBox(
              width: 300,
              height: 200,
              child: Image.asset('images/picker/${_imageName[_selectedItem]}',
              width: 300,
              height: 200,
              fit: BoxFit.fill,
              ),
            )

          ],
        ),
      ),
    );
  }
}