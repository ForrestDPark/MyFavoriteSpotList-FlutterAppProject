import 'package:flutter/material.dart';

class AfterLogin extends StatelessWidget {
  // Field
  final String Id; 
  const AfterLogin({super.key,required this.Id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(" $Id 님! 환영합니다. "),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        
      ),

      backgroundColor: Colors.black,
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage("images/coin.png"),
          radius: 100,
        )
      ),
    );
  }
}