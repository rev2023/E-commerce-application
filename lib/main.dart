import 'package:e_commerce_application/l10n/l10n.dart';
import 'package:e_commerce_application/provider/cart_provider.dart';
import 'package:e_commerce_application/provider/locale_provider.dart';
import 'package:e_commerce_application/provider/locale_provider.dart';
import 'package:e_commerce_application/provider/locale_provider.dart';
import 'package:e_commerce_application/provider/product_details_screen_provider.dart';
import 'package:e_commerce_application/provider/search_screen_provider.dart';
import 'package:e_commerce_application/provider/selected_screen_provider.dart';
import 'package:e_commerce_application/router/app_router.dart';
import 'package:e_commerce_application/screens/splash_screen.dart';
import 'package:e_commerce_application/services/services_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiProvider(
      // Wrap your MaterialApp.router with MultiProvider
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => SearchScreenProvider()),
        ChangeNotifierProvider(create: (context) => SelectedScreenProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(
            create: (context) => ProductDetailsScreenProvider()),
      ],
      child: Builder(
        builder: (context) {
          final localeProvider = Provider.of<LocaleProvider>(context);
          return MaterialApp.router(
            routerConfig: appRouter.config(),
            supportedLocales: L10n.all,
            localizationsDelegates: const [AppLocalizations.delegate, GlobalMaterialLocalizations.delegate,GlobalCupertinoLocalizations.delegate ],
            locale: localeProvider.language,
            title: 'Sport Up',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          );
        }
      ),
    );
  }
}
