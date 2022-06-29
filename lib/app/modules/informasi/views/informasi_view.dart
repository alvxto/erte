import 'dart:io';

import 'package:erte/app/const/color.dart';
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
      appBar: AppBar(
        title: Text('Informasi RT'),
        // centerTitle: true,
        leading: InkWell(
          onTap: () => authC.user.role == "Admin"
              ? Get.offAndToNamed(Routes.ADMIN)
              : Get.offAndToNamed(Routes.HOME),
          child: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
      ),
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
                Text("Judul"),
                SizedBox(
                  height: 5,
                ),
                AppTextField(
                  controller: controller.judulC,
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Deskripsi"),
                AppTextField(
                  controller: controller.deskripsiC,
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(() => controller.imagePath.value != ''
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Container(
                            height: 200,
                            width: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(
                                        File(controller.imagePath.value)),
                                    fit: BoxFit.cover)),
                          ),
                        ))
                    : info.image != null
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Container(
                                height: 200,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(info.image!),
                                        fit: BoxFit.cover)),
                              ),
                            ))
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Container(
                                width: 400,
                                height: 200,
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image(
                                      image: AssetImage("images/home.png")),
                                )),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: 160,
                    child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () => controller.pickImage(),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload,
                              color: white,
                            ),
                            Text("Upload Foto", style: TextStyle(color: white)),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Obx(
                    () => Container(
                      width: Get.width,
                      child: FloatingActionButton.extended(
                          heroTag: null,
                          onPressed: controller.isSaving
                              ? null
                              : () {
                                  if (form.currentState!.validate()) {
                                    controller.store(info);
                                  }
                                },
                          label: controller.isSaving
                              ? Text("Loading...")
                              : Text("Kirim")),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
