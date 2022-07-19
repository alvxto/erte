import 'package:erte/app/const/image.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(img_logobiru),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Container(
                  child: Text(
                    "ERTE adalah supperapp dengan layanan pengurusan berkas seperti pengajuan KTP, KK & banyak lagi.",
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(color: Colors.grey[700])),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 20),
                child: Container(
                  child: Text(
                    "EST 2022",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.grey[700])),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
