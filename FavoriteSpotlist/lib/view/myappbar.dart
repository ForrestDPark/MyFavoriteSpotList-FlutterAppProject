import 'package:flutter/material.dart';

class MyappBar extends StatelessWidget {
  const MyappBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "App Bar Icon",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.email)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.alarm)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_outlined)),
        GestureDetector(
          onTap: () {
            //print("smile image is tapped");
          },
          child: Image.asset(
            "images/smile.png",
            width: 50,
          ),
        ),
      ],
      backgroundColor: Colors.amber,
      toolbarHeight: 200,
      toolbarOpacity: 0.5,
    );
  }
}
