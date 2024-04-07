import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';


/*
 
  Description :  Flower garden detail image
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.07 Sun
  Detail      : 
    - Get 방식 교체하며 model message 필요없어졌음. 

*/

class DetailView extends StatefulWidget {
  const DetailView({super.key});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  var value = Get.arguments ?? "__";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(value),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image.asset("images/flower/${value}"),
        ),
      ),
    );
  }
}
