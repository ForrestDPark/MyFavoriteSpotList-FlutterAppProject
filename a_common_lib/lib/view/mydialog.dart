import 'package:flutter/material.dart';

/*
 
  Description :  Dialog ( Get 방식 이전..)
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    - Get dialog 를 쓰지 못할때 ? 사용 .. 

*/
class MyDialogue extends StatelessWidget {
  const MyDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDialog(context), //  _underbar 가 있으면 변수도 함수도 private 이다.
      child: Text("hello world"),
    );
  }

// -------Functions
  _showDialog(BuildContext context) {
    // 기존화면의 메모리를 가져온다.
    showDialog(
      context: context, // memory
      //barrierDismissible: false,
      builder: (BuildContext ctx) {
        //ctx 는 나중에 올 메모리  빌드가 가지고 있는 함수라 대문자.
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          //foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
          title:  Text(
            "Alert title",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer
            ),
          ),
          content: Text(
            "Hello World 를 \ntouch 했습니다. ",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer
            ),
          ),
          //const Text(),
          actions: [
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor:
                        Theme.of(context).colorScheme.onSecondaryContainer,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer),
                onPressed: () =>
                    Navigator.of(ctx).pop(), //같은 화면일때는 context 가 다르면 of 쓰는게 좋다.
                child: const Text("종료"),
              ),
            )
          ],
        );
      },
    );
  }
} // End
