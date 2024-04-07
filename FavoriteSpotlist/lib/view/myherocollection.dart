import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_enter_app/view/%08hero/add_hero.dart';
import 'package:keyboard_enter_app/view/%08hero/detail_hero.dart';
import 'sharevar/sharevar.dart';

class MyHeros extends StatefulWidget {
  const MyHeros({super.key});

  @override
  State<MyHeros> createState() => _MyHerosState();
}

class _MyHerosState extends State<MyHeros> {
  //properties
  late List<String> heroList;
  late int _selected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selected = 0;
    heroList = [
      '유비',
      '관우',
      '장비',
      '조조',
      '조비',
      '손권',
      '주유',
      '육손',
      '사마의',
      '태사자',
      '조운',
      '서서',
      '방통',
      '마량',
      '마속',
      '제갈량',
      '왕평',
      '장합',
      '하후돈',
      '허저',
      '전위',
      '순욱',
      '순유',
      '유선',
      '유장',
      '호차아',
      '가후',
      '하후돈',
      '하후연',
      '노식',
      '심배',
      '노숙',
      '사마사',
      '사마가',
      '마초',
      '마등',
      '방덕',
      '주연',
      '조비',
      '원담',
      '원상',
      '원술',
      '한복',
      '황충',
      '이순신',
      '주몽',
      '김좌진',
      '김구',
      '알렉산더',
      '스탈린',
      '모택동',
      '레닌',
      '징키스칸',
      '나폴레옹',
      '마오쩌둥',
      '이토히로부미',
      '안중근',
      '손흥민',
      '가토 기요마사',
      '도요토미 히데요시',
      '오다 노부나가',
      '도쿠가와 이에야스',
      '다케다 신겐',
      '단군할아버지',
      '동명왕',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("삼국지 인물"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => Get.to(const AddHero())!
                    .then((value) => addData()),
                icon: Icon(Icons.add)),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: heroList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              ShareVar.selectedHero = heroList[index];
              Get.to(DetailHero());
            },
            child: Container(
              color: Colors.red,
              child: Card(
                color: Colors.yellow,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          ShareVar.selectedHero = heroList[index];
                          Get.to(DetailHero());
                        },
                        child: Text(heroList[index]))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function
  addData() {
    heroList.add(ShareVar.heroName);
    setState(() {});
  }
}// End
