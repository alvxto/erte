import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_domisili.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/modules/profil/controllers/profil_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../const/widget.dart';
import '../controllers/s_domisili_controller.dart';

class SDomisiliView extends StatefulWidget {
  @override
  State<SDomisiliView> createState() => _SDomisiliViewState();
}

class _SDomisiliViewState extends State<SDomisiliView> {
  SDomisiliController controller = Get.find<SDomisiliController>();

  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();

  final authC = Get.find<AuthController>();

  Domisili domisili = Domisili();

  Pengantar pengantar = Pengantar();

  Absen absen = Absen();

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRT(
        title: "Surat Domisili",
        // centerTitle: true,
      ),
      body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            // final isLastStep = currentStep == getSteps().length - 1;
            // if (isLastStep) {
            //   print('Completed');
            // } else {
            //   setState(() => currentStep += 1);
            // }
            if (currentStep <= 0) {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel: () {
            // currentStep == 0 ? null : () => setState(() => currentStep -= 1),
            if (currentStep > 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return Container(
              margin: EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  if (currentStep != 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: Text(
                        "Back",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (currentStep != 1)
                    TextButton(
                      onPressed: details.onStepContinue,
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: primary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 0,
          title: Text('Identitas'),
          subtitle: Text("Langkah 1"),
          content: Form(
            key: form,
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF757575),
                      ),
                      hintText: "Nama Lengkap Sesuai KTP",
                    ),
                    controller: controller.namaC,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                  SizedBox(height: 15),
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
                      ),
                    ),
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
                            fontSize: 14,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Divider(
                  //   color: black,
                  //   height: 9,
                  //   thickness: 9,
                  // ),
                  // Container(height: 80),
                  // SizedBox(
                  //   height: 40,
                  // ),
                ],
              ),
            ),
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.editing,
          isActive: currentStep == 1,
          title: Text('Identitas'),
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
                      "Nomor KTP",
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
                    controller: controller.nktpC,
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Email / No Telepon",
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
                  // FloatingActionButton(
                  //   onPressed: () => controller.getPDF(),
                  //   child: Icon(Icons.note),
                  // ),
                  SizedBox(height: 50),
                  Obx(
                    () => InkWell(
                      onTap: controller.isSaving
                          ? null
                          : () {
                              if (form.currentState!.validate() &
                                  form1.currentState!.validate()) {
                                controller.store(domisili);
                                controller.storeabsen(absen);
                                controller.storepengantar(pengantar);
                                controller.getPDF(domisili);
                                // controller.storepengantar(pengantar);
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
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        // Step(
        //   isActive: currentStep >= 2,
        //   title: Text('Complete'),
        //   content: Container(),
        // ),
      ];
}
