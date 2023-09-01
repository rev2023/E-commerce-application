import 'package:auto_route/auto_route.dart';
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
      body: Consumer<LocaleProvider>(
        builder: (context, preference, child) {
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.pop();
                        },
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.person,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
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
            ),
          );
        },
      ),
    );
  }
}
