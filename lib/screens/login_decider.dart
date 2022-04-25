import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inheritance_distribution/screens/home.dart';
import 'package:inheritance_distribution/screens/login.dart';

class LoginDecider extends StatelessWidget {
  const LoginDecider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went Wrong!'));
        } else if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }
        return const LoginScreen();
      },
    );
  }
}
