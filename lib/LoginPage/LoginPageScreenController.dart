import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ogrenci_takip/BottomNavigation.dart';
class LoginPageScreenController extends GetxController{

  var kullanici=TextEditingController();
  var sifre=TextEditingController();

}
class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key key,
    @required this.kullanici,
    @required this.sifre,
  }) : super(key: key);

  final TextEditingController kullanici;
  final TextEditingController sifre;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: (() async {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: kullanici.text,
              password: sifre.text
          );
          Get.off(BottomBarScreen());
          Get.snackbar("Giriş", "Giriş Yaptınız");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            Get.snackbar("Hata", "Kullanıcı Bulunamadı");
          } else if (e.code == 'wrong-password') {
            Get.snackbar("Hata", "Lütfen Kullanıcı Adınızı veya Şifrenizi Kontrol Edin.");
          }
        }
      }),
      icon: const Icon(Icons.login),
      label: Container(
        alignment: Alignment.center,
        width: 150,
        height: 35,
        child: const Text(
          'Giriş Yap',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
class KayitGirisRow extends StatelessWidget {

  KayitGirisRow({@required this.text, @required this.btnText,@required this.tap});
  String text,btnText;
  void Function() tap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Text(text,style: TextStyle(color: Colors.red),),
        TextButton(
          onPressed:tap,
          child: Text(
            btnText,
            style: TextStyle(
              fontSize: 15,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

}
class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    Key key,
    @required this.icon,
    @required this.controller,
    @required this.hint,
    @required this.label,
    @required this.obsc,
  }) : super(key: key);

  final TextEditingController controller;
  String hint,label;
  Icon icon;
  bool obsc;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsc,
      decoration: InputDecoration(
        icon:icon,
        hintText: hint,
        labelText: label,
      ),
    );
  }
}