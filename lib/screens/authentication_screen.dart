import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_application/router/app_router.gr.dart';
import 'package:e_commerce_application/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

@RoutePage()
class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key,});

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  double logoSize = 200; // Initial size of the logo

  @override
  void initState() {
    super.initState();
    // Add a delay before starting the logo animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        logoSize = 300; // Target size for the logo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = AuthService();
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1), // Animation duration
            curve: Curves.easeInOut, // Animation curve
            width: logoSize, // Animated width
            height: logoSize, // Animated height
            child: SvgPicture.asset(
              'lib/assets/images/logo.svg',
              width: 200, // Initial width (adjust as needed)
              height: 200, // Initial height (adjust as needed)
            ),
          ),
          const SizedBox(height: 60),
          const SizedBox(height: 15),
          Opacity(
            opacity: 0.2,
            child: Center(
              child: Container(
                width: 300,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    enableFeedback: false,
                    animationDuration: const Duration(seconds: 0),
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child:  Row(
                    children:  [
                      Center(
                        child: Text(
                          'Sign in with Email (unavailable)',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {final account = await user.signInWithGoogle();
                  context.router.push(HomeRoute());},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: const Color(0xFF4285F4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      child: Image.asset(
                        'lib/assets/images/google_sign_in.png',

                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
