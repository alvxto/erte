import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/form_kk.dart';
import 'package:erte/app/data/models/form_ktp.dart';
import 'package:erte/app/data/models/s_domisili.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/modules/admin_surat/controllers/admin_surat_controller3.dart';
import 'package:erte/app/modules/admin_surat/controllers/admin_surat_controller2.dart';
import 'package:erte/app/modules/admin_surat/controllers/admin_surat_controller4.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/admin_surat_controller.dart';

class AdminSuratView extends StatefulWidget {
  @override
  State<AdminSuratView> createState() => _AdminSuratViewState();
}

class _AdminSuratViewState extends State<AdminSuratView>
    with SingleTickerProviderStateMixin {
  AdminSuratController controller = Get.find<AdminSuratController>();
  AdminSuratController2 controller2 = Get.find<AdminSuratController2>();
  AdminSuratController3 controller3 = Get.find<AdminSuratController3>();
  AdminSuratController4 controller4 = Get.find<AdminSuratController4>();

  late TabController tabC = TabController(length: 4, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Surat Warga"),
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
          onTap: () => Get.back(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: <Color>[
                accent,
                dark,
              ],
            ),
          ),
        ),
        bottom: TabBar(
          controller: tabC,
          labelPadding: EdgeInsets.all(10),
          tabs: [
            Text(
              "Pengantar",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "Domisili",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "KTP",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              "KK",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabC,
        children: [
          Obx(
            () => controller.pengantar.length < 1
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
                    itemCount: controller.pengantar.length,
                    itemBuilder: ((context, index) => SuratWarga(
                          pengantar: controller.pengantar[index],
                        )),
                  ),
          ),
          Obx(
            () => controller2.domisili.length < 1
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
                    itemCount: controller2.domisili.length,
                    itemBuilder: ((context, index) => SuratWarga2(
                          domisili: controller2.domisili[index],
                        )),
                  ),
          ),
          Obx(
            () => controller3.ktp.length < 1
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
                    itemCount: controller3.ktp.length,
                    itemBuilder: ((context, index) => SuratWarga3(
                          ktp: controller3.ktp[index],
                        )),
                  ),
          ),
          Obx(
            () => controller4.kk.length < 1
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
                    itemCount: controller4.kk.length,
                    itemBuilder: ((context, index) => SuratWarga4(
                          kk: controller4.kk[index],
                        )),
                  ),
          ),
        ],
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
    controller.modelcontroller(pengantar);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(
                //   () => authC.user.image != null
                //       ? Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Container(
                //               height: 70,
                //               width: 70,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFECEAEA),
                //                 borderRadius: BorderRadius.circular(80 / 2),
                //               ),
                //             ),
                //             Container(
                //               height: 60,
                //               width: 60,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(authC.user.image!),
                //                     fit: BoxFit.cover),
                //                 border:
                //                     Border.all(color: Colors.white10, width: 3),
                //                 borderRadius: BorderRadius.circular(100 / 2),
                //               ),
                //             ),
                //           ],
                //         )
                //       : Stack(
                //           children: [
                //             Material(
                //               elevation: 6.0,
                //               shape: CircleBorder(),
                //               child: Container(
                //                 height: 60,
                //                 width: 60,
                //                 child: Image.asset(
                //                   "images/profil.png",
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                // ),
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
                            fontSize: 14,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(pengantar, true),

                                // onTap: pengantar.keperluan1 == null
                                //     ? null
                                //     : pengantar.keperluan1 ==
                                //             "Surat Keterangan Domisili"
                                //         ? () => controller.getPDF(domisili)
                                //         : null,
                                child: Icon(
                                  Icons.visibility,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () =>
                                    controller.getPDF(pengantar, false),
                                child: Icon(
                                  Icons.send,
                                  color: white,
                                  size: 20,
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

class SuratWarga2 extends GetView<AdminSuratController2> {
  final authC = Get.find<AuthController>();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SuratWarga2({required this.domisili});
  Domisili domisili;

  @override
  Widget build(BuildContext context) {
    controller.modelcontroller(domisili);
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
                                " ${domisili.nama}",
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
                                " ${domisili.alamat}",
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
                                " ${domisili.email}",
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
                              "Keperluan :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${domisili.keperluan}",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(
                //   () => authC.user.image != null
                //       ? Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Container(
                //               height: 70,
                //               width: 70,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFECEAEA),
                //                 borderRadius: BorderRadius.circular(80 / 2),
                //               ),
                //             ),
                //             Container(
                //               height: 60,
                //               width: 60,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(authC.user.image!),
                //                     fit: BoxFit.cover),
                //                 border:
                //                     Border.all(color: Colors.white10, width: 3),
                //                 borderRadius: BorderRadius.circular(100 / 2),
                //               ),
                //             ),
                //           ],
                //         )
                //       : Stack(
                //           children: [
                //             Material(
                //               elevation: 6.0,
                //               shape: CircleBorder(),
                //               child: Container(
                //                 height: 60,
                //                 width: 60,
                //                 child: Image.asset(
                //                   "images/profil.png",
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                // ),
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
                          "${domisili.nama}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${domisili.nama} meminta surat pengantar untuk keperluan ${domisili.keperluan}",
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
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(domisili, true),

                                // onTap: pengantar.keperluan1 == null
                                //     ? null
                                //     : pengantar.keperluan1 ==
                                //             "Surat Keterangan Domisili"
                                //         ? () => controller.getPDF(domisili)
                                //         : null,
                                child: Icon(
                                  Icons.visibility,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(domisili, false),
                                child: Icon(
                                  Icons.send,
                                  color: white,
                                  size: 20,
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

class SuratWarga3 extends GetView<AdminSuratController3> {
  final authC = Get.find<AuthController>();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SuratWarga3({required this.ktp});
  KTP ktp;

  @override
  Widget build(BuildContext context) {
    controller.modelcontroller(ktp);
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
                                " ${ktp.nama}",
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
                                " ${ktp.alamat}",
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
                                " ${ktp.email}",
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
                              "Keperluan :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${ktp.keperluan1}",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(
                //   () => authC.user.image != null
                //       ? Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Container(
                //               height: 70,
                //               width: 70,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFECEAEA),
                //                 borderRadius: BorderRadius.circular(80 / 2),
                //               ),
                //             ),
                //             Container(
                //               height: 60,
                //               width: 60,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(authC.user.image!),
                //                     fit: BoxFit.cover),
                //                 border:
                //                     Border.all(color: Colors.white10, width: 3),
                //                 borderRadius: BorderRadius.circular(100 / 2),
                //               ),
                //             ),
                //           ],
                //         )
                //       : Stack(
                //           children: [
                //             Material(
                //               elevation: 6.0,
                //               shape: CircleBorder(),
                //               child: Container(
                //                 height: 60,
                //                 width: 60,
                //                 child: Image.asset(
                //                   "images/profil.png",
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                // ),
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
                          "${ktp.nama}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${ktp.nama} meminta surat pengantar untuk keperluan ${ktp.keperluan1}",
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
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(ktp, true),

                                // onTap: pengantar.keperluan1 == null
                                //     ? null
                                //     : pengantar.keperluan1 ==
                                //             "Surat Keterangan Domisili"
                                //         ? () => controller.getPDF(domisili)
                                //         : null,
                                child: Icon(
                                  Icons.visibility,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(ktp, false),
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

class SuratWarga4 extends GetView<AdminSuratController4> {
  final authC = Get.find<AuthController>();

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  SuratWarga4({required this.kk});
  KK kk;

  @override
  Widget build(BuildContext context) {
    controller.modelcontroller(kk);
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
                                " ${kk.namalengkap}",
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
                                " ${kk.alamat}",
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
                                " ${kk.email}",
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
                              "Keperluan :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${kk.keperluan1}",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Obx(
                //   () => authC.user.image != null
                //       ? Stack(
                //           alignment: Alignment.center,
                //           children: [
                //             Container(
                //               height: 70,
                //               width: 70,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFECEAEA),
                //                 borderRadius: BorderRadius.circular(80 / 2),
                //               ),
                //             ),
                //             Container(
                //               height: 60,
                //               width: 60,
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                     image: NetworkImage(authC.user.image!),
                //                     fit: BoxFit.cover),
                //                 border:
                //                     Border.all(color: Colors.white10, width: 3),
                //                 borderRadius: BorderRadius.circular(100 / 2),
                //               ),
                //             ),
                //           ],
                //         )
                //       : Stack(
                //           children: [
                //             Material(
                //               elevation: 6.0,
                //               shape: CircleBorder(),
                //               child: Container(
                //                 height: 60,
                //                 width: 60,
                //                 child: Image.asset(
                //                   "images/profil.png",
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                // ),
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
                          "${kk.namalengkap}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${kk.namalengkap} meminta surat pengantar untuk keperluan ${kk.keperluan1}",
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
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(kk, true),

                                // onTap: pengantar.keperluan1 == null
                                //     ? null
                                //     : pengantar.keperluan1 ==
                                //             "Surat Keterangan Domisili"
                                //         ? () => controller.getPDF(domisili)
                                //         : null,
                                child: Icon(
                                  Icons.visibility,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
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
                                onTap: () => controller.getPDF(kk, false),
                                child: Icon(
                                  Icons.send,
                                  color: white,
                                  size: 20,
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
