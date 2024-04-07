
import 'package:flutter/material.dart';
/*
 
  Description : List view 
  Date        : 2024.04.07 Sun
  Author      : Forrest DongGeun Park. (PDG)
  Updates     : 2024.04.07 Sun
  Detail      : 
    -Litview  

*/
class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  // Properties
  late List<int> todoList;
  late List<String> todoList2;
  @override
  void initState() {
    super.initState();
    todoList = [];
    todoList2 =[];
    addData();
  }

  addData() {
    for (int i = 1; i <= 1000; i++) {
      todoList.add(i);
      //print(i);
    }
    todoList2.add("Forrest");
    todoList2.add("유비");
    todoList2.add("관우");
    todoList2.add("장비");
    todoList2.add("조조");
    todoList2.add("마초");
    todoList2.add("황충");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main View"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: todoList2.length,
          itemBuilder: (context, index) {
            return
            SizedBox(
              height: 100,
              child: Card( // Builder 는 항상 return 이 있어야한다. 
              color: Colors.yellow,
                child: Center(
                  child: Text(
                    todoList2[index].toString(),
                    style: const TextStyle(
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  //
} // End
