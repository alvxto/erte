import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/informasi_controller.dart';

class InformasiView extends GetView<InformasiController> {
  final authC = Get.find<AuthController>();
  Informasi info = Get.arguments ?? Informasi();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(info);
    return Scaffold(
      backgroundColor: background,
      appBar: AppBarAdmin(title: "Informasi RT"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    "Judul",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppTextField(
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                  controller: controller.judulC,
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Color(0xFFD6D7FD),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppTextField(
                  maxLines: 50,
                  textStyle: TextStyle(
                    fontSize: 14,
                  ),
                  controller: controller.deskripsiC,
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    fillColor: Color(0xFFD6D7FD),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    "Gambar Informasi",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(() => controller.imagePath.value != ''
                    ? Container(
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: FileImage(
                                File(controller.imagePath.value),
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: FloatingActionButton.extended(
                          backgroundColor: Colors.transparent,
                          heroTag: null,
                          onPressed: () => controller.pickImage(),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload,
                                color: white,
                              ),
                              Text("Ganti Foto",
                                  style: TextStyle(color: white)),
                            ],
                          ),
                        ),
                      )
                    : info.image != null
                        ? Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFB7B7B7),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(info.image!),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: 400,
                            height: 200,
                            child: Center(
                              child: InkWell(
                                onTap: () => controller.pickImage(),
                                child: Image.asset(
                                  ("images/uploading.png"),
                                  width: 91,
                                  height: 80,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFB7B7B7),
                              ),
                              color: Color(0xFFD6D7FD),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          )),
                SizedBox(
                  height: 40,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate()) {
                              controller.store(info);
                            }
                          },
                    child: Container(
                      width: Get.width,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            accent,
                            dark,
                          ],
                        ),
                      ),
                      child: controller.isSaving
                          ? Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(color: white),
                              ),
                            )
                          : Center(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
