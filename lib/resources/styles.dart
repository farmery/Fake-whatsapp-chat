import 'package:flutter/material.dart';

class TextStyles {
  TextStyle body =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle subtitle1 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.65));
  TextStyle subtitle2 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Colors.white.withOpacity(0.5));
  TextStyle title =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle largeText =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle tileTitle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  TextStyle unSelectedTabText = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(0.40));
  TextStyle unSelectedNavText = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white.withOpacity(0.40));
  TextStyle selectedNavText = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.purpleAccent);
}
