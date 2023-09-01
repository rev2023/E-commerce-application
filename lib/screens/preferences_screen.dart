import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:e_commerce_application/provider/locale_provider.dart';
import 'package:e_commerce_application/styles/app_colors.dart';

class PreferencesScreen extends StatelessWidget {
   PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? dropdownValue = Provider.of<LocaleProvider>(context).languageName == 'English' ? AppLocalizations.of(context)!.english : AppLocalizations.of(context)!.spanish;
    List<String> languageList = [AppLocalizations.of(context)!.english, AppLocalizations.of(context)!.spanish];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black87,
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Consumer<LocaleProvider>(
        builder: (context, preference, child) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text(AppLocalizations.of(context)!.ourBrands),

                trailing: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: (String? value) {
                      dropdownValue = value;
                    // Create a new Locale with the selected language code and update the locale
                    preference.changeLocale(value == AppLocalizations.of(context)!.spanish ? 'es' : 'en');
                    preference.saveLocale();
                  },
                  items: languageList.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
