import 'package:flutter/material.dart';
class InfoScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Hakkımızda"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:50.0,left: 20.0,right: 20.0),
                child: Center(
                  child: Text("",style: TextStyle(
                      fontSize: 18
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:40.0),
                child: Image.asset("resim/hak.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
