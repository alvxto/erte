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

class FormKkView extends GetView<FormKkController> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  KK kk = KK();
  Absen absen = Absen();
  Pengantar pengantar = Pengantar();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Form KK'),
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
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
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Pilih Salah Satu :"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Keluarga WNI",
                                  groupValue: controller.selectedDataKeluarga,
                                  onChanged: (value) => controller
                                      .selectedDataKeluarga = value ?? '',
                                  title: Text("Keluarga WNI"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Keluarga WNA",
                                  groupValue: controller.selectedDataKeluarga,
                                  onChanged: (value) => controller
                                      .selectedDataKeluarga = value ?? '',
                                  title: Text(
                                    "Keluarga WNA",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (datakeluarga.hasError)
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                datakeluarga.errorText!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nama Kepala Keluarga")),
                  controller: controller.namakepalaC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Alamat")),
                  controller: controller.alamatC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Kode Pos")),
                  controller: controller.kodeposC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("RT")),
                  controller: controller.rtC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("RW")),
                  controller: controller.rwC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Jumlah Anggota Keluarga")),
                  controller: controller.jumkeluargaC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Telepon")),
                  controller: controller.teleponC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nama Lengkap")),
                  controller: controller.namalengkapC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Gelar Depan")),
                  controller: controller.gelardepanC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Gelar Belakang")),
                  controller: controller.gelarbelakangC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nomor Paspor")),
                  controller: controller.nopasporC,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalPaspor(context),
                  title: Text(
                    "Tanggal Berakhir Paspor",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalpaspor is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalpaspor!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nama Sponsor")),
                  controller: controller.namasponsorC,
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listSponsor,
                  onChanged: (value) => controller.selectedSponsor = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Tipe Sponsor",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedSponsor,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Alamat Sponsor")),
                  controller: controller.alamatsponsorC,
                ),
                SizedBox(
                  height: 15,
                ),
                FormField<String>(
                  validator: (value) => controller.selectedKelamin.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (kelamin) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Jenis Kelamin"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Laki-Laki",
                                  groupValue: controller.selectedKelamin,
                                  onChanged: (value) =>
                                      controller.selectedKelamin = value ?? '',
                                  title: Text("Laki-Laki"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Perempuan",
                                  groupValue: controller.selectedKelamin,
                                  onChanged: (value) =>
                                      controller.selectedKelamin = value ?? '',
                                  title: Text(
                                    "Perempuan",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  controller: controller.tempatC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Tempat Lahir")),
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalLahir(context),
                  title: Text(
                    "Tanggal Lahir",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggallahir is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggallahir!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  controller: controller.kewarganegaraanC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Kewarganegaraan")),
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  controller: controller.nowaliC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nomor SK Penetapan Wali")),
                ),
                SizedBox(
                  height: 15,
                ),
                FormField<String>(
                  validator: (value) => controller.selectedAktalahir.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (kelamin) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Akta Lahir"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Ada",
                                  groupValue: controller.selectedAktalahir,
                                  onChanged: (value) => controller
                                      .selectedAktalahir = value ?? '',
                                  title: Text("Ada"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Tidak Ada",
                                  groupValue: controller.selectedAktalahir,
                                  onChanged: (value) => controller
                                      .selectedAktalahir = value ?? '',
                                  title: Text(
                                    "Tidak Ada",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  controller: controller.noaktalahirC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nomor Akta Kelahiran")),
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listGoldarah,
                  onChanged: (value) => controller.selectGoldarah = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Golongan Darah",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectGoldarah,
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listAgama,
                  onChanged: (value) => controller.selectedAgama = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Agama",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedAgama,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  controller: controller.orgagamaC,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text(
                          "Nama Organisasi Kepercayaan Terhadap Tuhan YME")),
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listStatus,
                  onChanged: (value) => controller.selectedStatus = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Status Perkawinan",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedStatus,
                ),
                SizedBox(
                  height: 15,
                ),
                FormField<String>(
                  validator: (value) => controller.selectedAktakawin.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (kelamin) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Akta Kawin"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Ada",
                                  groupValue: controller.selectedAktakawin,
                                  onChanged: (value) => controller
                                      .selectedAktakawin = value ?? '',
                                  title: Text("Ada"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Tidak Ada",
                                  groupValue: controller.selectedAktakawin,
                                  onChanged: (value) => controller
                                      .selectedAktakawin = value ?? '',
                                  title: Text(
                                    "Tidak Ada",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nomor Akta Perkawinan")),
                  controller: controller.noaktakawinC,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalkawin(context),
                  title: Text(
                    "Tanggal Perkawinan",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalkawin is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalkawin!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                FormField<String>(
                  validator: (value) => controller.selectedAktacerai.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (kelamin) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Akta Cerai"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Ada",
                                  groupValue: controller.selectedAktacerai,
                                  onChanged: (value) => controller
                                      .selectedAktacerai = value ?? '',
                                  title: Text("Ada"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Tidak Ada",
                                  groupValue: controller.selectedAktacerai,
                                  onChanged: (value) => controller
                                      .selectedAktacerai = value ?? '',
                                  title: Text(
                                    "Tidak Ada",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Nomor Akta Cerai")),
                  controller: controller.noaktaceraiC,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalcerai(context),
                  title: Text(
                    "Tanggal Perceraian",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalcerai is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalcerai!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listHubungan,
                  onChanged: (value) => controller.selectedHubungan = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Status Hubungan Dalam Keluarga",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedHubungan,
                ),
                SizedBox(
                  height: 15,
                ),
                FormField<String>(
                  validator: (value) => controller.selectedCacat.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (kelamin) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Kelainan Fisik/Mental"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Ada",
                                  groupValue: controller.selectedCacat,
                                  onChanged: (value) =>
                                      controller.selectedCacat = value ?? '',
                                  title: Text("Ada"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "Tidak Ada",
                                  groupValue: controller.selectedCacat,
                                  onChanged: (value) =>
                                      controller.selectedCacat = value ?? '',
                                  title: Text(
                                    "Tidak Ada",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listJenisCacat,
                  onChanged: (value) => controller.selectedJenisCacat = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Penyandang Cacat",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedJenisCacat,
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                  items: controller.listPendidikan,
                  onChanged: (value) => controller.selectedPendidikan = value,
                  mode: Mode.MENU,
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Pendidikan Terakhir",
                    contentPadding: EdgeInsets.zero,
                  ),
                  selectedItem: controller.selectedPendidikan,
                ),
                SizedBox(
                  height: 15,
                ),
                DropdownSearch<String>(
                    items: controller.listPekerjaan,
                    onChanged: (value) => controller.selectedPekerjaan = value,
                    mode: Mode.MENU,
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Jenis Pekerjaan",
                      contentPadding: EdgeInsets.zero,
                    ),
                    selectedItem: controller.selectedPekerjaan),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("No ITAS/ITAP")),
                  controller: controller.noitasC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Tempat Terbit ITAS/ITAP")),
                  controller: controller.tempatItasC,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async =>
                      await controller.tanggalTerbitItas(context),
                  title: Text(
                    "Tanggal Terbit ITAS/ITAP",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalTerbitItas is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalTerbitItas!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalItas(context),
                  title: Text(
                    "Tanggal Berakhir ITAS/ITAP",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalItas is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalItas!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Tempat Kedatangan Pertama")),
                  controller: controller.tempatPertamaC,
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Container(
                      width: 24,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.calendar_today,
                      )),
                  onTap: () async => await controller.tanggalPertama(context),
                  title: Text(
                    "Tanggal Kedatangan Pertama",
                    style: TextStyle(fontSize: 12),
                  ),
                  subtitle: Obx(() => Text(
                      controller.selectedTanggalpertama is DateTime
                          ? DateFormat("EEE, dd MMM y")
                              .format(controller.selectedTanggalpertama!)
                          : '--')),
                ),
                Divider(
                  color: black,
                  height: 0,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("NIK Ibu")),
                  controller: controller.nikibuC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Nama Ibu")),
                  controller: controller.namaibuC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.PHONE,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("NIK Ayah")),
                  controller: controller.nikayahC,
                ),
                SizedBox(
                  height: 15,
                ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), label: Text("Nama Ayah")),
                  controller: controller.namaayahC,
                ),
                SizedBox(
                  height: 15,
                ),
                // AppTextField(
                //   textFieldType: TextFieldType.PHONE,
                //   textInputAction: TextInputAction.next,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(), label: Text("NIK")),
                //   controller: controller.nikC,
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // AppTextField(
                //   textFieldType: TextFieldType.PHONE,
                //   textInputAction: TextInputAction.next,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(), label: Text("No KK")),
                //   controller: controller.kkC,
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                FormField<String>(
                  validator: (value) => controller.selectedWNI.isNotEmpty
                      ? null
                      : "This field is required",
                  builder: (wni) => Obx(
                    () => ListTile(
                      contentPadding: EdgeInsets.only(left: 2),
                      visualDensity: VisualDensity.compact,
                      title: Text("Kewarganegaraan"),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "WNI",
                                  groupValue: controller.selectedWNI,
                                  onChanged: (value) =>
                                      controller.selectedWNI = value ?? '',
                                  title: Text("WNI"),
                                ),
                              ),
                              Expanded(
                                child: RadioListTile<String>(
                                  selectedTileColor: primary,
                                  activeColor: primary,
                                  toggleable: true,
                                  value: "WNA",
                                  groupValue: controller.selectedWNI,
                                  onChanged: (value) =>
                                      controller.selectedWNI = value ?? '',
                                  title: Text(
                                    "WNA",
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
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
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
                // SizedBox(
                //   height: 15,
                // ),
                AppTextField(
                  textFieldType: TextFieldType.NAME,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Email / No Telepon")),
                  controller: controller.emailC,
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Container(
                    width: Get.width,
                    child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: controller.isSaving
                            ? null
                            : () {
                                if (form.currentState!.validate()) {
                                  controller.store(kk);
                                  controller.storeabsen(absen);
                                  controller.storepengantar(pengantar);
                                }
                              },
                        label: controller.isSaving
                            ? Text("Loading...")
                            : Text("Kirim")),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
        ));
  }
}
