import 'dart:io';
import 'dart:typed_data';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_domisili.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class SDomisiliController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController tempatC;
  late TextEditingController nktpC;
  late TextEditingController alamatC;
  late TextEditingController emailC;

  // late TextEditingController pekerjaanC;
  // late TextEditingController nikC;
  // late TextEditingController kkC;

  // List<String> listKeperluan1 = [
  //   "Pengurusan Surat Pindah",
  //   "Pengurusan Surat Datang",
  //   "Surat Kontrak Rumah",
  //   "Pengurusan Surat Kelahiran",
  //   "Pengurusan Surat Kematian",
  //   "Surat Keterangan Tidak Mampu",
  //   "Surat Pernyataan Waris",
  //   "Surat Ijin Keramaian",
  //   "Pengurusan Surat Ijin Usaha",
  //   "Pengantar Surat Nikah",
  //   "Pengurusan Surat Pensiun",
  //   "Surat Keterangan Penghasilan",
  //   "Surat Keterangan Permohonan KPR",
  //   "Surat Keterangan Bersih Diri",
  //   "Surat Keterangan Catatan Kepolisian",
  //   "Surat Tunjangan Keluarga",
  //   "Surat Pengurusan Paspor",
  //   "Surat Keterangan Domisili",
  //   "Surat Boro Kerja",
  //   "Pengurusan KTP Baru",
  //   "Pengurusan KK Baru",
  //   "Surat Ijin Mendirikan Bangunan"
  // ];
  // String? selectedKeperluan1;

  // List<String> listKeperluan2 = [
  //   "Pengurusan Surat Pindah",
  //   "Pengurusan Surat Datang",
  //   "Surat Kontrak Rumah",
  //   "Pengurusan Surat Kelahiran",
  //   "Pengurusan Surat Kematian",
  //   "Surat Keterangan Tidak Mampu",
  //   "Surat Pernyataan Waris",
  //   "Surat Ijin Keramaian",
  //   "Pengurusan Surat Ijin Usaha",
  //   "Pengantar Surat Nikah",
  //   "Pengurusan Surat Pensiun",
  //   "Surat Keterangan Penghasilan",
  //   "Surat Keterangan Permohonan KPR",
  //   "Surat Keterangan Bersih Diri",
  //   "Surat Keterangan Catatan Kepolisian",
  //   "Surat Tunjangan Keluarga",
  //   "Surat Pengurusan Paspor",
  //   "Surat Keterangan Domisili",
  //   "Surat Boro Kerja",
  //   "Pengurusan KTP Baru",
  //   "Pengurusan KK Baru",
  //   "Surat Ijin Mendirikan Bangunan"
  // ];
  // String? selectedKeperluan2;

  RxList<UserModel> rxUser = RxList<UserModel>();
  List<UserModel> get users => rxUser.value;
  set users(List<UserModel> value) => rxUser.value = value;

  Rx<DateTime?> _selectedTanggal = DateTime.now().obs;
  DateTime? get selectedTanggal => _selectedTanggal.value;
  set selectedTanggal(DateTime? value) => _selectedTanggal.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggal = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggal ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggal;
  }

  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  var keperluan = "Surat Keterangan Domisili";

  Future store(Domisili domisili) async {
    isSaving = true;
    Domisili nomerC = await Domisili().streamList();
    if (domisili.nomer == null) {
      domisili.nomer = (nomerC.nomer ?? 0) + 1;
    }
    domisili.nama = namaC.text;
    domisili.alamat = alamatC.text;
    domisili.kelamin = selectedKelamin;
    domisili.nktp = int.tryParse(nktpC.text);
    domisili.tanggallahir = selectedTanggal;
    domisili.tempatlahir = tempatC.text;
    domisili.keperluan = keperluan;
    domisili.email = emailC.text;
    if (domisili.id == null) {
      domisili.waktu = DateTime.now();
    }
    try {
      await domisili.save();
      Get.defaultDialog(
        title: "Berhasil",
        middleText:
            "Surat Pengajuan Anda Berhasil dan Tunggu Persetujuan Ketua RT",
        textConfirm: "Oke",
        onConfirm: () {
          namaC.clear();
          tempatC.clear();
          nktpC.clear();
          alamatC.clear();
          selectedKelamin = '';
          selectedTanggal = DateTime.now();
          Get.back();
          Get.back();
          emailC.clear();
        },
        buttonColor: primary,
        cancelTextColor: primary,
        confirmTextColor: white,
        titleStyle: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: TextStyle(
          color: Color(0XFF757575),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  // var _selectedWNI = ''.obs;
  // String get selectedWNI => _selectedWNI.value;
  // set selectedWNI(String value) => _selectedWNI.value = value;

  // List<String> listAgama = [
  //   "Islam",
  //   "Katholik",
  //   "Kristen",
  //   "Hindu",
  //   "Budha",
  //   "Konghucu"
  // ];
  // String? selectedAgama;

  // List<String> listStatus = [
  //   "Belum Kawin",
  //   "Kawin",
  //   "Cerai Hidup",
  //   "Cerai Mati",
  // ];
  // String? selectedStatus;

  // List<String> listPendidikan = [
  //   "SD",
  //   "SLTP",
  //   "SLTA",
  //   "SMK",
  //   "SI",
  //   "SII",
  //   "Sederajat"
  // ];
  // String? selectedPendidikan;

  Future storeabsen(Absen absen) async {
    isSaving = true;
    absen.nama = namaC.text;
    absen.alamat = alamatC.text;
    absen.email = emailC.text;
    if (absen.id == null) {
      absen.waktu = DateTime.now();
    }
    try {
      await absen.save();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    namaC = TextEditingController();
    tempatC = TextEditingController();
    nktpC = TextEditingController();
    alamatC = TextEditingController();
    rxUser.bindStream(UserModel().allstreamList());
    emailC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaC.clear();
    tempatC.clear();
    nktpC.clear();
    alamatC.clear();
    selectedKelamin = '';
    selectedTanggal = DateTime.now();
    emailC.clear();
  }
}
