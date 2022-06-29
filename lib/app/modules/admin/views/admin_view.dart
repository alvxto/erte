import 'package:avatar_glow/avatar_glow.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:erte/app/data/models/kas.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  final authC = Get.find<AuthController>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: background,
      drawer: Drawer(
        backgroundColor: white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            width: double.infinity,
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: radiusCircular(10),
              ),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Color(0xFF030BFF),
                  Color(0xFF282A61),
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
                                      color: dark,
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
                                      ))),
                            ),
                    ),
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          authC.user.nama ?? "Guest",
                          style: TextStyle(color: white, fontSize: 20),
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
                          style: TextStyle(color: white, fontSize: 17),
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
                        ListTile(
                          onTap: () => Get.toNamed(Routes.HOME),
                          leading: Icon(
                            Icons.person_outline_outlined,
                            color: dark,
                          ),
                          title: Text(
                            "Halaman Warga",
                            style: TextStyle(color: dark),
                          ),
                        ),
                        ListTile(
                          onTap: () => Get.toNamed(Routes.PROFIL),
                          leading: Icon(
                            Icons.person,
                            color: dark,
                          ),
                          title: Text(
                            "Profil",
                            style: TextStyle(color: dark),
                          ),
                        ),
                        Obx(
                          () => authC.user.id == null
                              ? ListTile(
                                  onTap: () => Get.toNamed(Routes.AUTH),
                                  leading: Icon(
                                    Icons.login,
                                    color: dark,
                                  ),
                                  title: Text(
                                    "Login",
                                    style: TextStyle(color: dark),
                                  ),
                                )
                              : ListTile(
                                  onTap: () => authC.logout(),
                                  leading: Icon(
                                    Icons.logout,
                                    color: dark,
                                  ),
                                  title: Text(
                                    "Logout",
                                    style: TextStyle(color: dark),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFF282A61),
                    Color(0xFF0208B0),
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Opacity(
                    opacity: 0.5,
                    child: Container(
                      child: Image.asset(
                        img_perum,
                        fit: BoxFit.cover,
                      ),
                      width: double.infinity,
                      height: 300,
                    ),
                  ),
                ],
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
                            padding: const EdgeInsets.all(20.0),
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
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                                height: 31,
                                width: 50,
                                child: Image.asset(
                                  img_logoputih,
                                  fit: BoxFit.fitWidth,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "${DateFormat.yMMMEd().format(DateTime.now())}",
                          style: TextStyle(
                            color: white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        " Green Living\n Residence\n RT 02 RW 09",
                        style: TextStyle(
                          color: white,
                          fontFamily: "RobotoSlab",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                Padding(
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
                        top: 20,
                      ),
                      child: Text(
                        " Green Living Residence\n RT 02 RW 09",
                        style: TextStyle(
                          color: black,
                          fontFamily: "RobotoSlab",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(50),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: InkWell(
                                  onTap: () => Get.toNamed(Routes.ADMIN_SURAT),
                                  child: Image.asset(
                                    img_admsurat,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.ADMIN_SURAT),
                          child: Column(
                            children: [
                              Text(
                                "Surat Warga",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(50),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: InkWell(
                                    onTap: () => Get.toNamed(Routes.LAPOR),
                                    child: Image.asset(
                                      img_lapwarga,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.LAPOR),
                          child: Column(
                            children: [
                              Text(
                                "Laporan Warga",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: dark,
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 50,
                                  width: 50,
                                  child: InkWell(
                                    onTap: () => Get.toNamed(Routes.BUKU_TAMU),
                                    child: Image.asset(
                                      img_bukutamu,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.BUKU_TAMU),
                          child: Column(
                            children: [
                              Text(
                                "Buku Tamu",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(50),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: InkWell(
                                  onTap: () => Get.toNamed(Routes.KAS),
                                  child: Image.asset(
                                    img_kas,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.KAS),
                          child: Column(
                            children: [
                              Text(
                                "Kas RT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(50),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: InkWell(
                                  onTap: () => Get.toNamed(Routes.INFORMASI),
                                  child: Image.asset(
                                    img_informasi,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () => Get.toNamed(Routes.INFORMASI),
                          child: Column(
                            children: [
                              Text(
                                "Informasi RT",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Nunito",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Informasi RT",
                        style: TextStyle(
                            color: dark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: dark),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: dark,
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
                              style: TextStyle(color: dark),
                            ),
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.infos.length,
                              physics: ScrollPhysics(),
                              itemBuilder: (context, index) => InfoCard(
                                info: controller.infos[index],
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        "Kas RT",
                        style: TextStyle(
                          fontSize: 20,
                          color: dark,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => controller.kass.length < 1
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
                          height: 400,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: controller.kass.length,
                                itemBuilder: (context, index) =>
                                    KasAdmin(kas: controller.kass[index])),
                          ),
                        ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends GetView<AdminController> {
  InfoCard({required this.info});
  Informasi info;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (context) => Container(
                height: 130,
                child: Column(
                  children: [
                    ListTile(
                        title: Text(
                          "Edit",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: primary,
                        ),
                        onTap: () =>
                            Get.toNamed(Routes.INFORMASI, arguments: info)),
                    ListTile(
                        title: Text(
                          "Delete",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: primary,
                        ),
                        onTap: () => controller.delete(info)),
                  ],
                )));
      },
      child: Container(
        // padding: EdgeInsets.all(10),
        width: 250,
        height: 220,
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
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      height: 90,
                      width: 240,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage("assets/home.png"),
                              fit: BoxFit.fitHeight)),
                    ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  info.judul!,
                  style: TextStyle(fontSize: 18),
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

class KasAdmin extends GetView<AdminController> {
  KasAdmin({required this.kas});
  final authC = Get.find<AuthController>();
  Kas kas;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(kas);
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (context) => Container(
                height: 130,
                child: Column(
                  children: [
                    ListTile(
                        title: Text(
                          "Edit",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: primary,
                        ),
                        onTap: () => Get.toNamed(Routes.KAS, arguments: kas)),
                    ListTile(
                        title: Text(
                          "Delete",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: primary,
                        ),
                        onTap: () => controller.deletekas(kas)),
                  ],
                )));
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
                        image: AssetImage("images/kas.png"),
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
                      "${kas.deskripsi} (${kas.kategori})",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${kas.uang}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${DateFormat.yMMMEd().format(kas.waktu!)}",
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
