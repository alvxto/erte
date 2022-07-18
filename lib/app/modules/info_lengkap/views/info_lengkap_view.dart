import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:erte/app/modules/admin/views/admin_view.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/info_lengkap_controller.dart';

class InfoLengkapView extends GetView<InfoLengkapController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRT(title: "Infomasi RT"),
      body: Obx(
        () => controller.infos.length < 1
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
            : ListView.builder(
                // padding: EdgeInsets.all(15),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) => InfoCard(
                  info: controller.infos[index],
                ),
                itemCount: controller.infos.length,
              ),
      ),
    );
  }
}

class InfoCard extends GetView<InfoLengkapController> {
  Future<void> share() async {
    await FlutterShare.share(
        title: '${info.judul}',
        text: '${info.deskripsi}',
        chooserTitle: '${info.judul}');
  }

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(Icons.close, size: 25),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Obx(
                            () => controller.imagePath.value != ''
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 200,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: FileImage(
                                              File(
                                                controller.imagePath.value,
                                              ),
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  )
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
                                                  image:
                                                      NetworkImage(info.image!),
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
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                      "images/home.png")),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${info.judul}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${info.deskripsi}",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: primary),
                            ),
                            Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: white,
                                ),
                                child: InkWell(
                                  onTap: () => share(),
                                  child: Icon(
                                    Icons.share_sharp,
                                    color: primary,
                                    size: 18,
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          // padding: EdgeInsets.all(10),
          width: 250,
          height: 110,
          // margin: EdgeInsets.all(15),
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
                              fit: BoxFit.cover),
                        ),
                      )
                    : Container(
                        height: 110,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("images/home.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${info.judul}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            "${info.deskripsi}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "${DateFormat.yMMMEd('id').format(info.waktu!)}",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
