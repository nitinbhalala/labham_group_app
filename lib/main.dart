// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimall_store/views/pages/Splash_page.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Localization/app_localization.dart';
import 'constants/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      
    ),
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLang();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: Constants.appName,
          locale: _locale,
          supportedLocales: const [Locale('en', 'US'), Locale('gu', 'US')],
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: Colors.black),
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        );
      },
    );
  }

  void getCurrentLang() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _locale = Locale(prefs.getString('language') ?? 'gu', 'US');
    });
  }
  // void getCurrentLang() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _locale = (prefs.getString('language') != null)
  //         ? Locale(prefs.getString('language').toString(),
  //             prefs.getString('languageCode'))
  //         : const Locale('en','US');
  //   });
  // }
}
