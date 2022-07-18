import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/modules/buku_tamu/views/buku_tamu_view.dart';
import 'package:erte/app/modules/s_domisili/controllers/s_domisili_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../auth/controllers/auth_controller.dart';
import '../controllers/admin_surat_controller.dart';

class AdminSuratView extends GetView<AdminSuratController> {
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAdmin(title: "Surat Warga"),
      body: Obx(
        () => controller.users.length < 1
            ? Center(
                child: Text(
                  "Kosong",
                  style: TextStyle(
                    color: primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: controller.users.length,
                itemBuilder: ((context, index) => SuratWarga(
                      pengantar: controller.users[index],
                    )),
              ),
      ),
    );
  }
}

class SuratWarga extends GetView<AdminSuratController> {
  final authC = Get.find<AuthController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SuratWarga({required this.pengantar});
  Pengantar pengantar;
  @override
  Widget build(BuildContext context) {
    controller.controllertomodel(pengantar);
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama   :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${pengantar.nama}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${pengantar.alamat}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email    :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${pengantar.email}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Keperluan 1 :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${pengantar.keperluan1}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Keperluan 2 :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${pengantar.keperluan2 ?? ''}",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
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
          padding: EdgeInsets.all(10),
          width: 250,
          height: 110,
          // margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => authC.user.image != null
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFFECEAEA),
                                borderRadius: BorderRadius.circular(80 / 2),
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(authC.user.image!),
                                    fit: BoxFit.cover),
                                border:
                                    Border.all(color: Colors.white10, width: 3),
                                borderRadius: BorderRadius.circular(100 / 2),
                              ),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Material(
                              elevation: 6.0,
                              shape: CircleBorder(),
                              child: Container(
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  "images/profil.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                // Container(
                //   height: 80,
                //   width: 100,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       image: DecorationImage(
                //           image: AssetImage("images/profil.png"),
                //           fit: BoxFit.fitHeight)),
                // ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${pengantar.nama}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${pengantar.nama} meminta surat pengantar untuk keperluan ${pengantar.keperluan1}",
                        style: TextStyle(fontSize: 12),
                      ),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Text(
                      //     "${absen.keperluan}",
                      //     style: TextStyle(fontSize: 14),
                      //   ),
                      // ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: dark,
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                // onTap: ,
                                child: Icon(
                                  Icons.visibility,
                                  color: white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: dark,
                                  boxShadow: [
                                    BoxShadow(
                                      color: dark,
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                // onTap: ,
                                child: Icon(
                                  Icons.send,
                                  color: white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Text(
                      //   "${DateFormat.yMMMEd().format(absen.waktu!)}",
                      //   style: TextStyle(fontSize: 15),
                      // )
                    ],
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
