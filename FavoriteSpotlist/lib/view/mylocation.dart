import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart'
    as latlng; // flutter_map에서 사용하는 위도와 경도 관련 라이브러리

/*
  Description : My location on map
  Date        : 2024.03.27
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
    2024.04.06 Sun
      -  Test 를 위해 a_ common lib 으로 가져옴 
      - myfavorite 에서 위도경도, 장소 이름 받아서 지도에 표시하기 

      
  Detail      : 
*/
class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {

  // Properties
  final _selectedSpot = Get.arguments ?? "__";

  // Location info
  late Position currentPosition; // 현재 위치 정보를 저장할 변수
  late int selectedIndexOfLoc; // 선택한 메뉴의 인덱스를 저장할 변수
  late double latData; // 위도 정보를 저장할 변수
  late double longData; // 경도 정보를 저장할 변수
  late MapController mapController; // 지도 컨트롤러
  late bool mapEable; // 지도를 표시할 수 있는지 여부를 저장할 변수
  late List loc_latlng; // 선택 가능한 위치 목록을 저장할 변수

  @override
  void initState() {
    super.initState();
    selectedIndexOfLoc = 0; 
    mapController = MapController(); 
    mapEable = false; 
    loc_latlng= _selectedSpot; 
    checkLocationPermission(); // 위치 허용 확인 함수 호출
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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              const Text(
                'GPS & Map',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: mapEable
          ? flutterMap() // 지도 표시
          : const Center(
              child: CircularProgressIndicator(), // 로딩 중 표시
            ),
    );
  }

  // 지도 위젯
  Widget flutterMap() {
    return FlutterMap(
      
        mapController: mapController,
        options: MapOptions(
            initialCenter: latlng.LatLng(_selectedSpot[0], _selectedSpot[1]), // 초기 지도 중심 설정
            initialZoom: 17.0), // 초기 줌 레벨 설정
        children: [
          TileLayer(
            urlTemplate:
                'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // 타일 레이어 설정
          ),
          // 마커 레이어 설정
          MarkerLayer(markers: [
            Marker(
              width: 80,
              height: 80,
              point: latlng.LatLng(_selectedSpot[0], _selectedSpot[1]), // 마커 위치 설정
              child: Column(
                children: [
                  Text(
                    "My Favorite",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(
                    Icons.pin_drop, // 핀 모양 아이콘 표시
                    size: 50,
                    color: Colors.red, // 아이콘 색상 설정
                  )
                ],
              ),
            )
          ])
        ]);
  }
}
