import 'package:app/src/views_pages/home_menu_pages/home_pages.dart';
import 'package:app/src/views_pages/login_session_pages/forgot_pass.dart';
import 'package:app/src/views_pages/login_session_pages/login_pages.dart';
import 'package:app/src/views_pages/login_session_pages/register_page.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:app/src/providers/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app/src/utils/pref_users.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAuth.instance.setPersistence(Persistence.);
  final prefs = PreferenciasUsuario();
  String routeInit = 'home';
  await prefs.initPrefs();
  //print(prefs.token);

  runApp(
    Provider(
    child: MaterialApp(
    home: const LoginPage(),
    builder: BotToastInit(), //1. call BotToastInit
    navigatorObservers: [BotToastNavigatorObserver()],
    debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', 'US'), // English, no country code
      Locale('es', 'ES'), // Spanish, no country code
    ],
    theme: ThemeData(fontFamily: 'Comfortaa-Light'),
    initialRoute: routeInit,
    routes: <String, Widget Function(BuildContext)>{
      'login': (BuildContext context) => const LoginPage(),
      'home': (BuildContext context) => const HomePage(),
      'register': (BuildContext context) => const RegisterPage(),
      'forgotPass': (BuildContext context) => const ForgotPassword(),
    },
  )));
}
