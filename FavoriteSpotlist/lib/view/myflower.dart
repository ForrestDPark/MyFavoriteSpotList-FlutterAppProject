import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import '../view/flowergarden/detail_view.dart';

/*
 
  Description :  Flower garden card collection version 
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.07 Sun
  Detail      : - 

*/
class MyFlower extends StatefulWidget {
  const MyFlower({super.key});

  @override
  State<MyFlower> createState() => _MyFlowerState();
}

class _MyFlowerState extends State<MyFlower> {
  // properties
  late List<String> imageName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageName = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flower Garden"),
      ),
      body: GridView.builder(
        itemCount: imageName.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) => Container(
          color: Colors.white,
          child: GestureDetector(
            onTap: () {
              print("clicked");
              //Message.iamgeName = imageName[index];

              Get.to(const DetailView(), arguments: imageName[index]);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 130,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "images/flower/${imageName[index]}",
                              width: 50,
                              height: 70,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50,
                          right: -20,
                          child: Transform.rotate(
                              angle: -45,
                              child: Text(
                                'All right reserved',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                    Text(imageName[index])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
