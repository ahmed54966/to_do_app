import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/auth/login/login_screen.dart';
import 'package:to_do_app/auth/register/register_screen.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/my_theme_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/providers/provider.dart';
import 'firebase_options.dart';


void main() async {

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', 
      fallbackLocale: const Locale('en'), 
      startLocale: const Locale('ar'),    
      child: ChangeNotifierProvider(
        create: (context) => ListProviders(),
        child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

    initialRoute: '/loginScreen',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/RegisterScreen': (context) => RegisterScreen(),
    '/homeScreen': (context) => HomeScreen(),
    '/loginScreen': (context) => LoginScreen(),

  },

  debugShowCheckedModeBanner: false,
  theme:MyThemeData.lightMode ,

    );
  }
}
