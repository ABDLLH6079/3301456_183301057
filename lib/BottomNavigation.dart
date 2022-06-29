
import 'package:flutter/material.dart';
import 'package:ogrenci_takip/HomePage/HomePageScreen.dart';
import 'InfoScreenPage.dart';
import 'ProfilePageScreen/ProfilePageScreen.dart';


class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}
class _BottomBarScreenState extends State<BottomBarScreen> {
  int secindex=0;
  var list=[HomePageScreen(),InfoScreenPage(),ProfilePageScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[secindex],
      bottomNavigationBar:BottomNavigationBar(
        backgroundColor:Color.fromRGBO(58, 66, 86, 1.0),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.info, color: Colors.white),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box,color: Colors.white,),
              label: ""),
        ],
        currentIndex: secindex,
        selectedItemColor: Colors.red,
        onTap: (index){
          setState(() {
            secindex=index;
          });
        },
      ),

    );
  }
}
