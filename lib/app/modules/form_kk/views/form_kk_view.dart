import 'package:dropdown_search/dropdown_search.dart';
import 'package:email_validator/email_validator.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../data/models/form_kk.dart';
import '../../../data/models/s_pengantar.dart';
import '../controllers/form_kk_controller.dart';

class FormKkView extends StatefulWidget {
  FormKkView({Key? key}) : super(key: key);

  @override
  State<FormKkView> createState() => _FormKkViewState();
}

class _FormKkViewState extends State<FormKkView> {
  FormKkController controller = Get.find<FormKkController>();

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
          ),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            visualDensity: VisualDensity.compact,
            title: Text(
              "Data Kepala Keluarga",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPengisianKK(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 110,
                // width: 300,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            visualDensity: VisualDensity.compact,
            title: Text(
              "Data Anggota Keluarga",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: kk.listAnggota?.length ?? 0,
            itemBuilder: (context, index) => DataCard(
              anggota: kk.listAnggota![index],
            ),
          ),
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormPengisianKK(),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 110,
                width: 300,
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30),
                    Text(
                      "Tambah Anggota",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataCard extends GetView<FormKkController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  DataCard({required this.anggota});
  Anggota anggota;

  @override
  Widget build(BuildContext context) {
    controller.modelcontroller(anggota);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 110,
        width: 300,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class FormPengisianKK extends StatefulWidget {
  FormPengisianKK({Key? key}) : super(key: key);

  @override
  State<FormPengisianKK> createState() => _FormPengisianKKState();
}

class _FormPengisianKKState extends State<FormPengisianKK> {
  FormKkController controller = Get.find<FormKkController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<FormState> form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> form2 = GlobalKey<FormState>();

  KK kk = KK();
  Anggota anggota = Anggota();
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
                  SizedBox(height: 15),
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
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "Status",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      validator: (value) =>
                          controller.selectedstatuskwinpngntr != null
                              ? null
                              : "This field is required",
                      items: controller.listStatusPngntr,
                      onChanged: (value) =>
                          controller.selectedstatuskwinpngntr = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedstatuskwinpngntr),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "NIK",
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    controller: controller.nikC,
                  ),
                  SizedBox(height: 15),
                  ListTile(
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        "KK",
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
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
                        "Pendidikan",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  DropdownSearch<String>(
                      validator: (value) =>
                          controller.selectedPendidikan_pngntr != null
                              ? null
                              : "This field is required",
                      items: controller.ListPendidikan_pngntr,
                      onChanged: (value) =>
                          controller.selectedPendidikan_pngntr = value,
                      mode: Mode.MENU,
                      dropdownSearchDecoration: InputDecoration(
                          fillColor: Color(0xFFD6D7FD),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          contentPadding: EdgeInsets.only(left: 10)),
                      selectedItem: controller.selectedPendidikan_pngntr),
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
                            controller.selectedTanggalpaspor ==
                                    DateTime(2050, 1, 1)
                                ? 'tanggal belum dipilih'
                                : DateFormat("EEE, dd MMM y", 'id')
                                    .format(controller.selectedTanggalpaspor!),
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
                          controller.selectedTanggallahir ==
                                  DateTime(2050, 1, 1)
                              ? 'tanggal belum dipilih'
                              : DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggallahir!),
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
                          validator: (value) => controller.selectedAgama != null
                              ? null
                              : "This field is required",
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
                          controller.selectedTanggalkawin ==
                                  DateTime(2050, 1, 1)
                              ? 'tanggal belum dipilih'
                              : DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalkawin!),
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
                          controller.selectedTanggalcerai ==
                                  DateTime(2050, 1, 1)
                              ? 'tanggal belum dipilih'
                              : DateFormat("EEE, dd MMM y", 'id')
                                  .format(controller.selectedTanggalcerai!),
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
                      "Jenis Pekerjaan",
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
                        controller.selectedTanggalTerbitItas ==
                                DateTime(2050, 1, 1)
                            ? 'tanggal belum dipilih'
                            : DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalTerbitItas!),
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
                        controller.selectedTanggalItas == DateTime(2050, 1, 1)
                            ? 'tanggal belum dipilih'
                            : DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalItas!),
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
                        controller.selectedTanggalpertama ==
                                DateTime(2050, 1, 1)
                            ? 'tanggal belum dipilih'
                            : DateFormat("EEE, dd MMM y", 'id')
                                .format(controller.selectedTanggalpertama!),
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
                    validator: (email) => !EmailValidator.validate(email!)
                        ? 'Enter a valid email'
                        : null,
                    autoFillHints: [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
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
                              // controller.store(kk);
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
