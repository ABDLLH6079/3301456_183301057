import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:ogrenci_takip/DetailStudentsPage/DetailStudentsScreen.dart';
import 'package:ogrenci_takip/HomePage/HomePageScreenController.dart';
import 'package:ogrenci_takip/LoginPage/LoginPageScreen.dart';

class HomePageScreen extends StatelessWidget {
  final HomePageScreenController homePageScreenController = Get.put(HomePageScreenController());

  @override
  Widget build(BuildContext context) {
    var ogrID = FirebaseAuth.instance.currentUser.uid;
    return Scaffold(
      key: homePageScreenController.scaffoldKey,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Öğrencilerim"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Get.off(LoginPageScreen());
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('ögrenci').where("ogrID", isEqualTo: ogrID).snapshots(includeMetadataChanges: true),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata Var'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              print(document.id);
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              data.addAll({"docİd":document.id});
              return Slidable(
                  endActionPane: ActionPane(
                  motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),
                children:[
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      FirebaseFirestore.instance.collection('ögrenci').doc(data["docİd"]).delete().then((value){
                        Get.snackbar("Başarılı", "Kullanıcı Silme İşlemi Tamamlandı");
                      }).
                      catchError((error){
                        Get.snackbar("Başarısız", "Kullanıcı Silme İşlemi Başarılı Olmadı");
                      });
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Sil',
                  ),
                ],
              ),
                child: Card(
                  elevation: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(64, 75, 96, .9)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: CircleAvatar(child: Image.asset("resim/list.png")),
                      ),
                      title: Center(
                        child: Text(
                          "Öğrenci Adı:" + data["ögrAd"].toString()+"",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Saat:" + data["saat"].toString(),
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            "Tarih: " + data["tarih"].toString(),
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(DetailPage(data: data,));
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
