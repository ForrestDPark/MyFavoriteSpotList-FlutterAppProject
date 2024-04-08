import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  final TabController tabController ;
  final ColorScheme tabColorscheme;
  const MyTabBar({super.key, required this.tabController, required this.tabColorscheme});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with SingleTickerProviderStateMixin {
  //Properties tap controller
  late TabController controller;
  
    @override
  void initState() {
    // 상속을 안받으면 this 를 쓸수 없다. .
    // implement 가 있어야하는데 dart 는 with 를쓰면 두개까지 상속이 된다.
    // tab bar -> SingleTickerProviderStateMixin
    super.initState();
    controller = widget.tabController;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        // container 는 w,h,c 가능
        height: 80,
        color: widget.tabColorscheme.tertiaryContainer,

        child: TabBar(
          controller: controller,
          labelColor: widget.tabColorscheme.onTertiaryContainer,
          indicatorColor: Colors.red,
          //indicatorWeight: 5,
          tabs: const [
            Tab(
              icon: Icon(Icons.looks_one_outlined),
              text: "SQLite",
            ),
            Tab(
              icon: Icon(Icons.looks_two_outlined),
              text: "FireBase",
            ),
            Tab(
              icon: Icon(Icons.looks_3_outlined),
              text: "MySQL",
            )

          ],
        ),
      );
  }
}