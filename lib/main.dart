import 'package:flutter/material.dart';
import 'package:imagenes/home.dart';
import 'package:imagenes/imagen_page.dart';
import 'package:imagenes/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imagenes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context)=>HomePage(),
        'imanen':(BuildContext context)=>ImagenPage(),
        'login':(BuildContext context)=>LoginPage(),
      },
    );
  }
}
