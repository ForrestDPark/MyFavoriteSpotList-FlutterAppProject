import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


// import 'mydrawer.dart';
// import 'mylocation.dart';
// import 'mypickerview.dart';
import  'package:http/http.dart' as http; // http 는 겹칠수도 있음
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as latlng;

import 'drawer/mydrawer.dart';
import 'listview/myfavoritelist_firebase.dart';
import 'listview/myfavoritlist.dart';
import 'musteatplace/insert_place.dart';
import 'tabbar/mytabbar.dart';

/*
 
  Description : Home
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
    2024.04.06 Sun
      1. app Bar design
      2. Scaffold 에 Geusture detector 씌워서 키보드 내리면 사라지게끔함.  
      3. 하단 탭바 설치 
    2024.04.07 Mon
      - 1. 현재위치 탐색 하여 인서트에 보내주는 기능 추가 

    2024.04.11 Thu
      - Firebase DB 사용 기능 추가 
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


  //location information 
   late List<double> distanceList ; // 맛집들과 나의 거리 
  late Position currentPosition; 
  late int selectedIndexOfLoc; 
  late double? latData; 
  late double? longData;
  late MapController mapController; 
  late bool mapEable; 


  @override
  void initState() {
    super.initState();
    value = 0;
    title = "My Favorite spot";
    d_sec = 3;
    tabController = TabController(length: 3, vsync: this);
    checkLocationPermission();
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

  // 위치 허용 확인 함수
  checkLocationPermission() async {
    LocationPermission permission =
        await Geolocator.checkPermission(); // 위치 권한 확인
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission(); // 권한 요청
    }
    if (permission == LocationPermission.deniedForever) {
      return; // 영구적으로 거부된 경우 처리 중단
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getCurrentLocation(); // 위치 허용되었을 때 현재 위치 받아오는 함수 호출
    }
  }

  // 현재 위치 받아오는 함수
  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
           desiredAccuracy: LocationAccuracy.best, // 위치 정확도 설정
            forceAndroidLocationManager: true)
        .then((position) {
      currentPosition = position; // 현재 위치 정보 저장
      mapEable = true; // 지도 표시 가능 상태로 설정
      latData = currentPosition.latitude; // 위도 정보 저장
      longData = currentPosition.longitude; // 경도 정보 저장
      setState(() {}); // 화면 갱신
    }).catchError((e) {
      print(e); // 에러 발생 시 에러 메시지 출력
    });
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

          actions: [
            IconButton(
                onPressed: () {
                  // Add MustEatPlace
                  Get.to(
                    InsertMustEatPlace(), 
                    arguments: 
                    [
                      latData,
                      longData
                      ]);
                },
                icon: Icon(Icons.add_outlined)
                ),
                IconButton(
                onPressed: () {
                  // Add MustEatPlace
                  Get.to(
                    InsertMustEatPlace(), 
                    arguments: 
                    [
                      latData,
                      longData
                      ]);
                },
                icon: Icon(Icons.add_box_rounded)
                )
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
            child: MyFavoritList_firebase(),
          ),
          Center(
            child: Center(),
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
