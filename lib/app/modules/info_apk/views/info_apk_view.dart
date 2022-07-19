import 'package:erte/app/const/widget.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/info_apk_controller.dart';

class InfoApkView extends GetView<InfoApkController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarRT(
          title: "Informasi Aplikasi",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  child: Text(
                    "ERTE adalah supperapp dengan layanan pengurusan berkas seperti pengajuan KTP, KK & banyak lagi.",
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
