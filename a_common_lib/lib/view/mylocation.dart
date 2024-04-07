import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart'
    as latlng; // flutter_map에서 사용하는 위도와 경도 관련 라이브러리

/*
  Description : My location on map
  Date        : 2024.03.27
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    -  Test 를 위해 a_ common lib 으로 가져옴 
*/
class MyLocation extends StatefulWidget {
  const MyLocation({super.key});

  @override
  State<MyLocation> createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  late Position currentPosition; // 현재 위치 정보를 저장할 변수
  late int selectedIndexOfLoc; // 선택한 메뉴의 인덱스를 저장할 변수
  late double latData; // 위도 정보를 저장할 변수
  late double longData; // 경도 정보를 저장할 변수
  late MapController mapController; // 지도 컨트롤러
  late bool mapEable; // 지도를 표시할 수 있는지 여부를 저장할 변수
  late List location; // 선택 가능한 위치 목록을 저장할 변수

  // Segmented Control 위젯에 사용할 메뉴 아이템들
  Map<int, Widget> segmemtWidgets = {
    0: const SizedBox(
      child: Text(
        '현위치',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    ),
    1: const SizedBox(
      child: Text(
        '둘리뮤지엄',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    ),
    2: const SizedBox(
      child: Text(
        '서대문형무소역사관',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12),
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    selectedIndexOfLoc = 0; // 초기 선택 메뉴 설정
    mapController = MapController(); // 지도 컨트롤러 초기화
    mapEable = false; // 지도 표시 여부 초기화
    location = ['현위치', '둘리뮤지엄', '서대문형무소역사관']; // 선택 가능한 위치 목록 초기화
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
              // Segmented Control 위젯 설정
              CupertinoSegmentedControl(
                groupValue: selectedIndexOfLoc,
                children: segmemtWidgets,
                onValueChanged: (value) {
                  selectedIndexOfLoc = value; // 선택한 메뉴의 인덱스 저장
                  if (selectedIndexOfLoc == 0) {
                    getCurrentLocation(); // 현재 위치 받아오기
                    latData = currentPosition.latitude; // 위도 정보 저장
                    longData = currentPosition.longitude; // 경도 정보 저장
                    mapController.move(
                        latlng.LatLng(latData, longData), // 화면 이동
                        17.0); // 줌 레벨 설정
                  } else if (selectedIndexOfLoc == 1) {
                    latData = 37.65243153; // 둘리뮤지엄의 위도 정보
                    longData = 127.0276397; // 둘리뮤지엄의 경도 정보
                    mapController.move(
                        latlng.LatLng(latData, longData), // 화면 이동
                        17.0); // 줌 레벨 설정
                  } else {
                    latData = 37.57244171; // 서대문형무소역사관의 위도 정보
                    longData = 126.9595412; // 서대문형무소역사관의 경도 정보
                    mapController.move(
                        latlng.LatLng(latData, longData), // 화면 이동
                        17.0); // 줌 레벨 설정
                  }
                  setState(() {}); // 화면 갱신
                },
              )
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
            initialCenter: latlng.LatLng(37.497368, 127.027637), // 초기 지도 중심 설정
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
              point: latlng.LatLng(latData, longData), // 마커 위치 설정
              child: Column(
                children: [
                  Text(
                    location[selectedIndexOfLoc], // 선택한 위치 정보 표시
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
