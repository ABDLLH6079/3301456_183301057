import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ogrenci_takip/ForgetPassPage/ForgotPassScreen.dart';
import '../SignUpPage/SignUpPageScreen.dart';
import 'LoginPageScreenController.dart';

class LoginPageScreen extends StatelessWidget {
  final LoginPageScreenController loginPageScreenController = Get.put(LoginPageScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(58, 66, 86, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "resim/logo.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  TextFormFieldWidget(hint: 'Email', label: 'Email', controller: loginPageScreenController.kullanici, icon: Icon(Icons.email), obsc: false,),
                  TextFormFieldWidget(controller: loginPageScreenController.sifre, hint: 'Şifre', label: 'Şifrenizi Giriniz',icon: Icon(Icons.lock), obsc: true,),
                  TextButton(
                    onPressed: () {
                      Get.to(ForgotPassScreen());
                    },
                    child: const Text(
                      'Şifrenizi mi Unuttunuz? ',style: TextStyle(color: Colors.red),

                    ),
                  ),
                  TextButtonWidget(kullanici: loginPageScreenController.kullanici, sifre: loginPageScreenController.sifre),
                  KayitGirisRow(text: 'Hesabınız Yok Mu', btnText: 'Kayıt Olun', tap: (){
                    Get.to(SignUpPageScreen());
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



