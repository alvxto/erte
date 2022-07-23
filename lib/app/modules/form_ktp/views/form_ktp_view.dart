import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/database.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_ktp.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/modules/form_ktp/controllers/form_ktp_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../const/widget.dart';
import '../controllers/form_ktp_controller.dart';

class FormKtpView extends StatefulWidget {
  @override
  State<FormKtpView> createState() => _FormKtpViewState();
}

class _FormKtpViewState extends State<FormKtpView> {
  FormKtpController controller = Get.find<FormKtpController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KTP ktp = KTP();

  Absen absen = Absen();

  Pengantar pengantar = Pengantar();

  int currentStep = 0;

  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    // controller.modelToController(ktp);
    return Scaffold(
      appBar: AppBarRT(
        title: "Form KTP",
      ),
      body: Stepper(
        type: StepperType.horizontal,
        steps: buildStep(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == buildStep().length - 1;

          if (isLastStep) {
            setState(() => isCompleted = true);
            print("Terkirim");
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepTapped: (step) => setState(() => currentStep),
        onStepCancel:
            currentStep == 0 ? null : () => setState(() => currentStep -= 1),
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep != 0)
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (currentStep != 2)
                  TextButton(
                    onPressed: details.onStepContinue,
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Step> buildStep() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 0,
          title: Text("Identitas"),
          subtitle: Text("Langkah 1"),
          content: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                    controller: controller.namaC,
                  ),
                  15.height,
                  FormField<String>(
                    validator: (value) => controller.selectedKelamin.isNotEmpty
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
                            borderRadius: BorderRadius.circular(10)),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin,
                                    onChanged: (value) => controller
                                        .selectedKelamin = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin,
                                    onChanged: (value) => controller
                                        .selectedKelamin = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (kelamin.hasError)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  kelamin.errorText!,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.done,
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
                  15.height,
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async => await controller.tanggalLahir(context),
                      title: Text(
                        "Tanggal Lahir",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Obx(
                          () => Text(
                            controller.selectedTanggal is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggal!)
                                : '--',
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )),
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
                  DropdownSearch<String>(
                    validator: (value) => controller.selectedAgama != null
                        ? null
                        : "This field is required",
                    items: controller.listAgama,
                    onChanged: (value) => controller.selectedAgama = value,
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
                  15.height,
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
                  DropdownSearch<String>(
                    validator: (value) => controller.selectedStatus != null
                        ? null
                        : "This field is required",
                    items: controller.listStatus,
                    onChanged: (value) => controller.selectedStatus = value,
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
                  ),
                  15.height,
                  FormField<String>(
                    validator: (value) => controller.selectedWNI.isNotEmpty
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "WNI",
                                    groupValue: controller.selectedWNI,
                                    onChanged: (value) =>
                                        controller.selectedWNI = value ?? '',
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
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "WNA",
                                    groupValue: controller.selectedWNI,
                                    onChanged: (value) =>
                                        controller.selectedWNI = value ?? '',
                                    title: Text(
                                      "WNA",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (wni.hasError)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  wni.errorText!,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  15.height,
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 1,
          title: Text("Addres"),
          subtitle: Text("Langkah 2"),
          content: Form(
            key: form1,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  DropdownSearch<String>(
                    validator: (value) => controller.selectGoldarah != null
                        ? null
                        : "This field is required",
                    items: controller.listGoldarah,
                    onChanged: (value) => controller.selectGoldarah = value,
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
                  ),
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    minLines: 1,
                    maxLines: 5,
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
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
                    controller: controller.kecamatanC,
                  ),
                  15.height,
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
                  DropdownSearch<String>(
                    validator: (value) => controller.selectedPendidikan != null
                        ? null
                        : "This field is required",
                    items: controller.listPendidikan,
                    onChanged: (value) => controller.selectedPendidikan = value,
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
                  ),
                  15.height,
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
                  AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.done,
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
                  15.height,
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 2,
          title: Text("Confirm"),
          subtitle: Text("Langkah 3"),
          content: Form(
            key: form2,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    controller: controller.emailC,
                  ),
                  15.height,
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Upload Foto",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  5.height,
                  Obx(() => controller.imagePath.value != ''
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            child: FloatingActionButton.extended(
                              backgroundColor: Colors.transparent,
                              heroTag: null,
                              onPressed: () => controller.pickImage(),
                              label: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload,
                                    color: white,
                                  ),
                                  Text("Ganti Foto",
                                      style: TextStyle(color: white)),
                                ],
                              ),
                            ),
                            height: 200,
                            width: 400,
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
                                image: DecorationImage(
                                    image: FileImage(
                                        File(controller.imagePath.value)),
                                    fit: BoxFit.cover)),
                          ))
                      : ktp.image != null
                          ? Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 200,
                                width: 400,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(ktp.image!),
                                        fit: BoxFit.cover)),
                              ))
                          : Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: 400,
                                height: 200,
                                child: Center(
                                  child: InkWell(
                                    onTap: () => controller.pickImage(),
                                    child: Image.asset(
                                      ("images/uploading.png"),
                                      width: 91,
                                      height: 80,
                                    ),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  color: Color(0xFFD6D7FD),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )),
                  SizedBox(
                    height: 40,
                  ),

                  // DropdownSearch<String>(
                  //   items: controller.listKeperluan1,
                  //   onChanged: (value) => controller.selectedKeperluan1 = value,
                  //   mode: Mode.MENU,
                  //   dropdownSearchDecoration: InputDecoration(
                  //     labelText: "Keperluan 1",
                  //     contentPadding: EdgeInsets.zero,
                  //   ),
                  //   selectedItem: controller.selectedKeperluan1,
                  // ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // DropdownSearch<String>(
                  //   items: controller.listKeperluan2,
                  //   onChanged: (value) => controller.selectedKeperluan2 = value,
                  //   mode: Mode.MENU,
                  //   dropdownSearchDecoration: InputDecoration(
                  //     labelText: "Keperluan 2",
                  //     contentPadding: EdgeInsets.zero,
                  //   ),
                  //   selectedItem: controller.selectedKeperluan2,
                  // ),
                  Obx(
                    () => InkWell(
                      onTap: controller.isSaving
                          ? null
                          : () {
                              if (form.currentState!.validate() &
                                  form1.currentState!.validate() &
                                  form2.currentState!.validate()) {
                                controller.store(ktp);
                                controller.storeabsen(absen);
                              }
                            },
                      child: Container(
                        height: 45,
                        width: Get.width,
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
                        child: controller.isSaving
                            ? Center(
                                child: Text(
                                  "Loading...",
                                  style: TextStyle(color: white),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "KIRIM",
                                  style: TextStyle(
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                  10.height,
                ],
              ),
            ),
          ),
        ),
      ];
}
