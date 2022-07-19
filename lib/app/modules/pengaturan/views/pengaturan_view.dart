import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarRT(
          title: "Surat Pengantar",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2, right: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Email"),
                    ),
                    Container(
                      child: Text(authC.user.email!),
                    )
                  ],
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.INFO_APK),
                leading: Icon(
                  Icons.info_outline,
                  color: black,
                ),
                title: Text(
                  "Informasi Aplikasi",
                  style: TextStyle(color: black),
                ),
              ),
              ListTile(
                onTap: () => Get.toNamed(Routes.HUBUNGI_ADMIN),
                leading: Icon(
                  Icons.support_agent_rounded,
                  color: black,
                ),
                title: Text(
                  "Informasi Aplikasi",
                  style: TextStyle(color: black),
                ),
              ),
              Obx(
                () => authC.user.id == null
                    ? ListTile(
                        onTap: () => Get.toNamed(Routes.AUTH),
                        leading: Icon(
                          Icons.login,
                          color: black,
                        ),
                        title: Text(
                          "Login",
                          style: TextStyle(color: black),
                        ),
                      )
                    : ListTile(
                        onTap: () => authC.logout(),
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        title: Text(
                          "Keluar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
              ),
            ],
          ),
        ));
  }
}
