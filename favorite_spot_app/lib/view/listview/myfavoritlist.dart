import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../vm/musteatplace_db_handler.dart';
import '../gps_loctions/mylocation.dart';
import '../musteatplace/update_place.dart';

/*
 
  Description : My Favorit spot list with sqlite select query
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 
    2024.04.07 Sun
      - image , place name , phone represent 
      - 현재 나의 위치 와 spot 의 거리를 계산하여 찍어줌. 
  Detail      : - 

*/

class MyFavoritList extends StatefulWidget {
  const MyFavoritList({super.key});

  @override
  State<MyFavoritList> createState() => _MyFavoritListState();
}

class _MyFavoritListState extends State<MyFavoritList> {
  // properties
  late int value;
  late DatabaseHandler handler;

  // Location properties
  late List<double> distanceList; // 맛집들과 나의 거리
  late Position currentPosition;
  late int selectedIndexOfLoc;
  late double latData;
  late double longData;
  late MapController mapController;
  late bool mapEable;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    value = 0;
    distanceList = [];
    //checkLocationPermission(); // 위치 허용 확인 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handler.queryMustEatPlaces(),
      builder: (context, snapshot) {
        // 순간적인 메모리에 현재 상태 포착
        // snapshot 에 데이터가 없으면 없다. 있으면 있따.
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    Get.to(MyLocation(), arguments: [
                      //선택 장소의 위도 경도
                      snapshot.data![index],
                      snapshot.data![index]
                    ]);
                  },
                  child: Slidable(
                    startActionPane: ActionPane(
                      motion: DrawerMotion(),
                      children: [
                        SlidableAction(
                            backgroundColor: Color.fromARGB(255, 97, 148, 189),
                            icon: Icons.delete,
                            label: '수정',
                            onPressed: (context) {
                              Get.to(() => const UpdateMustEatPlace(),
                                      arguments: [snapshot.data![index]])!
                                  .then((value) {
                                reloadData();
                                setState(() {});
                              });
                            })
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: BehindMotion(),
                      children: [
                        SlidableAction(
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: '삭제',
                            onPressed: (context) {
                              selectDelete(index, snapshot.data![index].seq);
                            } //=> selectDelete(index)

                            )
                      ],
                    ),
                    child: SizedBox(
                      height: 150,
                      child: Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  height: MediaQuery.of(context).size.height / 13,
                                  child: Image.memory(
                                    snapshot.data![index].image,
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '장소 : ${snapshot.data![index].name.trim()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //Text()
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '전화 : ${snapshot.data![index].phone.trim().toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    //Text()
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     FutureBuilder<double>(
                                      future : 
                                      calculateDistance(
                                        snapshot.data![index].lat,
                                        snapshot.data![index].lng
                                      ),
                                      builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.done) {
                                        return Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '거리 : ${snapshot.data!.toStringAsFixed(2)} km',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                      }
                                    ),
                                    //Text(snapshot.data![index].phone.trim())
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          print(handler.queryMustEatPlaces());
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator(), Text("")],
            ),
          );
        }
      },
    );
  }

// --- Functions ---
  reloadData() {
    handler.queryMustEatPlaces();
    print("query executed!!!");
    setState(() {});
  }

  selectDelete(index, seq) {
    showCupertinoModalPopup(
      barrierDismissible: false,
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          "경고 ",
        ),
        message: const Text("선택한 항목을 삭제 하시겠습니까?"),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () async {
                //
                //data.removeAt(index);
                await handler.deleteMustEatPlaces(seq);
                setState(() {});
                Get.back();
              },
              child: const Text("삭제"))
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
      ),
    );
  }

// 현재 위치와 장소의 거리를 계산하여 반환하는 함수
  Future<double> calculateDistance(double lat, double lng) async {
    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );

    double distanceInMeters = await Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      lat,
      lng,
    );

    // 거리를 킬로미터 단위로 변환하여 반환
    return distanceInMeters / 1000;
  }
} // End
