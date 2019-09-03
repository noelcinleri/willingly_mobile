import 'package:flutter/material.dart';
import 'package:willingly/HomePage.dart';

void main() => runApp(MyApp());
num bagisSayisi;
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/firstLogin':(context) => FirstLogin(),
      },
    );
  }
}




