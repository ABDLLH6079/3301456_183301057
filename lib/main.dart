import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ogrenci_takip/BottomNavigation.dart';
import 'package:ogrenci_takip/LoginPage/LoginPageScreen.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('tr', 'TR'),
    ],
    title: 'Öğenci Takip Sistemi',
    theme: ThemeData(
      primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      brightness: Brightness.dark,
    ),
    home: MyApp(),
  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return Scaffold(
        body: BottomBarScreen(),
      );
    }
    else {
      return Scaffold(
        body: LoginPageScreen(),
      );
    }
  }
}







