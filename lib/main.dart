import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kisan_setu/Screens/Login_page.dart';
import 'package:kisan_setu/Screens/homescreeen.dart';

import 'package:kisan_setu/Screens/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kisan Setu App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),     home: SplashScreen(),
    );
  }
}
