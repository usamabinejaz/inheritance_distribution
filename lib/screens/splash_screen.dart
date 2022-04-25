import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inheritance_distribution/app_reserved/constants.dart';
import 'package:inheritance_distribution/screens/login_decider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.forward();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginDecider(),
          ),
          (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FadeTransition(
              opacity: animation,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/images/splash_logo.png",
                ),
                radius: 100,
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: const Text(
                "WeRaast",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Constants.appTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: const Text(
                "HELPING YOU DIVIDE THE HERITAGE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Constants.appSubtitle1Size,
                ),
              ),
            ),
            const Spacer(),
            const Text("Religion to Present \u00a9"),
          ],
        ),
      ),
    );
  }
}
