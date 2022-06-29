import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:ogrenci_takip/BottomNavigation.dart';
import 'package:ogrenci_takip/NewStudentsPage/NewStudentsScreenController.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
class OgrenciEkle extends StatelessWidget {

  final NewStudentsScreenController newStudentsScreenController = Get.put(NewStudentsScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Öğrenci Ekle"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width*0.20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EkleTextField(controller: newStudentsScreenController.adi, text: 'İsim Soyisim',),
                InkWell(
                    onTap: () async {
                      final result = await TimePicker.show<DateTime>(
                        context: context,
                        sheet: TimePickerSheet(
                          sheetTitle: 'Saati Seç',
                          minuteTitle: 'Dakika',
                          hourTitle: 'Saat',
                          saveButtonText: 'Kaydet',
                        ),
                      );
                      if (result != null) {
                        newStudentsScreenController.veriSaat = DateFormat.Hm().format(result);
                        newStudentsScreenController.tfsaat.text=newStudentsScreenController.veriSaat;
                      }
                    },
                    child: IgnorePointer(child: EkleTextField(controller: newStudentsScreenController.tfsaat, text: "Ders Saati"))),
                EkleTextField(controller: newStudentsScreenController.konu,text:'Konu',),
                EkleTextField(controller: newStudentsScreenController.ucret, text: "Ücret"),
                InkWell(
                    onTap: ()async{
                      newStudentsScreenController.datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime(DateTime.now().year),
                        firstDate: DateTime(DateTime.now().year-5),
                        lastDate: DateTime(DateTime.now().year+10),
                        dateFormat: "dd/MMM/yyyy",
                        locale: DateTimePickerLocale.tr,
                        looping: false,
                      );
                      final String date = DateFormat('dd-MM-yyyy').format(newStudentsScreenController.datePicked).toString();
                      newStudentsScreenController.veriDate=DateFormat.yMMMMEEEEd("tr_TR").format(newStudentsScreenController.datePicked);
                      newStudentsScreenController.tftarih.text=date.toString();
                    },
                    child: IgnorePointer(child: EkleTextField(controller: newStudentsScreenController.tftarih, text: "Tarih"))),
                Container(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: (){
                      CollectionReference users = FirebaseFirestore.instance.collection('ögrenci');
                      users.doc().set({
                        "ögrAd":newStudentsScreenController.adi.text,
                        "ogrID":FirebaseAuth.instance.currentUser.uid,
                        "saat":newStudentsScreenController.veriSaat,
                        "tarih":newStudentsScreenController.veriDate,
                        "ücret":newStudentsScreenController.ucret.text,
                        "konu":newStudentsScreenController.konu.text,
                        "ödeme":1,
                      });

                      Get.snackbar("Başarılı", "Öğrenci Başarıyla Eklendi");
                      Get.to(BottomBarScreen());
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
      ),
    );
  }

}

