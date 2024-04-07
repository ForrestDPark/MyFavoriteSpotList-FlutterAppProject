import 'package:flutter/material.dart';
import '../sharevar/sharevar.dart';

class AddHero extends StatefulWidget {
  const AddHero({super.key});

  @override
  State<AddHero> createState() => _AddHeroState();
}

class _AddHeroState extends State<AddHero> {
  // properties
  late TextEditingController tfcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tfcontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("인물 추가"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                controller: tfcontroller,
                maxLines: 1,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: '이름을 입력하세요',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                onPressed: () {
                  ShareVar.heroName = tfcontroller.text;
                  Navigator.of(context).pop();
                },
                child: const Text("추가"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
