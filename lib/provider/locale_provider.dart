import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {

  Locale _language = const Locale('en');
  String _languageName = 'English';
  String get languageName => _languageName;
  Locale get language => _language;

  LocaleProvider(){
    loadLocale();
  }
  void changeLocale(String locale ){
    _language = Locale(locale);
    _languageName = locale == 'es' ? 'Spanish' : 'English';
    saveLocale();
    notifyListeners();

  }

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveLocale() async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString('locale', _language.languageCode);
    notifyListeners();

  }
  Future<void> loadLocale() async{
    final SharedPreferences prefs = await _prefs;
    String? locale = prefs.getString('locale');
    _language = Locale(locale!);
    _languageName = locale == 'es' ? 'Spanish' : 'English';
    notifyListeners();


  }
  notifyListeners();


}