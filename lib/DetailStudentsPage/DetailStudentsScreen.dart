import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ogrenci_takip/DetailStudentsPage/DetailStudentsController.dart';
import 'package:ogrenci_takip/HomePage/HomePageScreen.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../NewStudentsPage/NewStudentsScreenController.dart';

class DetailPage extends StatelessWidget {
  Map<String, dynamic> data;
  DetailPage({Key key, this.data}) : super(key: key);

  DetailStudentsController detailStudentsController=Get.put(DetailStudentsController());
  @override
  Widget build(BuildContext context) {
    final topContent = Stack(
      children: [
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://creazilla-store.fra1.digitaloceanspaces.com/cliparts/35513/blackboard-professor-clipart-md.png"),
                fit: BoxFit.contain,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.525,
          padding: EdgeInsets.all(30.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black26),
          child: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120.0),
                  Icon(
                    Icons.play_lesson,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  Container(
                    width: 90.0,
                    child: Divider(color: Colors.green),
                  ),
                  SizedBox(height: 25.0),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.284, top: 10),
                    child: Text(
                      data["ögrAd"].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontFamily: "Raleway",
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 8,
                          child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                data["tarih"].toString() +
                                    "\n" +
                                    "Ders Saati: " +
                                    data["saat"].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Raleway",
                                    fontSize: 16),
                              ))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child:Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        "Ders Ücreti: " + "₺" + data["ücret"].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Raleway",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );
    final bottomContent = Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.34,
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            vertical: 7.0,
            horizontal: 7.0,
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white60)
          ),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Ödeme Durumu: ',
                      style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontSize: 17,fontWeight: FontWeight.w800),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ToggleSwitch(
                          minWidth: 90.0,
                          cornerRadius: 20.0,
                          activeBgColors: [[Colors.green[800]], [Colors.red[800]]],
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex:data["ödeme"],
                          totalSwitches: 2,
                          labels: ['Yapıldı', 'Yapılmadı'],
                          radiusStyle: true,
                          onToggle: (index) {
                            detailStudentsController.odeme=index;
                            print('switched to: $index');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Konu: ',
                      style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontSize: 18,fontWeight: FontWeight.w800),),
                    SizedBox(width: 15,),
                    Text(data["konu"], style: TextStyle(color: Colors.white, fontFamily: "Raleway", fontSize: 18,fontWeight: FontWeight.w800),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                    onTap: ()async{
                      detailStudentsController.datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        initialDate: DateTime(DateTime.now().year),
                        firstDate: DateTime(DateTime.now().year-5),
                        lastDate: DateTime(DateTime.now().year+10),
                        dateFormat: "dd/MMM/yyyy",
                        locale: DateTimePickerLocale.tr,
                        looping: false,
                      );
                      final String date = DateFormat('dd-MM-yyyy').format(detailStudentsController.datePicked).toString();
                      detailStudentsController.veriDate=DateFormat.yMMMMEEEEd("tr_TR").format(detailStudentsController.datePicked);
                      detailStudentsController.tftarih.text=detailStudentsController.veriDate;
                    },
                    child: IgnorePointer(child: EkleTextField(controller: detailStudentsController.tftarih, text: "Tarihi Değiştir: ${data["tarih"]}"))),
              ),
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
                      detailStudentsController.veriSaat = DateFormat.Hm().format(result);
                      detailStudentsController.tfsaat.text=detailStudentsController.veriSaat;
                    }
                  },
                  child: IgnorePointer(child: EkleTextField(controller: detailStudentsController.tfsaat, text: "Saati Değiştir: ${data["saat"]}"))),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: Column(
        children: [
          topContent,
          Divider(
            color: Colors.white,
          ),
          bottomContent,
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {
                if(detailStudentsController.tfsaat.text.isNotEmpty){
                  FirebaseFirestore.instance.collection('ögrenci').doc(data["docİd"]).update({
                    "saat":detailStudentsController.veriSaat,
                  }).then((value){
                    Get.snackbar("Başarılı", "Bilgiler Başarıyla Güncellendi");
                    detailStudentsController.tfsaat.clear();
                    Get.off(HomePageScreen());
                  }).catchError((onError){
                    Get.snackbar("Başarısız", "Bilgiler Güncellenmedi: $onError");
                  });
                }
                if(detailStudentsController.tftarih.text.isNotEmpty){
                  FirebaseFirestore.instance.collection('ögrenci').doc(data["docİd"]).update({
                    "tarih":detailStudentsController.veriDate,
                  }).then((value){
                    Get.snackbar("Başarılı", "Bilgiler Başarıyla Güncellendi");
                    Get.off(HomePageScreen());
                  }).catchError((onError){
                    Get.snackbar("Başarısız", "Bilgiler Güncellenmedi: $onError");
                  });
                }
                if(detailStudentsController.odeme!=null){
                  FirebaseFirestore.instance.collection('ögrenci').doc(data["docİd"]).update({
                    "ödeme":detailStudentsController.odeme,
                  }).then((value){
                    Get.snackbar("Başarılı", "Bilgiler Başarıyla Güncellendi");
                    Get.off(HomePageScreen());
                  }).catchError((onError){
                    Get.snackbar("Başarısız", "Bilgiler Güncellenmedi: $onError");
                  });
                }
              },
              child: Text('Bilgileri Güncelle'),
              style: ElevatedButton.styleFrom(
                primary: Colors.black45,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
