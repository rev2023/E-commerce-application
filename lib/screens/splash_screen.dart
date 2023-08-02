import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // Simulate a delay to show the splash screen for a few seconds.
    Future.delayed(Duration(seconds: 2), () {
      // After the delay, navigate to the home screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: SvgPicture.asset( 'lib/assets/images/logo.svg')),);
  }
}
