
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../NewStudentsPage/NewStudentsPageScreen.dart';

class ProfilePageScreen extends StatefulWidget {
  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  var isim;
  void initState(){
    super.initState();
    getName();
    print("S");

  }
  void getName()async{
    var box = await Hive.openBox('box');
    setState(() {
      isim=box.get("ögrİsim");
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Profil Bilgilerim"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height:320,
                child: Image.asset("resim/logo.png"),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: Text("Hoşgeldiniz, $isim",style: TextStyle(
                    fontSize: 25,fontWeight: FontWeight.w400
                ),),
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: (){
                    Get.to(OgrenciEkle());
                  },
                  child: Text('Öğrenci Ekle'),
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
