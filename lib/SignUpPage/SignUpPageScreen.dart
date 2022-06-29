import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:ogrenci_takip/LoginPage/LoginPageScreen.dart';
import '../LoginPage/LoginPageScreenController.dart';
import 'SignUpPageScreenController.dart';
import 'package:path_provider/path_provider.dart';
class SignUpPageScreen extends StatelessWidget {
  final SignUpPageScreenController screenController = Get.put(SignUpPageScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'resim/logo.png',
              fit: BoxFit.cover,
              height: 300,
              width: 350,
            ),
            const SizedBox(
              height: 20,
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  TextFormFieldWidget(hint: 'Adınız-Soyadınız', label: 'Ad-Soyad', controller: screenController.adi, icon: Icon(Icons.person), obsc: false,),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextFormFieldWidget(hint: 'Email Adresiniz', label: 'Email', controller: screenController.mail, icon: Icon(Icons.email), obsc: false,),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextFormFieldWidget(hint: 'Şifrenizi Giriniz', label: 'Şifre', controller: screenController.sifre, icon: Icon(Icons.lock), obsc: true,),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
                  TextButton.icon(
                    onPressed: (() async {
                      Directory tempDir = await getTemporaryDirectory();
                      String tempPath = tempDir.path;
                      try {
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: screenController.mail.text,
                            password:screenController.sifre.text
                        );
                        CollectionReference users = FirebaseFirestore.instance.collection('ögretmen');
                        users.doc(FirebaseAuth.instance.currentUser.uid).set({
                          "isim":screenController.adi.text,
                          "ogrID":FirebaseAuth.instance.currentUser.uid,
                          "mail":screenController.mail.text,
                        });
                        var box = await Hive.openBox('box');
                        box.put('ögrİsim', screenController.adi.text);
                        print(box.get('ögrİsim'));
                        Get.to(LoginPageScreen());
                        Get.snackbar("Başarılı","Kayıt Başarıyla Tamamlandı");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          Get.snackbar("Hatalı Giriş","Şifreniz 6 Haneli Olmalıdır");
                        } else if (e.code == 'email-already-in-use') {
                          Get.snackbar("Hatalı Giriş","Bu Mail Adresi Zaten Kayıtlı");
                        }
                      }
                    }),
                    icon: const Icon(Icons.create),
                    label: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 35,
                      child: const Text(
                        'Kayıt Ol',
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
                  ),
                    KayitGirisRow(text: "Kayıtlı Hesabınız Var Mı?", btnText: "Giriş Yap", tap: () {
                      Get.to(LoginPageScreen());
                    },),
                  const Text(
                    'Kaydolarak şartlar, koşullar ve gizlilik Politikamızı kabul etmiş olursunuz.',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

