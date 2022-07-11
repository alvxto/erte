import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/info_lengkap_controller.dart';

class InfoLengkapView extends GetView<InfoLengkapController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Infomasi RT'),
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
      body: Obx(() => controller.infos.length < 1
          ? Center(
              child: Text(
                "Kosong",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) => InfoCard(
                  info: controller.infos[index],
                ),
                itemCount: controller.infos.length,
              ),
            )),
    );
  }
}

class InfoCard extends GetView<InfoLengkapController> {
  InfoCard({required this.info});
  Informasi info;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(info);
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                backgroundColor: white,
                children: [
                  Container(
                    height: 480,
                    width: 100,
                    decoration: BoxDecoration(color: white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Informasi RT",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Text("Judul"),
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
                                Text("Deskripsi"),
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
                                    : info.image != null
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
                                                          info.image!),
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
        // padding: EdgeInsets.all(10),
        width: 250,
        height: 110,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              info.image != null
                  ? Container(
                      height: 110,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(info.image!),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("images/home.png"),
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
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      info.judul!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${DateFormat.yMMMEd().format(info.waktu!)}",
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
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
