import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inheritance_distribution/app_reserved/constants.dart';
import 'package:inheritance_distribution/screens/splash_screen.dart';
import 'package:inheritance_distribution/services/firebase/authentication.dart';
import 'package:inheritance_distribution/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_platform/universal_platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(UniversalPlatform.isAndroid) {
    await Firebase.initializeApp();
  }else if(UniversalPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCLwJHvCrTbq7q_xucPrjTW2DvR1WVM7WE",
          authDomain: "weraast-religiontopresent.firebaseapp.com",
          projectId: "weraast-religiontopresent",
          storageBucket: "weraast-religiontopresent.appspot.com",
          messagingSenderId: "672270029467",
          appId: "1:672270029467:web:fba0b0d0b2b6d3c037ec3e"
      ),
    );
  }
  SharedPreferences mSharedPrefs = await SharedPreferences.getInstance();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {
        return ThemeProvider(
            darkThemeOn:
                mSharedPrefs.getBool(Constants.darkModeString) ?? false);
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (BuildContext context) => Auth(),
          ),
        ],
        child: MaterialApp(
          title: 'Durood Together',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const SplashScreen(),
        ),
      );
    });
  }
}
