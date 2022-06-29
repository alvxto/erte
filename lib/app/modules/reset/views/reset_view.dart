import 'package:erte/app/const/color.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/reset_controller.dart';

class ResetView extends GetView<ResetController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Reset'),
      //   // centerTitle: true,
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Center(
                  child: Container(
                      height: 90,
                      width: 130,
                      child: Image.asset(
                        "images/erte.png",
                        fit: BoxFit.fitWidth,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 300,
                  width: 300,
                  child: Lottie.asset("images/reset.json", fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text("Reset Password",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: primary))),
                SizedBox(
                  height: 10,
                ),
                AppTextField(
                    showCursor: true,
                    textFieldType: TextFieldType.EMAIL,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    controller: controller.emailC,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      label: Row(children: [
                        Icon(
                          Icons.email,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Email",
                        ),
                      ]),
                      // labelText: "Email",
                      border: OutlineInputBorder(),
                    )),
                SizedBox(
                  height: 30,
                ),
                AppButton(
                    color: primary,
                    textColor: white,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    width: Get.width,
                    text: "Kirim",
                    onTap: () => authC.reset(controller.emailC.text)),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.AUTH),
                  child: Text("Sudah Punya Akun? Login Disini!",
                      style: TextStyle(color: primary)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
