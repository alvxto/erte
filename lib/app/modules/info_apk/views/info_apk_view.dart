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
          title: "Surat Pengantar",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  child: Text(
                      "Lörem ipsum nygisk sumyheliga jobbtorg är ogåning, hemire. Våsade nebuval, och biohäde renispertad är vången. Vit lanyre i abelt remuktig i tigt. Retrest tuhott. Våck eserar för att sul mikroren. Lörem ipsum nygisk sumyheliga jobbtorg är ogåning, hemire. Våsade nebuval, och biohäde renispertad är vången. Vit lanyre i abelt remuktig i tigt. Retrest tuhott. Våck eserar för att sul mikroren. "),
                ),
              ),
            ],
          ),
        ));
  }
}
