import 'package:flutter/cupertino.dart'; // For iOS
import 'package:flutter/material.dart'; // For iOS
import 'package:flutter/services.dart'; // For platform-specific code
import 'package:shared_preferences/shared_preferences.dart';

// Function to store the FCM token locally
Future<void> storeFCMToken(String token) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcm_token', token);
  } on PlatformException catch (e) {
    // Handle error, if any
    debugPrint("Failed to store FCM token: ${e.message}");
  }
}
Future<bool> isTokenPresent() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('fcm_token') != null ? true : false;
}

// Function to retrieve the stored FCM token
Future<String?> getStoredFCMToken() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  } on PlatformException catch (e) {
    // Handle error, if any
    debugPrint("Failed to get FCM token: ${e.message}");
    return null;
  }
}
