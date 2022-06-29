import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
import 'package:erte/app/data/models/lapor.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import '../controllers/lapor_controller.dart';

class LaporView extends GetView<LaporController> {
  final authC = Get.find<AuthController>();
  Lapor lapor = Get.arguments ?? Lapor();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print(controller.lapors.length);
    return Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: Text('Lapor RT'),
          // centerTitle: true,
          leading: InkWell(
              onTap: () => authC.user.role == "Admin"
                  ? Get.offAndToNamed(Routes.ADMIN)
                  : Get.offAndToNamed(Routes.HOME),
              child: Icon(
                Icons.arrow_back,
                color: white,
              )),
        ),
        body: Obx(() => authC.user.role == "Admin"
            ? Obx(() => controller.lapors.length < 1
                ? Center(
                    child: Text(
                      "Kosong",
                      style: TextStyle(
                          color: primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: Get.height,
                    width: Get.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          itemCount: controller.lapors.length,
                          itemBuilder: (context, index) =>
                              LaporCard(lapor: controller.lapors[index])),
                    ),
                  ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Silahkan sampaikan laporan anda kepada Ketua RT atau Pengurus RT di bawah ini",
                          style: TextStyle(fontSize: 15, color: secondary),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Nama",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppTextField(
                          controller: controller.namaC,
                          textFieldType: TextFieldType.NAME,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Judul Laporan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        AppTextField(
                          controller: controller.judulC,
                          textFieldType: TextFieldType.NAME,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Deskripsi Laporan",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        AppTextField(
                          controller: controller.deskripsiC,
                          textFieldType: TextFieldType.NAME,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Obx(
                              () => controller.imagePath.value != ''
                                  ? Container(
                                      height: 200,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  controller.imagePath.value)),
                                              fit: BoxFit.cover)),
                                    )
                                  : lapor.image != null
                                      ? Container(
                                          height: 200,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      lapor.image!),
                                                  fit: BoxFit.cover)),
                                        )
                                      : Container(
                                          width: 400,
                                          height: 200,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Image(
                                                image: AssetImage(img_home),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                            ),
                          ),
                        ),
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
                                    Text("Upload Foto",
                                        style: TextStyle(color: white)),
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
                                            controller.store(lapor);
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
              )));
  }
}

class LaporCard extends GetView<LaporController> {
  LaporCard({required this.lapor});
  Lapor lapor;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(lapor);
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                backgroundColor: white,
                children: [
                  Container(
                    height: 615,
                    width: 100,
                    decoration: BoxDecoration(color: white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Laporan Warga",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Text("Nama"),
                                SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  controller: controller.namaC,
                                  enabled: false,
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Judul Laporan"),
                                SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  controller: controller.judulC,
                                  enabled: false,
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Deskripsi Laporan"),
                                SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  controller: controller.deskripsiC,
                                  enabled: false,
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Obx(() => controller.imagePath.value != ''
                                    ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          height: 200,
                                          width: 400,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: FileImage(File(
                                                      controller
                                                          .imagePath.value)),
                                                  fit: BoxFit.cover)),
                                        ))
                                    : lapor.image != null
                                        ? Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              height: 200,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          lapor.image!),
                                                      fit: BoxFit.cover)),
                                            ))
                                        : Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Container(
                                              width: 400,
                                              height: 200,
                                              child: Center(
                                                  child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Image(
                                                    image: AssetImage(
                                                        "images/home.png")),
                                              )),
                                              decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          )),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: Get.width,
        height: 110,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("images/profil.png"),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${lapor.nama}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${lapor.judul}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${DateFormat.yMMMEd().format(lapor.waktu!)}",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: dark,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
