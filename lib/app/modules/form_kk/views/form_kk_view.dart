import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_kk.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/form_kk_controller.dart';

class FormKkView extends StatefulWidget {
  @override
  State<FormKkView> createState() => _FormKkViewState();
}

class _FormKkViewState extends State<FormKkView> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),

                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView2(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 2",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  FormField<String>(
                    validator: (value) =>
                        controller.selectedDataKeluarga.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (datakeluarga) => Obx(
                      () => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Pilih Salah Satu :",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
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
                                    value: "Keluarga WNI",
                                    groupValue: controller.selectedDataKeluarga,
                                    onChanged: (value) => controller
                                        .selectedDataKeluarga = value ?? '',
                                    title: Text(
                                      "Keluarga WNI",
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
                                    value: "Keluarga WNA",
                                    groupValue: controller.selectedDataKeluarga,
                                    onChanged: (value) => controller
                                        .selectedDataKeluarga = value ?? '',
                                    title: Text(
                                      "Keluarga WNA",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (datakeluarga.hasError)
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(datakeluarga.errorText!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12)))
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nama Kepala Keluarga",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.all(10)),
                      controller: controller.namakepalaC),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.all(10)),
                      controller: controller.alamatC),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Kode Pos",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 168,
                        child: AppTextField(
                          textStyle: TextStyle(
                            fontSize: 14,
                          ),
                          textFieldType: TextFieldType.PHONE,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            fillColor: Color(0xFFD6D7FD),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: EdgeInsets.all(10),
                          ),
                          controller: controller.kodeposC,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "RT",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                        width: 168,
                        child: AppTextField(
                            textStyle: TextStyle(
                              fontSize: 14,
                            ),
                            textFieldType: TextFieldType.PHONE,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFD6D7FD),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.all(10)),
                            controller: controller.rtC))
                  ]),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "RW",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                        width: 168,
                        child: AppTextField(
                            textStyle: TextStyle(
                              fontSize: 14,
                            ),
                            textFieldType: TextFieldType.PHONE,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFD6D7FD),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.all(10)),
                            controller: controller.rwC))
                  ]),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jumlah Anggota Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                        width: 168,
                        child: AppTextField(
                            textStyle: TextStyle(
                              fontSize: 14,
                            ),
                            textFieldType: TextFieldType.PHONE,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFD6D7FD),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                contentPadding: EdgeInsets.all(10)),
                            controller: controller.jumkeluargaC))
                  ]),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Telepon",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.PHONE,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.all(10)),
                      controller: controller.teleponC),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkapC),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepanC),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakangC),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopasporC),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsorC),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor,
                      onChanged: (value) => controller.selectedSponsor = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsorC)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
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
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
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
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempatC,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraanC,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowaliC,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir,
                                    onChanged: (value) => controller
                                        .selectedAktalahir = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir,
                                    onChanged: (value) => controller
                                        .selectedAktalahir = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahirC,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah,
                          onChanged: (value) =>
                              controller.selectGoldarah = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama,
                          onChanged: (value) =>
                              controller.selectedAgama = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagamaC,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus,
                          onChanged: (value) =>
                              controller.selectedStatus = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin,
                                    onChanged: (value) => controller
                                        .selectedAktakawin = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin,
                                    onChanged: (value) => controller
                                        .selectedAktakawin = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawinC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai,
                                    onChanged: (value) => controller
                                        .selectedAktacerai = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai,
                                    onChanged: (value) => controller
                                        .selectedAktacerai = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktaceraiC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan,
                    onChanged: (value) => controller.selectedHubungan = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat,
                                    onChanged: (value) =>
                                        controller.selectedCacat = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat,
                                    onChanged: (value) =>
                                        controller.selectedCacat = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat,
                    onChanged: (value) => controller.selectedJenisCacat = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan,
                    onChanged: (value) => controller.selectedPendidikan = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -1",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan,
                    onChanged: (value) => controller.selectedPekerjaan = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -2",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan2,
                    onChanged: (value) => controller.selectedPekerjaan2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan2),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -3",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan3,
                    onChanged: (value) => controller.selectedPekerjaan3 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan3),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -4",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan4,
                    onChanged: (value) => controller.selectedPekerjaan4 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan4),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -5",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan5,
                    onChanged: (value) => controller.selectedPekerjaan5 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan5),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -6",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan6,
                    onChanged: (value) => controller.selectedPekerjaan6 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan6),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan Orang ke -7",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan7,
                    onChanged: (value) => controller.selectedPekerjaan7 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan7),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitasC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItasC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalItas(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertamaC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalPertama(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibuC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibuC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayahC),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayahC),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) => controller.selectedWNI.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (wni) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kewarganegaraan",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
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
                                    ))),
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
                                    title: Text("WNA",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ))))
                          ]),
                          if (wni.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(wni.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.emailC),

                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(context,
                //         MaterialPageRoute(builder: (context) => FormKkView2()));
                //   },
                //   child: Text("Form KK 2"),
                // ),
              ])),
            ))
      ];
}

class FormKkView2 extends StatefulWidget {
  @override
  State<FormKkView2> createState() => _FormKkView2State();
}

class _FormKkView2State extends State<FormKkView2> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 2'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView3(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 3",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -2",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap2C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan2C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang2C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor2C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor2(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor2 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor2!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor2C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor2,
                      onChanged: (value) => controller.selectedSponsor2 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor2),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor2C)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin2.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin2,
                                    onChanged: (value) => controller
                                        .selectedKelamin2 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin2,
                                    onChanged: (value) => controller
                                        .selectedKelamin2 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat2C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir2(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir2 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir2!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan2C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali2C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir2.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir2,
                                    onChanged: (value) => controller
                                        .selectedAktalahir2 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir2,
                                    onChanged: (value) => controller
                                        .selectedAktalahir2 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir2C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah2,
                          onChanged: (value) =>
                              controller.selectGoldarah2 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah2))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama2,
                          onChanged: (value) =>
                              controller.selectedAgama2 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama2))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama2C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus2,
                          onChanged: (value) =>
                              controller.selectedStatus2 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus2))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin2.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin2,
                                    onChanged: (value) => controller
                                        .selectedAktakawin2 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin2,
                                    onChanged: (value) => controller
                                        .selectedAktakawin2 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin2(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin2 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin2!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai2.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai2,
                                    onChanged: (value) => controller
                                        .selectedAktacerai2 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai2,
                                    onChanged: (value) => controller
                                        .selectedAktacerai2 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai2(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai2 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai2!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan2,
                    onChanged: (value) => controller.selectedHubungan2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan2)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat2.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat2,
                                    onChanged: (value) =>
                                        controller.selectedCacat2 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat2,
                                    onChanged: (value) =>
                                        controller.selectedCacat2 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat2,
                    onChanged: (value) =>
                        controller.selectedJenisCacat2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat2),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan2,
                    onChanged: (value) =>
                        controller.selectedPendidikan2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan2),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan2,
                    onChanged: (value) => controller.selectedPekerjaan2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan2),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas2(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas2 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas2!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalItas2(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas2 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas2!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama2(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama2 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama2!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah2C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah2C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}

class FormKkView3 extends StatefulWidget {
  @override
  State<FormKkView3> createState() => _FormKkView3State();
}

class _FormKkView3State extends State<FormKkView3> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 3'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView4(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 4",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -3",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap3C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan3C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang3C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor3C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor3(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor3 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor3!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor3C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor3,
                      onChanged: (value) => controller.selectedSponsor3 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor3),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor3C)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin3.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin3,
                                    onChanged: (value) => controller
                                        .selectedKelamin3 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin3,
                                    onChanged: (value) => controller
                                        .selectedKelamin3 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat3C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir3(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir3 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir3!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan3C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali3C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir3.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir3,
                                    onChanged: (value) => controller
                                        .selectedAktalahir3 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir3,
                                    onChanged: (value) => controller
                                        .selectedAktalahir3 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir3C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah3,
                          onChanged: (value) =>
                              controller.selectGoldarah3 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah3))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama3,
                          onChanged: (value) =>
                              controller.selectedAgama3 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama3))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama3C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus3,
                          onChanged: (value) =>
                              controller.selectedStatus3 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus3))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin3.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin3,
                                    onChanged: (value) => controller
                                        .selectedAktakawin3 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin3,
                                    onChanged: (value) => controller
                                        .selectedAktakawin3 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin3(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin3 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin3!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai3.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai3,
                                    onChanged: (value) => controller
                                        .selectedAktacerai3 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai3,
                                    onChanged: (value) => controller
                                        .selectedAktacerai3 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai3(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai3 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai3!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan3,
                    onChanged: (value) => controller.selectedHubungan3 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan3)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat3.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat3,
                                    onChanged: (value) =>
                                        controller.selectedCacat3 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat3,
                                    onChanged: (value) =>
                                        controller.selectedCacat3 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat3,
                    onChanged: (value) =>
                        controller.selectedJenisCacat3 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat3),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan3,
                    onChanged: (value) =>
                        controller.selectedPendidikan3 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan3),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan3,
                    onChanged: (value) => controller.selectedPekerjaan3 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan3),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas3(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas3 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas3!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalItas3(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas3 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas3!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama3(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama3 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama3!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah3C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah3C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}

class FormKkView4 extends StatefulWidget {
  @override
  State<FormKkView4> createState() => _FormKkView4State();
}

class _FormKkView4State extends State<FormKkView4> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 4'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView5(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 5",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -4",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap4C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan4C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang4C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor4C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor4(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor4 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor4!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor4C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor4,
                      onChanged: (value) => controller.selectedSponsor4 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor4),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor4C)
                ])))),
        Step( 
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin4.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin4,
                                    onChanged: (value) => controller
                                        .selectedKelamin4 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin4,
                                    onChanged: (value) => controller
                                        .selectedKelamin4 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat4C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir4(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir4 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir4!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan4C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali4C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir4.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir4,
                                    onChanged: (value) => controller
                                        .selectedAktalahir4 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir4,
                                    onChanged: (value) => controller
                                        .selectedAktalahir4 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir4C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah4,
                          onChanged: (value) =>
                              controller.selectGoldarah4 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah4))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama4,
                          onChanged: (value) =>
                              controller.selectedAgama4 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama4))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama4C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus4,
                          onChanged: (value) =>
                              controller.selectedStatus4 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus4))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin4.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin4,
                                    onChanged: (value) => controller
                                        .selectedAktakawin4 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin4,
                                    onChanged: (value) => controller
                                        .selectedAktakawin4 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin4(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin4 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin4!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai4.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai4,
                                    onChanged: (value) => controller
                                        .selectedAktacerai4 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai4,
                                    onChanged: (value) => controller
                                        .selectedAktacerai4 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai4(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai4 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai4!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan4,
                    onChanged: (value) => controller.selectedHubungan4 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan4)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat4.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat4,
                                    onChanged: (value) =>
                                        controller.selectedCacat4 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat4,
                                    onChanged: (value) =>
                                        controller.selectedCacat4 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat4,
                    onChanged: (value) =>
                        controller.selectedJenisCacat4 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat4),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan4,
                    onChanged: (value) =>
                        controller.selectedPendidikan4 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan4),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan4,
                    onChanged: (value) => controller.selectedPekerjaan4 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan4),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas4(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas4 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas4!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 45,
                        )),
                    onTap: () async => await controller.tanggalItas4(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas4 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas4!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama4(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama4 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama4!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah4C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah4C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}

class FormKkView5 extends StatefulWidget {
  @override
  State<FormKkView5> createState() => _FormKkView5State();
}

class _FormKkView5State extends State<FormKkView5> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 5'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView6(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 6",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -5",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap5C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan5C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang5C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor5C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor5(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor5 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor5!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor5C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor5,
                      onChanged: (value) => controller.selectedSponsor5 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor5),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor5C)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin5.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin5,
                                    onChanged: (value) => controller
                                        .selectedKelamin5 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin5,
                                    onChanged: (value) => controller
                                        .selectedKelamin5 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat5C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir5(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir5 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir5!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan5C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali5C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir5.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir5,
                                    onChanged: (value) => controller
                                        .selectedAktalahir5 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir5,
                                    onChanged: (value) => controller
                                        .selectedAktalahir5 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir5C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah5,
                          onChanged: (value) =>
                              controller.selectGoldarah5 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah5))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama5,
                          onChanged: (value) =>
                              controller.selectedAgama5 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama5))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama5C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus5,
                          onChanged: (value) =>
                              controller.selectedStatus5 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus5))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin5.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin5,
                                    onChanged: (value) => controller
                                        .selectedAktakawin5 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin5,
                                    onChanged: (value) => controller
                                        .selectedAktakawin5 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin5(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin5 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin5!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai5.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai5,
                                    onChanged: (value) => controller
                                        .selectedAktacerai5 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai5,
                                    onChanged: (value) => controller
                                        .selectedAktacerai5 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai5(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai5 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai5!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan5,
                    onChanged: (value) => controller.selectedHubungan5 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan5)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat5.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat5,
                                    onChanged: (value) =>
                                        controller.selectedCacat5 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat5,
                                    onChanged: (value) =>
                                        controller.selectedCacat5 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat5,
                    onChanged: (value) =>
                        controller.selectedJenisCacat5 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat5),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan5,
                    onChanged: (value) =>
                        controller.selectedPendidikan5 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan5),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan5,
                    onChanged: (value) => controller.selectedPekerjaan5 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan5),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas5(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas5 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas5!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 45,
                        )),
                    onTap: () async => await controller.tanggalItas5(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas5 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas5!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama5(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama5 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama5!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah5C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah5C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}

class FormKkView6 extends StatefulWidget {
  @override
  State<FormKkView6> createState() => _FormKkView6State();
}

class _FormKkView6State extends State<FormKkView6> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 6'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        if (currentStep == 2)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormKkView7(),
                                ),
                              );
                            },
                            child: Text(
                              "Lanjutkan Anggota ke 7",
                              style: TextStyle(
                                fontSize: 16,
                                color: primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -6",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap6C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan6C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang6C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor6C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor6(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor6 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor6!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor6C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor6,
                      onChanged: (value) => controller.selectedSponsor6 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor6),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor6C)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin6.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin6,
                                    onChanged: (value) => controller
                                        .selectedKelamin6 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin6,
                                    onChanged: (value) => controller
                                        .selectedKelamin6 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat6C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir6(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir6 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir6!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan6C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali6C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir6.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir,
                                    onChanged: (value) => controller
                                        .selectedAktalahir6 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir6,
                                    onChanged: (value) => controller
                                        .selectedAktalahir6 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir6C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah6,
                          onChanged: (value) =>
                              controller.selectGoldarah6 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah6))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama6,
                          onChanged: (value) =>
                              controller.selectedAgama6 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama6))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama6C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus6,
                          onChanged: (value) =>
                              controller.selectedStatus6 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus6))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin6.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin6,
                                    onChanged: (value) => controller
                                        .selectedAktakawin6 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin6,
                                    onChanged: (value) => controller
                                        .selectedAktakawin6 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin6(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin6 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin6!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai6.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai6,
                                    onChanged: (value) => controller
                                        .selectedAktacerai6 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai6,
                                    onChanged: (value) => controller
                                        .selectedAktacerai6 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai6(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai6 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai6!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan6,
                    onChanged: (value) => controller.selectedHubungan6 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan6)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat6.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat6,
                                    onChanged: (value) =>
                                        controller.selectedCacat6 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat6,
                                    onChanged: (value) =>
                                        controller.selectedCacat6 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat6,
                    onChanged: (value) =>
                        controller.selectedJenisCacat6 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat6),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan6,
                    onChanged: (value) =>
                        controller.selectedPendidikan6 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan6),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan6,
                    onChanged: (value) => controller.selectedPekerjaan6 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan6),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas6(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas6 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas6!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 45,
                        )),
                    onTap: () async => await controller.tanggalItas6(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas6 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas6!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama6(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama6 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama6!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah6C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah6C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}

class FormKkView7 extends StatefulWidget {
  @override
  State<FormKkView7> createState() => _FormKkView7State();
}

class _FormKkView7State extends State<FormKkView7> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                  Color(0xFF696EFF),
                  Color(0xFF000DFF),
                ]))),
            title: Text('Form KK 7'),
            leading: InkWell(
                onTap: () => Get.back(),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                ))),
        body: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: currentStep,
            onStepContinue: () {
              final isLastStep = currentStep == getSteps().length - 1;

              if (isLastStep) {
                setState(() => isCompleted = true);
                print("Terkirim");
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepTapped: (step) => setState(() => currentStep),
            onStepCancel: currentStep == 0
                ? null
                : () => setState(() => currentStep -= 1),
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (currentStep != 0)
                          TextButton(
                              onPressed: details.onStepCancel,
                              child: Text("Back",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                  ))),
                        // if (currentStep == 2)
                        //   TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => FormKkView7(),
                        //         ),
                        //       );
                        //     },
                        //     child: Text(
                        //       "Lanjutkan Anggota ke 7",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         color: primary,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ),
                        // InkWell(
                        //   onTap: details.onStepCancel,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "KEMBALI",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: white,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        if (currentStep != 2)
                          TextButton(
                              onPressed: details.onStepContinue,
                              child: Text("Next",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: primary,
                                      fontWeight: FontWeight.bold))),
                        // InkWell(
                        //   onTap: details.onStepContinue,
                        //   child: Container(
                        //     width: 134,
                        //     height: 43,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20),
                        //       gradient: LinearGradient(
                        //         begin: Alignment.topLeft,
                        //         end: Alignment.bottomRight,
                        //         colors: <Color>[
                        //           primary,
                        //           secondary,
                        //         ],
                        //       ),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         "Next",
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: primary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ]));
            }));
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 0,
            title: Text("Identitas"),
            subtitle: Text("Langkah 1"),
            content: Form(
                key: form,
                child: SingleChildScrollView(
                    child: Column(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Anggota Keluarga ke -7",
                      style: TextStyle(
                        fontSize: 15,
                        color: redColor,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Lengkap Sesuai KTP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namalengkap7C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Depan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelardepan7C),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Gelar Belakang",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.gelarbelakang7C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Paspor",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      )),
                  AppTextField(
                      textStyle: TextStyle(
                        fontSize: 14,
                      ),
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.nopaspor7C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                          width: 24,
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.calendar_month,
                            color: black,
                            size: 35,
                          )),
                      onTap: () async =>
                          await controller.tanggalPaspor7(context),
                      title: Text("Tanggal Berakhir Paspor",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Obx(() => Text(
                            controller.selectedTanggalpaspor7 is DateTime
                                ? DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor7!)
                                : '--',
                            style: TextStyle(fontSize: 14),
                          ))),
                  SizedBox(height: 15),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Sponsor",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
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
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.namasponsor7C),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Tipe Sponsor",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      items: controller.listSponsor7,
                      onChanged: (value) => controller.selectedSponsor7 = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedSponsor7),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Alamat Sponsor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                  AppTextField(
                      minLines: 1,
                      maxLines: 5,
                      textFieldType: TextFieldType.NAME,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      controller: controller.alamatsponsor7C)
                ])))),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedKelamin7.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Jenis Kelamin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Laki-Laki",
                                    groupValue: controller.selectedKelamin7,
                                    onChanged: (value) => controller
                                        .selectedKelamin7 = value ?? '',
                                    title: Text(
                                      "Laki-Laki",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Perempuan",
                                    groupValue: controller.selectedKelamin7,
                                    onChanged: (value) => controller
                                        .selectedKelamin7 = value ?? '',
                                    title: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Lahir",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(
                      fontSize: 14,
                    ),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.tempat7C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalLahir7(context),
                    title: Text("Tanggal Lahir",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggallahir7 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir7!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Kewarganegaraan",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.kewarganegaraan7C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor SK Penetapan Wali",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    controller: controller.nowali7C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktalahir7.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Lahir",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktalahir,
                                    onChanged: (value) => controller
                                        .selectedAktalahir7 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktalahir7,
                                    onChanged: (value) => controller
                                        .selectedAktalahir7 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Kelahiran",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.noaktalahir7C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Golongan Darah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listGoldarah7,
                          onChanged: (value) =>
                              controller.selectGoldarah7 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectGoldarah7))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Agama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listAgama7,
                          onChanged: (value) =>
                              controller.selectedAgama7 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedAgama7))
                ]),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Organisasi Kepercayaan Terhadap Tuhan YME",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    controller: controller.orgagama7C,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10))),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      width: 219,
                      child: DropdownSearch<String>(
                          items: controller.listStatus7,
                          onChanged: (value) =>
                              controller.selectedStatus7 = value,
                          mode: Mode.MENU,
                          dropdownSearchDecoration: InputDecoration(
                              fillColor: Color(0xFFD6D7FD),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              contentPadding: EdgeInsets.only(left: 10)),
                          selectedItem: controller.selectedStatus7))
                ]),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktakawin7.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Kawin",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktakawin7,
                                    onChanged: (value) => controller
                                        .selectedAktakawin7 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktakawin7,
                                    onChanged: (value) => controller
                                        .selectedAktakawin7 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Perkawinan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktakawin7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalkawin7(context),
                    title: Text("Tanggal Perkawinan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalkawin7 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin7!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                SizedBox(height: 15),
                FormField<String>(
                    validator: (value) =>
                        controller.selectedAktacerai7.isNotEmpty
                            ? null
                            : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Akta Cerai",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedAktacerai7,
                                    onChanged: (value) => controller
                                        .selectedAktacerai7 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedAktacerai7,
                                    onChanged: (value) => controller
                                        .selectedAktacerai7 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor Akta Cerai",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noaktacerai7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async => await controller.tanggalcerai7(context),
                    title: Text("Tanggal Perceraian",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    subtitle: Obx(() => Text(
                          controller.selectedTanggalcerai7 is DateTime
                              ? DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai7!)
                              : '--',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Status Hubungan Dalam Keluarga",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listHubungan7,
                    onChanged: (value) => controller.selectedHubungan7 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedHubungan7)
              ])),
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 2,
            title: Text("Identitas"),
            subtitle: Text("Langkah 3"),
            content: Form(
              key: form2,
              child: SingleChildScrollView(
                  child: Column(children: [
                FormField<String>(
                    validator: (value) => controller.selectedCacat7.isNotEmpty
                        ? null
                        : "This field is required",
                    builder: (kelamin) => Obx(() => ListTile(
                        contentPadding: EdgeInsets.only(left: 2),
                        visualDensity: VisualDensity.compact,
                        title: Text(
                          "Kelainan Fisik/Mental",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        subtitle: Column(children: [
                          Row(children: [
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Ada",
                                    groupValue: controller.selectedCacat7,
                                    onChanged: (value) =>
                                        controller.selectedCacat7 = value ?? '',
                                    title: Text(
                                      "Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ))),
                            Expanded(
                                child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    selectedTileColor: primary,
                                    activeColor: primary,
                                    toggleable: true,
                                    value: "Tidak Ada",
                                    groupValue: controller.selectedCacat7,
                                    onChanged: (value) =>
                                        controller.selectedCacat7 = value ?? '',
                                    title: Text(
                                      "Tidak Ada",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )))
                          ]),
                          if (kelamin.hasError)
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(kelamin.errorText!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12)))
                        ])))),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Penyandang Cacat",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listJenisCacat7,
                    onChanged: (value) =>
                        controller.selectedJenisCacat7 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedJenisCacat7),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Pendidikan Terakhir",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPendidikan7,
                    onChanged: (value) =>
                        controller.selectedPendidikan7 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPendidikan7),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Jenis Pekerjaan",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                DropdownSearch<String>(
                    items: controller.listPekerjaan7,
                    onChanged: (value) => controller.selectedPekerjaan7 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    selectedItem: controller.selectedPekerjaan7),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nomor ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.noitas7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Terbit ITAS/ITAP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatItas7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalTerbitItas7(context),
                    title: Text("Tanggal Terbit ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalTerbitItas7 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas7!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 45,
                        )),
                    onTap: () async => await controller.tanggalItas7(context),
                    title: Text("Tanggal Berakhir ITAS/ITAP",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalItas7 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas7!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Tempat Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.tempatPertama7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                        width: 24,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.calendar_month,
                          color: black,
                          size: 35,
                        )),
                    onTap: () async =>
                        await controller.tanggalPertama7(context),
                    title: Text(
                      "Tanggal Kedatangan Pertama",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Obx(() => Text(
                        controller.selectedTanggalpertama7 is DateTime
                            ? DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama7!)
                            : '--',
                        style: TextStyle(
                          fontSize: 14,
                        )))),
                // SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikibu7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ibu",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaibu7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "NIK Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.PHONE,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.nikayah7C),
                SizedBox(height: 15),
                ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Nama Ayah",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                AppTextField(
                    textStyle: TextStyle(fontSize: 14),
                    textFieldType: TextFieldType.NAME,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.only(left: 10)),
                    controller: controller.namaayah7C),
                SizedBox(
                  height: 50,
                ),
                Obx(
                  () => InkWell(
                    onTap: controller.isSaving
                        ? null
                        : () {
                            if (form.currentState!.validate() &
                                form1.currentState!.validate() &
                                form2.currentState!.validate()) {
                              controller.store(kk);
                              controller.storeabsen(absen);
                              controller.storepengantar(pengantar);
                              controller.getPDF(kk);
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
              ])),
            ))
      ];
}
