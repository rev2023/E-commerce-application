import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors{
  static const Color backgroundColor = Colors.white;
  static const Color primaryColor = Colors.black87;
  static const Color secondaryColor =Color(0xFF2E5767);
  static const Color nikeOrange = Color(0xFFFF6F00);
  static const Color pumaRed =  Color(0xFFE11C2B);
  static const Color grey =  Colors.grey;
  static const Color green =  Colors.green;
  static const Color offWhite = Colors.white60;

  static Color parseColor(String colorName) {
    final Map<String, Color> colorMap = {
      'black': Colors.black,
      'white': Colors.white,
      'red': Colors.red,
      'pink': Colors.pink,
      'purple': Colors.purple,
      'deepPurple': Colors.deepPurple,
      'indigo': Colors.indigo,
      'blue': Colors.blue,
      'lightBlue': Colors.lightBlue,
      'cyan': Colors.cyan,
      'teal': Colors.teal,
      'green': Colors.green,
      'lightGreen': Colors.lightGreen,
      'lime': Colors.lime,
      'yellow': Colors.yellow,
      'amber': Colors.amber,
      'orange': Colors.orange,
      'deepOrange': Colors.deepOrange,
      'brown': Colors.brown,
      'grey': Colors.grey,
      'blueGrey': Colors.blueGrey,
    };
    return colorMap[colorName.toLowerCase()] ?? Colors.black; // Default to black if color is not found
  }
}