import 'package:flutter/cupertino.dart';
import 'package:e_commerce_application/models/product.dart';
import 'package:e_commerce_application/db/cart_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _language = const Locale('en');
  Locale get language => _language;

  set changeLocale(String locale ){
    _language = Locale(locale);
  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLocale() async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString('locale', language.languageCode);
  }
  Future<void> loadLocale() async{
    final SharedPreferences prefs = await _prefs;
    _language = Locale(prefs.getString('locale')!);
  }


}