import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:badges/badges.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../const/color.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  UserModel user = Get.arguments ?? UserModel();
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    controller.modelToController(authC.user);
    return Scaffold(
      floatingActionButton: Obx(() => controller.edit.value == false
          ? FloatingActionButton(
              heroTag: null,
              onPressed: () {
                controller.edit.value = true;
                if (controller.edit.value == true) {
                  Get.defaultDialog(
                      title: "Mode Edit",
                      titleStyle: TextStyle(color: primary),
                      middleText: "Mode Edit Aktif",
                      middleTextStyle: TextStyle(color: primary),
                      textConfirm: "Oke",
                      onConfirm: () => Get.back(),
                      confirmTextColor: white,
                      buttonColor: primary);
                }
              },
              child: Icon(Icons.edit, color: white),
            )
          : Container()),
      backgroundColor: background,
      appBar: AppBarRT(title: "Profil"),
      body: authC.user.id == null
          ? Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child:
                          Lottie.asset("images/login.json", fit: BoxFit.cover),
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
                                borderRadius: BorderRadius.circular(15),
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
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: radiusCircular(10),
                          topRight: radiusCircular(10),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            primary,
                            secondary,
                            Color(0xFF00223F),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: form,
                    child: Center(
                      child: Column(children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                Obx(
                                  () => controller.imagePath.value != ''
                                      ? AvatarGlow(
                                          endRadius: 50.0,
                                          glowColor:
                                              Color.fromARGB(255, 24, 76, 248),
                                          duration: Duration(seconds: 2),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 90,
                                                width: 90,
                                                decoration: BoxDecoration(
                                                  color: white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90 / 2),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (controller.edit == true) {
                                                    controller.pickImage();
                                                  } else {
                                                    Get.defaultDialog(
                                                        title: "Peringatan",
                                                        middleText:
                                                            "Hidupkan Mode Edit Terlebih Dahulu",
                                                        titleStyle: TextStyle(
                                                            color: primary),
                                                        middleTextStyle:
                                                            TextStyle(
                                                                color: primary),
                                                        onConfirm: () =>
                                                            Get.back(),
                                                        buttonColor: primary,
                                                        textConfirm: "Oke",
                                                        confirmTextColor:
                                                            white);
                                                  }
                                                },
                                                child: Badge(
                                                  badgeColor: white,
                                                  position:
                                                      BadgePosition.bottomEnd(),
                                                  badgeContent: Icon(
                                                    Icons
                                                        .camera_enhance_outlined,
                                                    color: primary,
                                                  ),
                                                  child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(File(
                                                              controller
                                                                  .imagePath
                                                                  .value)),
                                                          fit: BoxFit.cover),
                                                      // border: Border.all(
                                                      //     color: white,
                                                      //     width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90 / 2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : authC.user.image != null
                                          ? AvatarGlow(
                                              endRadius: 50.0,
                                              glowColor: Color.fromARGB(
                                                  255, 24, 76, 248),
                                              duration: Duration(seconds: 2),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 90,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90 / 2),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (controller.edit ==
                                                          true) {
                                                        controller.pickImage();
                                                      } else {
                                                        Get.defaultDialog(
                                                            title: "Peringatan",
                                                            middleText:
                                                                "Hidupkan Mode Edit Terlebih Dahulu",
                                                            titleStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            middleTextStyle:
                                                                TextStyle(
                                                                    color:
                                                                        primary),
                                                            onConfirm: () =>
                                                                Get.back(),
                                                            buttonColor:
                                                                primary,
                                                            textConfirm: "Oke",
                                                            confirmTextColor:
                                                                white);
                                                      }
                                                    },
                                                    child: Badge(
                                                      badgeColor: white,
                                                      position: BadgePosition
                                                          .bottomEnd(),
                                                      badgeContent: Icon(
                                                        Icons
                                                            .camera_enhance_outlined,
                                                        color: primary,
                                                      ),
                                                      child: Container(
                                                        height: 80,
                                                        width: 80,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  authC.user
                                                                      .image!),
                                                              fit:
                                                                  BoxFit.cover),
                                                          // border: Border.all(
                                                          //     color:
                                                          //         white,
                                                          //     width: 3),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      90 / 2),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : AvatarGlow(
                                              endRadius: 50.0,
                                              glowColor: Color.fromARGB(
                                                  255, 24, 76, 248),
                                              duration: Duration(seconds: 2),
                                              child: InkWell(
                                                onTap: () {
                                                  if (controller.edit == true) {
                                                    controller.pickImage();
                                                  } else {
                                                    Get.defaultDialog(
                                                        title: "Peringatan",
                                                        middleText:
                                                            "Hidupkan Mode Edit Terlebih Dahulu",
                                                        titleStyle: TextStyle(
                                                            color: primary),
                                                        middleTextStyle:
                                                            TextStyle(
                                                                color: primary),
                                                        onConfirm: () =>
                                                            Get.back(),
                                                        buttonColor: primary,
                                                        textConfirm: "Oke",
                                                        confirmTextColor:
                                                            white);
                                                  }
                                                },
                                                child: Badge(
                                                  badgeColor: white,
                                                  position:
                                                      BadgePosition.bottomEnd(),
                                                  badgeContent: Icon(
                                                    Icons
                                                        .camera_enhance_outlined,
                                                    color: primary,
                                                  ),
                                                  child: Container(
                                                    height: 80,
                                                    width: 80,
                                                    child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        child: Image.asset(
                                                          "images/profil.png",
                                                          fit: BoxFit.cover,
                                                        )),
                                                    decoration: BoxDecoration(
                                                      // image: DecorationImage(
                                                      //     image: FileImage(
                                                      //         File(controller
                                                      //             .imagePath
                                                      //             .value)),
                                                      //     fit: BoxFit.cover),
                                                      border: Border.all(
                                                          color: white,
                                                          width: 3),
                                                      color: white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90 / 2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Center(
                            child: Obx(
                              () => SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  authC.user.nama!,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                            child: Obx(() => Text(
                                  authC.user.email!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ))),
                        SizedBox(
                          height: 10,
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Center(
                        //     child: Text(
                        //   "User Profile",
                        //   style: TextStyle(fontSize: 30),
                        // )),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Nama",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(fontSize: 14),
                                textFieldType: TextFieldType.NAME,
                                showCursor: true,
                                enabled: controller.edit.value,
                                textInputAction: TextInputAction.next,
                                controller: controller.namaC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FormField<String>(
                              validator: (value) =>
                                  controller.selectedKelamin.isNotEmpty
                                      ? null
                                      : "This field is required",
                              builder: (kelamin) => Obx(
                                () => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    "Jenis Kelamin",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  subtitle: Column(
                                    children: [
                                      controller.edit.value == true
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<String>(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    selectedTileColor: primary,
                                                    activeColor: primary,
                                                    toggleable: true,
                                                    value: "Laki-Laki",
                                                    groupValue: controller
                                                        .selectedKelamin,
                                                    onChanged: (value) =>
                                                        controller
                                                                .selectedKelamin =
                                                            value ?? '',
                                                    title: Text(
                                                      "Laki-Laki",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<String>(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    selectedTileColor: primary,
                                                    activeColor: primary,
                                                    toggleable: true,
                                                    value: "Perempuan",
                                                    groupValue: controller
                                                        .selectedKelamin,
                                                    onChanged: (value) =>
                                                        controller
                                                                .selectedKelamin =
                                                            value ?? '',
                                                    title: Text(
                                                      "Perempuan",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : controller.selectedKelamin == ''
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kelamin belum diisi",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, left: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .selectedKelamin,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                      if (kelamin.hasError)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            kelamin.errorText!,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Tempat Lahir",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(fontSize: 14),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.NAME,
                                textInputAction: TextInputAction.next,
                                controller: controller.tempatC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                enabled: controller.edit.value,
                                leading: Container(
                                  width: 24,
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.calendar_month,
                                    size: 30,
                                    color: black,
                                  ),
                                ),
                                onTap: () async =>
                                    await controller.tanggalLahir(context),
                                title: Text(
                                  "Tanggal Lahir",
                                  style: TextStyle(
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Obx(
                                  () => Text(
                                    controller.selectedTanggal is DateTime
                                        ? DateFormat("EEE, dd MMM y", 'id')
                                            .format(controller.selectedTanggal!)
                                        : '--',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Agama",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => DropdownSearch<String>(
                                validator: (value) =>
                                    controller.selectedAgama != null
                                        ? null
                                        : "This field is required",
                                enabled: controller.edit.value,
                                items: controller.listAgama,
                                onChanged: (value) =>
                                    controller.selectedAgama = value,
                                mode: Mode.MENU,
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                                selectedItem: controller.selectedAgama,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(() => DropdownSearch<String>(
                                  validator: (value) =>
                                      controller.selectedStatus != null
                                          ? null
                                          : "This field is required",
                                  enabled: controller.edit.value,
                                  items: controller.listStatus,
                                  onChanged: (value) =>
                                      controller.selectedStatus = value,
                                  mode: Mode.MENU,
                                  dropdownSearchDecoration: InputDecoration(
                                    fillColor: Color(0xFFD6D7FD),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10),
                                  ),
                                  selectedItem: controller.selectedStatus,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            FormField<String>(
                              validator: (value) =>
                                  controller.selectedWNI.isNotEmpty
                                      ? null
                                      : "This field is required",
                              builder: (wni) => Obx(
                                () => ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                  title: Text(
                                    "Kewarganegaraan",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  subtitle: Column(
                                    children: [
                                      controller.edit.value == true
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: RadioListTile<String>(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    selectedTileColor: primary,
                                                    activeColor: primary,
                                                    toggleable: true,
                                                    value: "WNI",
                                                    groupValue:
                                                        controller.selectedWNI,
                                                    onChanged: (value) =>
                                                        controller.selectedWNI =
                                                            value ?? '',
                                                    title: Text(
                                                      "WNI",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: RadioListTile<String>(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    selectedTileColor: primary,
                                                    activeColor: primary,
                                                    toggleable: true,
                                                    value: "WNA",
                                                    groupValue:
                                                        controller.selectedWNI,
                                                    onChanged: (value) =>
                                                        controller.selectedWNI =
                                                            value ?? '',
                                                    title: Text(
                                                      "WNA",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : controller.selectedWNI == ''
                                              ? Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Kewarganegaraan belum diisi",
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15, left: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        controller.selectedWNI,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                      if (wni.hasError)
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            wni.errorText!,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 12),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Pendidikan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(() => DropdownSearch<String>(
                                  validator: (value) =>
                                      controller.selectedPendidikan != null
                                          ? null
                                          : "This field is required",
                                  enabled: controller.edit.value,
                                  items: controller.listPendidikan,
                                  onChanged: (value) =>
                                      controller.selectedPendidikan = value,
                                  mode: Mode.MENU,
                                  dropdownSearchDecoration: InputDecoration(
                                    fillColor: Color(0xFFD6D7FD),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10),
                                  ),
                                  selectedItem: controller.selectedPendidikan,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Golongan Darah",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(() => DropdownSearch<String>(
                                  validator: (value) =>
                                      controller.selectGoldarah != ''
                                          ? null
                                          : "This field is required",
                                  enabled: controller.edit.value,
                                  items: controller.listGoldarah,
                                  onChanged: (value) =>
                                      controller.selectGoldarah = value,
                                  mode: Mode.MENU,
                                  dropdownSearchDecoration: InputDecoration(
                                    fillColor: Color(0xFFD6D7FD),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: EdgeInsets.only(left: 10),
                                  ),
                                  selectedItem: controller.selectGoldarah,
                                )),
                            SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Pekerjaan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.NAME,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.pekerjaanC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "NIK",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.nikC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "No KK",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.kkC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Alamat",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.NAME,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.alamatC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "RT",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.rtC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "RW",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.rwC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Kelurahan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.NAME,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.kelurahanC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Kecamatan",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Obx(
                              () => AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                enabled: controller.edit.value,
                                textFieldType: TextFieldType.NAME,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.kecamatanC,
                              ),
                            ),
                            SizedBox(height: 15),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            AppTextField(
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                              textFieldType: TextFieldType.EMAIL,
                              enabled: false,
                              showCursor: true,
                              controller: controller.emailC,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Color(0xFFD6D7FD),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                              title: Text(
                                "Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            AppTextField(
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                              enabled: false,
                              readOnly: true,
                              showCursor: true,
                              textFieldType: TextFieldType.PASSWORD,
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.passC,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Color(0xFFD6D7FD),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                hintText: "Input your password",
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ]),
                        ),
                        Obx(
                          () => controller.edit.value == true
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          primary,
                                          secondary,
                                        ],
                                      ),
                                    ),
                                    width: Get.width,
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.transparent,
                                      heroTag: null,
                                      onPressed: controller.isSaving
                                          ? null
                                          : () {
                                              if (form.currentState!
                                                  .validate()) {
                                                if (controller.edit == true) {
                                                  controller.store(authC.user);
                                                  controller.edit.value = false;
                                                } else {
                                                  Get.defaultDialog(
                                                      title: "Peringatan",
                                                      middleText:
                                                          "Hidupkan Mode Edit Terlebih Dahulu",
                                                      titleStyle: TextStyle(
                                                          color: primary),
                                                      middleTextStyle:
                                                          TextStyle(
                                                              color: primary),
                                                      onConfirm: () =>
                                                          Get.back(),
                                                      buttonColor: primary,
                                                      textConfirm: "Oke",
                                                      confirmTextColor: white);
                                                }
                                              }
                                            },
                                      label: controller.isSaving
                                          ? Text(
                                              "Loading...",
                                            )
                                          : Text(
                                              "SIMPAN",
                                            ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
