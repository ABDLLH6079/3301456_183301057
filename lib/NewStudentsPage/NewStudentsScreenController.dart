import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewStudentsScreenController extends GetxController{
  var tftarih=TextEditingController();
  var tfsaat=TextEditingController();
  var adi=TextEditingController();
  var konu=TextEditingController();
  var ucret=TextEditingController();
  var datePicked,veriDate,veriSaat;
}
class EkleTextField extends StatelessWidget {
  EkleTextField({
    Key key,
    @required this.controller,
    @required this.text,
  }) : super(key: key);

  final TextEditingController controller;
  String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: text,
          prefixIcon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.black45,
          ),
          suffixIcon: Icon(
            Icons.info,
            color: Colors.black45,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.0),
            borderSide: BorderSide(
              color:Colors.red,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.0),
            borderSide: BorderSide(
              color:Colors.red,
            ),
          ),
          hintText: text,
        ),
      ),
    );
  }
}
