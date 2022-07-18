import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Reset'),
      //   // centerTitle: true,
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // width: double.infinity,
                height: size.height * .2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      img_atas,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 79,
                  child: Image.asset(
                    img_logobiru,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 198,
                width: 200,
                child: Lottie.asset(
                  img_resetpass,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: AppTextField(
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                  showCursor: true,
                  textFieldType: TextFieldType.EMAIL,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailC,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Color(0xFFD6D7FD),
                    filled: true,
                    // focusedBorder: OutlineInputBorder(),
                    label: Row(
                      children: [
                        // Icon(
                        //   Icons.email,
                        // ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: InkWell(
                  onTap: () => authC.reset(controller.emailC.text),
                  child: Container(
                    height: 45,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          primary,
                          secondary,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "KIRIM",
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // AppButton(
              //     color: primary,
              //     textColor: white,
              //     shapeBorder: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     width: Get.width,
              //     text: "KIRIM",
              //     onTap: () => authC.reset(controller.emailC.text)),
              SizedBox(
                height: 35,
              ),
              TextButton(
                onPressed: () => Get.toNamed(Routes.AUTH),
                child: Text("Sudah Punya Akun? Login Disini!",
                    style: TextStyle(color: primary)),
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * .2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          img_bawah,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
