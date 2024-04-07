import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_enter_app/view/mylocation.dart';
import '../vm/musteatplace_db_handler.dart';
import 'musteatplace/update_place.dart';

class MyFavoritList extends StatefulWidget {
  const MyFavoritList({super.key});

  @override
  State<MyFavoritList> createState() => _MyFavoritListState();
}

class _MyFavoritListState extends State<MyFavoritList> {
  // properties
  late int value;
  late DatabaseHandler handler;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    value = 0;
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
                    //queryResults[0]['seq']
                    //print('선택된 항목 : ${snapshot.data![index].seq}');

                    Get.to(MyLocation(), 
                    arguments: [
                      snapshot.data![index].lat,
                      snapshot.data![index].lng,
                      ]);
                    }
                    
                ,
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
                            } 
                            )
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
                      height: 80,
                      child: Card(
                        child: Row(
                          children: [
                            ClipRRect(
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 70, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '  Place : ${snapshot.data![index].name.trim()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //Text()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 130, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        ' Phone : ${snapshot.data![index].phone.trim().toString()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //Text()
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 100, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        ' Distance : 3 km',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //Text(snapshot.data![index].phone.trim())
                                    ],
                                  ),
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
}
