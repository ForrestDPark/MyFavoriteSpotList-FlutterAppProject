import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_enter_app/view/home.dart';
import 'package:keyboard_enter_app/view/myflower.dart';
import 'myherocollection.dart';
import 'mylogin.dart';

/*
 
  Description :  My drawer
  Date        : 2024.03.22
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.06 Sun
  Detail      : 
    - drawer 에 대한 모든 버전 여기에! 

*/

class MyDrawer extends StatefulWidget {
  final ColorScheme drawerColorScheme;
  const MyDrawer({super.key , required this.drawerColorScheme});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/profile.png"),
            ),
            // otherAccountsPictures: [
            //   CircleAvatar(
            //     backgroundImage: AssetImage("images/pocketmon/p2.png"),
            //   ),
            //   CircleAvatar(
            //     backgroundImage: AssetImage("images/pocketmon/p3.png"),
            //   )
            // ],
            accountName: Text('Forrest Park'),
            accountEmail: Text('pulpilisory@gmail.com'),
            decoration: BoxDecoration(
                color: widget.drawerColorScheme.primary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text("Home"),
            onTap: ()=> Get.to(const Home()),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text("로그인"),
            onTap: () {
              Get.to(const MyLogin());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.tour  ,
              color: Colors.red,
            ),
            title: Text("추천 관광명소"),
            onTap: () {
              Get.to(const MyHeros());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.turned_in_not_rounded,
              color: Colors.blue,
            ),
            title: Text("추천 맛집 "),
            onTap: () {
              Get.to(const MyFlower());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text("로그아웃"),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }
}
