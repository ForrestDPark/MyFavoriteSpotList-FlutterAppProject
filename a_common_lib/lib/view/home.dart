import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_enter_app/view/musteatplace/insert_place.dart';
import 'package:keyboard_enter_app/view/mydialog.dart';
import 'package:keyboard_enter_app/view/myfavoritlist.dart';
import 'package:keyboard_enter_app/view/mylistview.dart';
import 'package:keyboard_enter_app/view/mysnackbar.dart';
import 'package:keyboard_enter_app/view/myswipe.dart';
import 'package:keyboard_enter_app/view/mytabbar.dart';

import 'mydrawer.dart';
import 'mylocation.dart';
import 'mypickerview.dart';
//import  'package:http/http.dart' as http; // http 는 겹칠수도 있음
//import 'dart:math';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter_map/flutter_map.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:latlong2/latlong.dart' as latlng;

/*
 
  Description : Home
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
    1. app Bar design
    2. Scaffold 에 Geusture detector 씌워서 키보드 내리면 사라지게끔함.  
    3. 하단 탭바 설치 
  Detail      : - 

*/
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  //properties
  late int value;
  late int d_sec;
  late String title;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    value = 0;
    title = "My Favorite spot";
    d_sec = 3;
    tabController = TabController(length: 3, vsync: this);

    // Timer 설치 timer 는 기본적으로 async 임.
    Timer.periodic(const Duration(seconds: 3), (timer) {
      // Function
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // App Bar
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
          // leading: IconButton(
          //     onPressed: () {
          //       // Drawer Contents
          //     },
          //     icon: Icon(Icons.menu)),
          actions: [
            IconButton(
                onPressed: () {
                  // Add MustEatPlace
                  Get.to(InsertMustEatPlace());
                },
                icon: Icon(Icons.add_outlined))
          ],
        ),

        // Drawer
        drawer: MyDrawer(
          drawerColorScheme: Theme.of(context).colorScheme,
        ),

        body: TabBarView(controller: tabController, children: [
          Center(
            child: MyFavoritList(),
          ),
          Center(
            child: MyLocation(),
          ),
          Center(
            child: MyPickerview(),
          )
        ]),

        // Bottom Tab Bar
        bottomNavigationBar: MyTabBar(
          tabController: tabController,
          tabColorscheme: Theme.of(context).colorScheme,
          //tabbarColor: Theme.of(context).colorScheme.tertiaryContainer,
        ),
      ),
    );
  }
  // --- Functions ---
} // End
