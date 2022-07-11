import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/buku_tamu_controller.dart';

class BukuTamuView extends GetView<BukuTamuController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Buku Tamu'),
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
        body: Obx(() => controller.absens.length < 1
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
                      itemCount: controller.absens.length,
                      itemBuilder: (context, index) =>
                          AbsenCard(absen: controller.absens[index])),
                ),
              )));
  }
}

class AbsenCard extends GetView<BukuTamuController> {
  AbsenCard({required this.absen});
  Absen absen;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(absen);
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                backgroundColor: white,
                children: [
                  Container(
                    height: 380,
                    width: 100,
                    decoration: BoxDecoration(color: white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Buku Tamu",
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
                                Text("alamat"),
                                SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  controller: controller.alamatC,
                                  enabled: false,
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("email"),
                                SizedBox(
                                  height: 10,
                                ),
                                AppTextField(
                                  controller: controller.emailC,
                                  enabled: false,
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                ),
                                SizedBox(
                                  height: 20,
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
        width: 250,
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
                      "${absen.nama}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${absen.email}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Text(
                  //   "${DateFormat.yMMMEd().format(absen.waktu!)}",
                  //   style: TextStyle(fontSize: 15),
                  // )
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
