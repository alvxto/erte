import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/modules/profil/controllers/profil_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../controllers/s_pengantar_controller.dart';

class SPengantarView extends StatefulWidget {
  @override
  State<SPengantarView> createState() => _SPengantarViewState();
}

class _SPengantarViewState extends State<SPengantarView> {
  SPengantarController controller = Get.find<SPengantarController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  final authC = Get.find<AuthController>();
  Pengantar pengantar = Pengantar();
  Absen absen = Absen();
  int currentStep = 0;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRT(
        title: "Surat Pengantar",
      ),
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
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
              ],
            ),
          );
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 0,
          title: Text("Identitas"),
          subtitle: Text("Langkah 1"),
          content: Container(
            // padding: const EdgeInsets.all(15),
            child: Form(
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
                    SizedBox(
                      height: 15,
                    ),
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
                      ),
                    ),
                    // Divider(
                    //   color: black,
                    //   height: 0,
                    //   thickness: 1,
                    // ),
                    SizedBox(
                      height: 10,
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
                    SizedBox(
                      height: 15,
                    ),
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
                        contentPadding: EdgeInsets.only(left: 10),
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      selectedItem: controller.selectedStatus,
                    ),
                    SizedBox(
                      height: 15,
                    ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.editing,
            isActive: currentStep >= 1,
            title: Text("Identitas"),
            subtitle: Text("Langkah 2"),
            content: Form(
              key: form1,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Induk Kependudukan",
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
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Nomor Kartu Keluarga",
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
                      controller: controller.kkC,
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
                    SizedBox(height: 15),
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
                      validator: (value) =>
                          controller.selectedPendidikan != null
                              ? null
                              : "This field is required",
                      items: controller.listPendidikan,
                      onChanged: (value) =>
                          controller.selectedPendidikan = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10),
                        fillColor: Color(0xFFD6D7FD),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      selectedItem: controller.selectedPendidikan,
                    ),
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
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            )),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.editing,
          isActive: currentStep >= 2,
          title: Text("Keperluan"),
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
                      "Keperluan 1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DropdownSearch<String>(
                    validator: (value) => controller.selectedKeperluan1 != null
                        ? null
                        : "This field is required",
                    items: controller.listKeperluan1,
                    onChanged: (value) => controller.selectedKeperluan1 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      fillColor: Color(0xFFD6D7FD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    selectedItem: controller.selectedKeperluan1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Keperluan 2",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DropdownSearch<String>(
                    items: controller.listKeperluan2,
                    onChanged: (value) => controller.selectedKeperluan2 = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10),
                      fillColor: Color(0xFFD6D7FD),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    selectedItem: controller.selectedKeperluan2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      "Email/No Telepon",
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
                                controller.store(pengantar);
                                controller.storeabsen(absen);
                                controller.getPDF(pengantar);
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
                  // Obx(
                  //   () => Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(15),
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topLeft,
                  //         end: Alignment.bottomRight,
                  //         colors: <Color>[
                  //           primary,
                  //           secondary,
                  //         ],
                  //       ),
                  //     ),
                  //     width: Get.width,
                  //     child: FloatingActionButton.extended(
                  //         backgroundColor: Colors.transparent,
                  //         heroTag: null,
                  //         onPressed: controller.isSaving
                  //             ? null
                  //             : () {
                  //                 if (form.currentState!.validate() &
                  //                     form1.currentState!.validate() &
                  //                     form2.currentState!.validate()) {
                  //                   controller.store(pengantar);
                  //                   controller.storeabsen(absen);
                  //                   controller.getPDF(pengantar);
                  //                 }
                  //               },
                  //         label: controller.isSaving
                  //             ? Text("Loading...")
                  //             : Text("KIRIM")),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ];
}
