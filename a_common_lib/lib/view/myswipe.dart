import 'package:flutter/material.dart';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';

/*
 
  Description : SimleGesture package Swipe function implementation 
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    - Stack 을 사용함. 
    - 이미지 깍기 기술 시전.  

*/
class MySwipe extends StatefulWidget {
  const MySwipe({super.key});

  @override
  State<MySwipe> createState() => _MySwipeState();
}

class _MySwipeState extends State<MySwipe> {
  // Properties
  // Image 배열
  late List imageName;

  // Image 현재 번호
  late int currentImage;
  late int _nextPage; // 작은 이미지 .

  @override
  void initState() {
    super.initState();
    imageName = [
      'flower_01.png',
      'flower_02.png',
      'flower_03.png',
      'flower_04.png',
      'flower_05.png',
      'flower_06.png',
    ];

    currentImage = 0; // init 은 처음에 단한번만 실행이 된다.
    _nextPage = currentImage + 1;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleGestureDetector(
      onHorizontalSwipe: (direction) =>
          _onHorizontalSwipe(direction), // di값을 가져가야함.
      onVerticalSwipe: (direction) => _onVerticalSwipe(direction),
      onDoubleTap: () => _onDoubleTap(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(imageName[currentImage]),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'images/flower/${imageName[currentImage]}',
                      width: 300,
                      height: 350,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // 우측 상단 다음 이미지 미리보기
                Positioned(
                    //
                    left: 250,
                    top: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.amber, width: 5)),
                      child: Image.asset(
                        'images/flower/${imageName[_nextPage]}',
                        fit: BoxFit.fill,
                        width: 50,
                        height: 70,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Functions
  _onHorizontalSwipe(direction) {
    // Swiping 을 오른쪽에서 왼쪽으로
    if (direction == SwipeDirection.left) {
      currentImage += 1; // 오른쪽 이동
      if (currentImage >= imageName.length) {
        currentImage = 0;
      }
    } else {
      currentImage -= 1;
      if (currentImage < 0) {
        currentImage = imageName.length - 1;
      }
    }
    setState(() {});
  }

  _onVerticalSwipe(direction) {
    // Swiping 을 아래에서 위로
    if (direction == SwipeDirection.up) {
      currentImage += 1; // 오른쪽 이동
      if (currentImage >= imageName.length) {
        currentImage = 0;
      }
    } else {
      currentImage -= 1;
      if (currentImage < 0) {
        currentImage = imageName.length - 1;
      }
    }
    setState(() {});
  }

  _onDoubleTap() {
    currentImage += 1;
    if (currentImage >= imageName.length) {
      currentImage = 0;
    }
    setState(() {});
  }
} //End
