import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const routName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      context.goNamed(AuthScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(
              size: 300,
            ),
            SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.lerp(
                  BorderRadius.circular(10), BorderRadius.circular(20), 5),
              child: Column(
                children: [
                  TextLiquidFill(
                    text: 'AWESOME',
                    loadDuration: const Duration(seconds: 3),
                    boxBackgroundColor: Colors.orange.shade600,
                    textStyle: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 120,
                    boxWidth: 300,
                  ),
                  TextLiquidFill(
                    text: 'CHAT',
                    loadDuration: const Duration(seconds: 3),
                    boxBackgroundColor: Colors.orange.shade600,
                    textStyle: const TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 120,
                    boxWidth: 300,
                  ),
                ],
              ),
            ),
            // AnimatedTextKit(
            //   animatedTexts: [
            //     TyperAnimatedText('Ogabek'),
            //     TyperAnimatedText('Norpulatov'),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
