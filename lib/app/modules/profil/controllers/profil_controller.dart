import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfilController extends GetxController {
  RxBool edit = false.obs;
  late TextEditingController namaC;
  late TextEditingController emailC;
  late TextEditingController passC;
  late TextEditingController tempatC;
  late TextEditingController pekerjaanC;
  late TextEditingController nikC;
  late TextEditingController kkC;
  late TextEditingController alamatC;
  late TextEditingController kecamatanC;
  late TextEditingController kelurahanC;
  late TextEditingController rtC;
  late TextEditingController rwC;
  late File image;
  var imagePath = ''.obs;

  List<String> listGoldarah = [
    "A",
    "B",
    "AB",
    "O",
  ];
  String? selectGoldarah;

  Rx<DateTime?> _selectedTanggal = DateTime.now().obs;
  DateTime? get selectedTanggal => _selectedTanggal.value;
  set selectedTanggal(DateTime? value) => _selectedTanggal.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggal = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggal ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggal;
  }

  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  var _selectedWNI = ''.obs;
  String get selectedWNI => _selectedWNI.value;
  set selectedWNI(String value) => _selectedWNI.value = value;

  List<String> listAgama = [
    "Islam",
    "Katholik",
    "Kristen",
    "Hindu",
    "Budha",
    "Konghucu"
  ];
  String? selectedAgama;

  List<String> listStatus = [
    "Belum Kawin",
    "Kawin",
    "Cerai Hidup",
    "Cerai Mati",
  ];
  String? selectedStatus;

  List<String> listPendidikan = [
    "SD",
    "SLTP",
    "SLTA",
    "SMK",
    "SI",
    "SII",
    "Sederajat"
  ];
  String? selectedPendidikan;
  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  modelToController(UserModel user) {
    emailC.text = user.email ?? '';
    passC.text = user.password ?? '';
    namaC.text = user.nama ?? '';
    tempatC.text = user.tempatlahir ?? '';
    pekerjaanC.text = user.pekerjaan ?? '';
    alamatC.text = user.alamat ?? '';
    nikC.text = user.nik?.toString() ?? '';
    kkC.text = user.kk?.toString() ?? '';
    selectedAgama = user.agama;
    selectedKelamin = user.kelamin ?? '';
    selectedTanggal = user.tanggallahir ?? DateTime.now();
    selectedPendidikan = user.pekerjaan;
    selectedStatus = user.status;
    selectedWNI = user.wni ?? '';
    rtC.text = user.rt ?? '';
    rwC.text = user.rw ?? '';
    kelurahanC.text = user.kelurahan ?? '';
    kecamatanC.text = user.kecamatan ?? '';
    selectGoldarah = user.goldarah ?? '';
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(UserModel user) async {
    isSaving = true;
    user.email = emailC.text;
    user.password = passC.text;
    user.nama = namaC.text;
    user.pekerjaan = pekerjaanC.text;
    user.agama = selectedAgama;
    user.pendidikan = selectedPendidikan;
    user.status = selectedStatus;
    user.alamat = alamatC.text;
    user.wni = selectedWNI;
    user.kelamin = selectedKelamin;
    user.nik = int.tryParse(nikC.text);
    user.kk = int.tryParse(kkC.text);
    user.tanggallahir = selectedTanggal;
    user.tempatlahir = tempatC.text;
    user.rt = rtC.text;
    user.rw = rwC.text;
    user.kecamatan = kecamatanC.text;
    user.kelurahan = kelurahanC.text;
    user.goldarah = selectGoldarah;

    try {
      print(user.toJson);
      await user.save(
          file: imagePath.value == '' ? null : File(imagePath.value));
      Get.defaultDialog(
        title: "Berhasil",
        middleText: "Profil telah dipebarui",
        textConfirm: "Oke",
        onConfirm: () {
          Get.back();
          Get.back();
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

  @override
  void onInit() {
    namaC = TextEditingController();
    emailC = TextEditingController();
    passC = TextEditingController();
    tempatC = TextEditingController();
    pekerjaanC = TextEditingController();
    nikC = TextEditingController();
    kkC = TextEditingController();
    alamatC = TextEditingController();
    rtC = TextEditingController();
    rwC = TextEditingController();
    kelurahanC = TextEditingController();
    kecamatanC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    namaC.clear();
    pekerjaanC.clear();
    tempatC.clear();
    nikC.clear();
    kkC.clear();
    alamatC.clear();
    selectedAgama = '';
    selectedKelamin = '';
    selectedPendidikan = '';
    selectedStatus = '';
    selectedWNI = '';
    emailC.dispose();
    passC.dispose();
    super.onClose();
    selectGoldarah = '';
    rtC.clear();
    rwC.clear();
    kecamatanC.clear();
    kelurahanC.clear();
    selectedTanggal = DateTime.now();
  }
}
