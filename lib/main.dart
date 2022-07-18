import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseStorage.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        // AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''), // English, no country code
        Locale('id', ''), // Indonesian, no country code
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primary,
          elevation: 0,
        ),
        bottomAppBarColor: primary,
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: primary),
      ),
      debugShowCheckedModeBanner: false,
      title: "RTQ",
      initialRoute: Routes.INTRO,
      getPages: AppPages.routes,
    );
  }
}
