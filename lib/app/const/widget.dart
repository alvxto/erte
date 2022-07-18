import 'package:erte/app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../routes/app_pages.dart';

PreferredSizeWidget AppBarRT({required String title}) {
  return AppBar(
    elevation: 0,
    title: Text(title),
    leading: InkWell(
      child: Icon(Icons.arrow_back_ios),
      onTap: () => Get.back(),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            primary,
            secondary,
          ],
        ),
      ),
    ),
  );
}

PreferredSizeWidget AppBarAdmin({required String title}) {
  return AppBar(
    elevation: 0,
    title: Text(title),
    leading: InkWell(
      child: Icon(Icons.arrow_back_ios),
      onTap: () => Get.back(),
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            accent,
            dark,
          ],
        ),
      ),
    ),
  );
}
