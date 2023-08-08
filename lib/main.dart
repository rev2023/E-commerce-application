import 'package:e_commerce_application/provider/search_screen_provider.dart';
import 'package:e_commerce_application/router/app_router.dart';
import 'package:e_commerce_application/screens/splash_screen.dart';
import 'package:e_commerce_application/services/services_configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
   setupDependencies();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiProvider( // Wrap your MaterialApp.router with MultiProvider
      providers: [
        ChangeNotifierProvider(create: (context) => SearchScreenProvider()), // Provide the SearchScreenProvider
        // Add more providers if needed
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

