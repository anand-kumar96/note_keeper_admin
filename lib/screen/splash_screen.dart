import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:note_keeper/screen/note_list.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(7, 17, 26, 1),
      body: AnimatedSplashScreen(
        backgroundColor: const Color.fromRGBO(7, 17, 26, 1),
        splash: Center(
          child: Lottie.asset(
            'assets/splash.json',
            repeat: false
          ),
        ),
        nextScreen: const NoteScreen(),
        splashIconSize: 250,
        duration: 1600,
       splashTransition: SplashTransition.fadeTransition,
       pageTransitionType: PageTransitionType.leftToRight,
      ),
    );
  }
}