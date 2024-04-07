import 'package:flutter/material.dart';
import '../sharevar/sharevar.dart';

class DetailHero extends StatelessWidget {
  const DetailHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("인물 보기"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ShareVar.selectedHero)
          ],
        ),
      ),
    );
  }
}