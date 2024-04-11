import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_enter_app/model/musteatplace_firebase.dart';
import 'package:keyboard_enter_app/view/firebasecrud/udatefirebase.dart';

class MyFavoritList_firebase extends StatefulWidget {
  const MyFavoritList_firebase({super.key});

  @override
  State<MyFavoritList_firebase> createState() => _MyFavoritList_firebaseState();
}

class _MyFavoritList_firebaseState extends State<MyFavoritList_firebase> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          // 메모리 스냅샷 찍어서 검색해온것 .
          stream: FirebaseFirestore.instance
              .collection('musteatplace')
              // .orderBy("code", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final documents = snapshot.data!.docs;
            print("도달");
            return ListView(
              children: documents.map((e) => _buildItemWidget(e)).toList(),
            );
          },
        ),
    );
  }
  Widget _buildItemWidget(doc) {
    print("ehekf");
    //데이터를 맵형식으로 들어온것을 맵으로 쓰려고함
    final musteatplace = MustEatPlacesFirebase(
        name: doc['name'],
        phone: doc['phone'],
        lat: doc['lat'],
        lng: doc['lng'],
        image: doc['image'],
        estimate: doc['estimate'],
        initdate: doc['initdate']);
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_forever),
      ),
      key: ValueKey(doc),
      onDismissed: (direction) async{
        FirebaseFirestore.instance.collection('musteatplace')
        .doc(doc.id)
        .delete();
        await deleteImage(musteatplace.name);
      },
      child: GestureDetector(
        onTap: () => Get.to(const UpdateFirebase(), arguments: [
          doc.id, // 선언한적도 없는데 도 문서의 id로 적용
          doc['name'],
          doc['phone'],
          doc['lat'],
          doc['lng'],
          doc['image'],
          doc['estimate'],
          doc['initdate'],
        ]),
        child: Card(
          child: ListTile(
            title: Row(
              children: [
                Image.network(
                  musteatplace.image,
                  width: 70,
                ),
                Text(
                  ''' 
                  장소: ${musteatplace.name} \n\n
                  전화번호 : ${musteatplace.phone}''',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }//
  deleteImage(deleteName) async{
    final firebaseStorage = FirebaseStorage.instance
        .ref().child('images').child('$deleteName.png');
    await firebaseStorage.delete();

  }
}