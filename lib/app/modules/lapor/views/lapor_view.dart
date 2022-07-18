import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/lapor.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
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
      appBar: AppBarRT(title: "Lapor RT"),
      body: Obx(
        () => authC.user.role == "Admin"
            ? Obx(
                () => controller.lapors.length < 1
                    ? Center(
                        child: Text(
                          "Kosong",
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        itemCount: controller.lapors.length,
                        itemBuilder: (context, index) => LaporCard(
                          lapor: controller.lapors[index],
                        ),
                      ),
              )
            : SingleChildScrollView(
                child: Obx(
                  () => authC.user.role == "User"
                      ? Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    primary,
                                    secondary,
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    "Silahkan sampaikan laporan atau masukan",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Anda kepada Ketua RT atau Pengurus RT di",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "bawah ini.",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Form(
                                                key: form,
                                                child: Column(
                                                  children: [
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      title: Text(
                                                        "Nama",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    AppTextField(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      controller:
                                                          controller.namaC,
                                                      textFieldType:
                                                          TextFieldType.NAME,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        fillColor:
                                                            Color(0xFFD6D7FD),
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      title: Text(
                                                        "Judul Laporan",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    AppTextField(
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      controller:
                                                          controller.judulC,
                                                      textFieldType:
                                                          TextFieldType.NAME,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        fillColor:
                                                            Color(0xFFD6D7FD),
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      title: Text(
                                                        "Deskripsi Laporan",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    AppTextField(
                                                      maxLines: 50,
                                                      textStyle: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                      controller:
                                                          controller.deskripsiC,
                                                      textFieldType:
                                                          TextFieldType.NAME,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(10),
                                                        fillColor:
                                                            Color(0xFFD6D7FD),
                                                        filled: true,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    ListTile(
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                      title: Text(
                                                        "Tambahkan Foto Jika Ada",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Row(
                                                        children: [
                                                          Obx(
                                                            () => controller
                                                                        .imagePath
                                                                        .value !=
                                                                    ''
                                                                ? Container(
                                                                    height: 130,
                                                                    width: 130,
                                                                    decoration: BoxDecoration(
                                                                        border: Border.all(
                                                                          color:
                                                                              Color(0xFFB7B7B7),
                                                                        ),
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(image: FileImage(File(controller.imagePath.value)), fit: BoxFit.cover)),
                                                                  )
                                                                : lapor.image !=
                                                                        null
                                                                    ? Container(
                                                                        height:
                                                                            130,
                                                                        width:
                                                                            130,
                                                                        decoration: BoxDecoration(
                                                                            border: Border.all(
                                                                              color: Color(0xFFB7B7B7),
                                                                            ),
                                                                            borderRadius: BorderRadius.circular(10),
                                                                            image: DecorationImage(image: NetworkImage(lapor.image!), fit: BoxFit.cover)),
                                                                      )
                                                                    : Container(
                                                                        width:
                                                                            130,
                                                                        height:
                                                                            130,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(10.0),
                                                                            child:
                                                                                Image(
                                                                              image: AssetImage(img_home),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Color(0xFFB7B7B7),
                                                                          ),
                                                                          color:
                                                                              white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                        ),
                                                                      ),
                                                          ),
                                                          SizedBox(width: 30),
                                                          Container(
                                                            width: 130,
                                                            height: 130,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFB7B7B7),
                                                              ),
                                                              color: Color(
                                                                  0xFFDCDCDC),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                            child: InkWell(
                                                              onTap: () =>
                                                                  controller
                                                                      .pickImage(),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image(
                                                                    height: 45,
                                                                    width: 45,
                                                                    image: AssetImage(
                                                                        "images/plus.png"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // child: FloatingActionButton.extended(
                                                            //   heroTag: null,
                                                            //   onPressed: () => controller.pickImage(),
                                                            //   label: Row(
                                                            //     mainAxisAlignment: MainAxisAlignment.center,
                                                            //     children: [
                                                            //       Icon(
                                                            //         Icons.upload,
                                                            //         color: white,
                                                            //       ),
                                                            //       Text("Upload Foto",
                                                            //           style: TextStyle(color: white)),
                                                            //     ],
                                                            //   ),
                                                            // ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 35,
                                                    ),
                                                    Obx(
                                                      () => InkWell(
                                                        onTap:
                                                            controller.isSaving
                                                                ? null
                                                                : () {
                                                                    if (form
                                                                        .currentState!
                                                                        .validate()) {
                                                                      controller
                                                                          .store(
                                                                              lapor);
                                                                    }
                                                                  },
                                                        child: Container(
                                                          height: 45,
                                                          width:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
                                                              end: Alignment
                                                                  .bottomRight,
                                                              colors: <Color>[
                                                                primary,
                                                                secondary,
                                                              ],
                                                            ),
                                                          ),
                                                          child: controller
                                                                  .isSaving
                                                              ? Center(
                                                                  child: Text(
                                                                    "Loading...",
                                                                    style: TextStyle(
                                                                        color:
                                                                            white),
                                                                  ),
                                                                )
                                                              : Center(
                                                                  child: Text(
                                                                    "KIRIM",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
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
                                        ],
                                      )
                                    ],
                                  ),
                                  // Obx(
                                  //   () => Container(
                                  //     width: Get.width,
                                  //     child: FloatingActionButton.extended(
                                  //         heroTag: null,
                                  //         onPressed: controller.isSaving
                                  //             ? null
                                  //             : () {
                                  //                 if (form.currentState!.validate()) {
                                  //                   controller.store(lapor);
                                  //                 }
                                  //               },
                                  //         label: controller.isSaving
                                  //             ? Text("Loading...")
                                  //             : Text("Kirim")),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 150,
                              ),
                              Container(
                                height: 200,
                                width: 200,
                                child: Lottie.asset("images/login.json",
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Silahkan Login Terlebih Dahulu",
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: InkWell(
                                      onTap: () => Get.toNamed(Routes.AUTH),
                                      child: Container(
                                        height: 45,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: <Color>[
                                              primary,
                                              secondary,
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "LOGIN",
                                            style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // child: Container(
                                    //   width: Get.width,
                                    //   child: FloatingActionButton.extended(
                                    //     heroTag: null,
                                    //     onPressed: () {
                                    //       Get.toNamed(Routes.AUTH);
                                    //     },
                                    //     label: Text("Login"),
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
              ),
      ),
    );
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
                        SizedBox(
                          height: 20,
                        ),
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
                                                image:
                                                    NetworkImage(lapor.image!),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      )
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
                                                    "images/home.png"),
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
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${lapor.nama}",
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
                              "Judul Laporan :",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                " ${lapor.judul}",
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
                        Text(
                          "Deskripsi Laporan :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${lapor.deskripsi}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(10),
          width: Get.width,
          height: 110,
          // margin: EdgeInsets.all(10),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${lapor.nama}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "${lapor.judul}",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${DateFormat.yMMMEd('id').format(lapor.waktu!)}",
                        style: TextStyle(fontSize: 12),
                      )
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
