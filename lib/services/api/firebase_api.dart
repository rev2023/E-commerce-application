import 'package:firebase_messaging/firebase_messaging.dart';

import '../fcm_service.dart';

class FirebaseAPI{

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications()async{
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    storeFCMToken(fcmToken!);
    print(fcmToken);

  }
}