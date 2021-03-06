import 'package:flutter/material.dart';

class Themes{
  static const Color darkColor=Color.fromRGBO(18, 18, 18, 1);
  static const Color lightColor=Color(0xFFFFB746);
  static const Color blue=Color(0xFF4e5ae8);
  static final light=ThemeData(
        primarySwatch:Colors.blue,
        brightness: Brightness.light
      );
  
  static final dark=ThemeData(
        primaryColor: Colors.grey[900],
        brightness: Brightness.dark
      );
}