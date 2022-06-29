import 'package:erte/app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../routes/app_pages.dart';

class AppbarColor extends StatelessWidget {
  AppbarColor({required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Text(title),
      leading: Icon(Icons.arrow_back),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: <Color>[
              Color(0xFF696EFF),
              Color(0xFF0208B0),
            ],
          ),
        ),
      ),
    );
    // return GetMaterialApp(
    //   theme: ThemeData(
    //     // textTheme: TextTheme(subtitle1: ),
    //     appBarTheme: AppBarTheme(
    //       backgroundColor: primary,
    //       elevation: 0,
    //     ),
    //     bottomAppBarColor: primary,
    //     floatingActionButtonTheme:
    //         FloatingActionButtonThemeData(backgroundColor: primary),
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   title: title,
    //   initialRoute: Routes.INTRO,
    //   getPages: AppPages.routes,
    // );
  }
}
