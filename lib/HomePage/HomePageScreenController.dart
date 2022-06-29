
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HomePageScreenController extends GetxController{
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var tfcontrol=TextEditingController();
  var odeme;
  final makeCard = Card(
    elevation: 8.0,
    margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: const BoxDecoration(color:  Color.fromRGBO(64, 75, 96, .9)),
      child:  ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border:Border(
                    right:BorderSide(width: 1.0, color: Colors.white24))),
            child: const Icon(Icons.autorenew, color: Colors.white),
          ),
          title: const Text(
            "Tutanak Dosyası",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children:const [
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(" Tutanak Dosyası", style: TextStyle(color: Colors.white))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)),
    ),
  );


}