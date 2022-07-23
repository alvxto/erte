import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
import 'package:erte/app/data/database.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final authC = Get.find<AuthController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: background,
      drawer: Drawer(
        backgroundColor: background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 230,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: radiusCircular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    primary,
                    secondary,
                  ],
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Obx(
                        () => authC.user.image != null
                            ? AvatarGlow(
                                endRadius: 50.0,
                                glowColor: white,
                                duration: Duration(seconds: 1),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: primary,
                                        borderRadius:
                                            BorderRadius.circular(80 / 2),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(authC.user.image!),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            color: Colors.white10, width: 3),
                                        borderRadius:
                                            BorderRadius.circular(100 / 2),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : AvatarGlow(
                                endRadius: 50.0,
                                glowColor: white,
                                duration: Duration(seconds: 1),
                                child: Material(
                                  elevation: 6.0,
                                  shape: CircleBorder(),
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    child: Image.asset(
                                      "images/profil.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            authC.user.nama ?? "Guest",
                            style: TextStyle(
                              color: white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(
                        () => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            authC.user.email ?? "-",
                            style: TextStyle(
                              color: white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Obx(
                            () => authC.user.role == "Admin"
                                ? ListTile(
                                    onTap: () => Get.toNamed(Routes.ADMIN),
                                    leading: Icon(
                                      Icons.person_outline_outlined,
                                      color: black,
                                    ),
                                    title: Text(
                                      "Halaman Admin",
                                      style: TextStyle(color: black),
                                    ),
                                  )
                                : Container(),
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.PROFIL),
                            leading: Icon(
                              Icons.person,
                              color: black,
                            ),
                            title: Text(
                              "Profil",
                              style: TextStyle(color: black),
                            ),
                          ),
                          Obx(() => authC.user.id != null
                              ? ListTile(
                                  onTap: () => Get.toNamed(Routes.RIWAYAT),
                                  leading: Icon(
                                    Icons.history,
                                    color: black,
                                  ),
                                  title: Text(
                                    "Riwayat",
                                    style: TextStyle(color: black),
                                  ),
                                )
                              : Container()),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.LAPOR),
                            leading: Icon(
                              Icons.notifications,
                              color: black,
                            ),
                            title: Text(
                              "Lapor RT",
                              style: TextStyle(color: black),
                            ),
                          ),
                          Obx(() => authC.user.id != null
                              ? ListTile(
                                  onTap: () => Get.toNamed(Routes.KAS),
                                  leading: Icon(
                                    Icons.money,
                                    color: black,
                                  ),
                                  title: Text(
                                    "Kas RT",
                                    style: TextStyle(color: black),
                                  ),
                                )
                              : Container()),
                          Obx(
                            () => authC.user.role == "User"
                                ? ListTile(
                                    onTap: () =>
                                        Get.toNamed(Routes.RIWAYAT_LAPOR),
                                    leading: Icon(
                                      Icons.history_outlined,
                                      color: black,
                                    ),
                                    title: Text(
                                      "Riwayat Lapor RT",
                                      style: TextStyle(color: black),
                                    ),
                                  )
                                : Container(),
                          ),
                          ListTile(
                            onTap: () => Get.toNamed(Routes.PENGATURAN),
                            leading: Icon(
                              Icons.settings,
                              color: black,
                            ),
                            title: Text(
                              "Pengaturan",
                              style: TextStyle(color: black),
                            ),
                          ),
                          Obx(
                            () => authC.user.id == null
                                ? ListTile(
                                    onTap: () => Get.toNamed(Routes.AUTH),
                                    leading: Icon(
                                      Icons.login,
                                      color: black,
                                    ),
                                    title: Text(
                                      "Login",
                                      style: TextStyle(color: black),
                                    ),
                                  )
                                : ListTile(
                                    onTap: () => authC.logout(),
                                    leading: Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ),
                                    title: Text(
                                      "Keluar",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: Get.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xFF696EFF),
                    Color(0xFF000DFF),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              child: Icon(
                                Icons.menu,
                                color: white,
                              ),
                              onTap: () =>
                                  _globalKey.currentState!.openDrawer(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Container(
                              height: 31,
                              width: 50,
                              child: Image.asset(
                                img_logoputih,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${DateFormat.yMMMEd('id').format(DateTime.now())}",
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 30),
                    Container(
                      height: 100,
                      width: 140,
                      child: Image.asset(img_hallo),
                    ),
                    Obx(
                      () => Expanded(
                        child: Text(
                          "Hai ! ${authC.user.nama ?? ""}\nSelamat Datang",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: white,
                            fontSize: 18,
                            fontFamily: "RobotoSlab",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        50.height,
                        Container(
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.only(
                              topLeft: radiusCircular(32),
                              topRight: radiusCircular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 70),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: dark,
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 36,
                                              width: 36,
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.S_PENGANTAR),
                                                child: Image.asset(
                                                  img_suratpeng,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(Routes.S_PENGANTAR),
                                        child: Text(
                                          "Surat\nPengantar",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: dark,
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 36,
                                              width: 36,
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.S_DOMISILI),
                                                child: Image.asset(
                                                  img_domisili,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(Routes.S_DOMISILI),
                                        child: Text(
                                          "Surat\nDomisili",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: dark,
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 36,
                                              width: 36,
                                              child: InkWell(
                                                onTap: () =>
                                                    Get.toNamed(Routes.FORM_KK),
                                                child: Image.asset(
                                                  img_kk,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(Routes.FORM_KK),
                                        child: Text(
                                          "Form\nKK",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        height: 65,
                                        width: 65,
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: dark,
                                              spreadRadius: 0,
                                              blurRadius: 4,
                                              offset: Offset(0, 4),
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              child: InkWell(
                                                onTap: () => Get.toNamed(
                                                    Routes.FORM_KTP),
                                                child: Image.asset(
                                                  img_ktp,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () =>
                                            Get.toNamed(Routes.FORM_KTP),
                                        child: Text(
                                          "Form\nKTP",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Nunito",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kegiatan RT",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 125,
                                          child: Divider(
                                            thickness: 3,
                                            color: primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.INFO_LENGKAP);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: primary),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: secondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 200,
                                child: Obx(
                                  () => controller.infos.length < 1
                                      ? Center(
                                          child: Text(
                                            "Kosong",
                                            style: TextStyle(color: primary),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.infos.length,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                InfoCard(
                                              info: controller.infos[index],
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 28.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Informasi RT",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          width: 125,
                                          child: Divider(
                                            thickness: 3,
                                            color: primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.INFO_LENGKAP);
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Lihat Semua",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                                color: primary),
                                          ),
                                          Icon(
                                            Icons.keyboard_arrow_right,
                                            color: secondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 15),
                                height: 200,
                                child: Obx(
                                  () => controller.infos.length < 1
                                      ? Center(
                                          child: Text(
                                            "Kosong",
                                            style: TextStyle(color: primary),
                                          ),
                                        )
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.infos.length,
                                            physics: ScrollPhysics(),
                                            itemBuilder: (context, index) =>
                                                InfoCard(
                                              info: controller.infos[index],
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: Container(
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              alignment: Alignment.centerLeft,
                              image: AssetImage(img_perum),
                              fit: BoxFit.fitHeight,
                            ),
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: dark,
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            // borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 125,
                              top: 15,
                            ),
                            child: Text(
                              "Green Living Residence\nRT 02 RW 09",
                              style: TextStyle(
                                color: black,
                                fontFamily: "RobotoSlab",
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InfoCard extends GetView<HomeController> {
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
                                              File(controller.imagePath.value),
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
                      ],
                    ),
                  )
                ],
              );
            });
      },
      child: Container(
        // padding: EdgeInsets.all(10),
        width: 250,
        height: 200,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              info.image != null
                  ? Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(info.image!),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Container(
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        image: DecorationImage(
                            image: AssetImage("assets/home.png"),
                            fit: BoxFit.cover),
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        info.judul!,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        info.deskripsi!,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
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

// appBar: AppBar(
//   title: Text('Home'),
//   centerTitle: true,
//   actions: [
//     IconButton(
//         onPressed: () => Get.toNamed(Routes.PROFIL),
//         icon: Icon(Icons.person))
//   ],
// ),

// Container(
//   height: 130,
//   width: 130,
//   decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(10)),
//   child: Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             height: 70,
//             width: 70,
//             child: InkWell(
//               onTap: () =>
//                   Get.toNamed(Routes.S_KELAHIRAN),
//               child: Image.asset(
//                 "images/kelahiran.png",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       InkWell(
//         onTap: () => Get.toNamed(Routes.S_KELAHIRAN),
//         child: Column(
//           children: [
//             Text("Surat"),
//             Text("Kelahiran")
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
// Container(
//   height: 130,
//   width: 130,
//   decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(10)),
//   child: Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             height: 70,
//             width: 70,
//             child: InkWell(
//               onTap: () =>
//                   Get.toNamed(Routes.S_KONTRAK),
//               child: Image.asset(
//                 "images/kontrak.png",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       InkWell(
//         onTap: () => Get.toNamed(Routes.S_KONTRAK),
//         child: Column(
//           children: [
//             Text("Surat"),
//             Text("Kontrak Rumah")
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
// Container(
//   height: 130,
//   width: 130,
//   decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(10)),
//   child: Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             height: 70,
//             width: 70,
//             child: InkWell(
//               onTap: () =>
//                   Get.toNamed(Routes.S_ACARA),
//               child: Image.asset(
//                 "images/acara.png",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       InkWell(
//         onTap: () => Get.toNamed(Routes.S_ACARA),
//         child: Column(
//           children: [
//             Text("Surat"),
//             Text("Izin Acara")
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
// Container(
//   height: 130,
//   width: 130,
//   decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(10)),
//   child: Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             height: 70,
//             width: 70,
//             child: InkWell(
//               onTap: () =>
//                   Get.toNamed(Routes.S_KEMATIAN),
//               child: Image.asset(
//                 "images/kematian.png",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       InkWell(
//         onTap: () => Get.toNamed(Routes.S_KEMATIAN),
//         child: Column(
//           children: [Text("Surat"), Text("Kematian")],
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
// Container(
//   height: 130,
//   width: 130,
//   decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.circular(10)),
//   child: Column(
//     children: [
//       Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//             height: 70,
//             width: 70,
//             child: InkWell(
//               onTap: () =>
//                   Get.toNamed(Routes.S_USAHA),
//               child: Image.asset(
//                 "images/usaha.png",
//                 fit: BoxFit.cover,
//               ),
//             )),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       InkWell(
//         onTap: () => Get.toNamed(Routes.S_USAHA),
//         child: Column(
//           children: [
//             Text("Surat"),
//             Text("Izin Usaha")
//           ],
//         ),
//       ),
//     ],
//   ),
// ),
// SizedBox(
//   height: 20,
// ),
