import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Function to set the user after successful authentication
  void setUser(User user) {
    _user = user;
    notifyListeners(); // Notify listeners to rebuild UI when user changes
  }

  // Function to sign out the user
  void signOut() async {
    await FirebaseAuth.instance.signOut();
    _user = null;
    notifyListeners();
  }
}
