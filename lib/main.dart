import 'package:flutter/material.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/my_theme_data.dart';
import 'package:easy_localization/easy_localization.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', 
      fallbackLocale: const Locale('en'), 
      startLocale: const Locale('ar'),    
      child: const MyApp(),
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

    initialRoute: '/',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/': (context) => HomeScreen(),
  },

  debugShowCheckedModeBanner: false,
  theme:MyThemeData.lightMode ,

    );
  }
}
