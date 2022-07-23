import 'dart:io';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_ktp.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

class FormKtpController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController tempatC;
  late TextEditingController pekerjaanC;
  late TextEditingController nikC;
  late TextEditingController alamatC;
  late TextEditingController kecamatanC;
  late TextEditingController kelurahanC;
  late TextEditingController rtC;
  late TextEditingController rwC;
  late TextEditingController emailC;
  late TextEditingController kkC;
  var currentStep = 0.obs;
  // ImagePicker picker = ImagePicker();

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

  List<String> listGoldarah = [
    "A",
    "B",
    "AB",
    "O",
  ];
  String? selectGoldarah;

  late File image;
  var imagePath = ''.obs;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  // modelToController(KTP ktp) {
  //   namaC.text = ktp.nama ?? '';
  //   tempatC.text = ktp.tempatlahir ?? '';
  //   pekerjaanC.text = ktp.pekerjaan ?? '';
  //   alamatC.text = ktp.alamat ?? '';
  //   nikC.text = ktp.nik?.toString() ?? '';
  //   selectedAgama = ktp.agama;
  //   selectedKelamin = ktp.kelamin ?? '';
  //   selectedTanggal = ktp.tanggallahir ?? DateTime.now();
  //   selectedPendidikan = ktp.pekerjaan;
  //   selectedStatus = ktp.status;
  //   selectedWNI = ktp.wni ?? '';
  //   rtC.text = ktp.rt ?? '';
  //   rwC.text = ktp.rw ?? '';
  //   kelurahanC.text = ktp.kelurahan ?? '';
  //   kecamatanC.text = ktp.kecamatan ?? '';
  //   selectGoldarah = ktp.goldarah ?? '';
  // }

  Future store(KTP ktp) async {
    isSaving = true;
    KTP nomerC = await KTP().streamList();
    if (ktp.nomer == null) {
      ktp.nomer = (nomerC.nomer ?? 0) + 1;
    }
    ktp.nama = namaC.text;
    ktp.pekerjaan = pekerjaanC.text;
    ktp.agama = selectedAgama;
    ktp.status = selectedStatus;
    ktp.alamat = alamatC.text;
    ktp.wni = selectedWNI;
    ktp.kelamin = selectedKelamin;
    ktp.nik = int.tryParse(nikC.text);
    ktp.kk = int.tryParse(kkC.text);
    ktp.tanggallahir = selectedTanggal;
    ktp.keperluan1 = keperluan;
    ktp.pendidikan = selectedPendidikan;
    ktp.tempatlahir = tempatC.text;
    ktp.rt = rtC.text;
    ktp.rw = rwC.text;
    ktp.kecamatan = kecamatanC.text;
    ktp.kelurahan = kelurahanC.text;
    ktp.goldarah = selectGoldarah;
    ktp.email = emailC.text;

    if (ktp.id == null) {
      ktp.waktu = DateTime.now();
    }
    try {
      await ktp.save(
          file: imagePath.value == '' ? null : File(imagePath.value));
      Get.defaultDialog(
        title: "Berhasil",
        middleText:
            "Surat Pengajuan Anda Berhasil dan Tunggu Persetujuan Ketua RT",
        textConfirm: "Oke",
        onConfirm: () {
          namaC.clear();
          pekerjaanC.clear();
          tempatC.clear();
          nikC.clear();
          alamatC.clear();
          selectedAgama = '';
          selectedKelamin = '';
          selectedStatus = '';
          selectedWNI = '';
          selectedTanggal = DateTime.now();
          selectGoldarah = '';
          rtC.clear();
          rwC.clear();
          kecamatanC.clear();
          kelurahanC.clear();
          Get.back();
          Get.back();
          imagePath.value = '';
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

  List<String> listKeperluan1 = [
    "Pengurusan Surat Pindah",
    "Pengurusan Surat Datang",
    "Surat Kontrak Rumah",
    "Pengurusan Surat Kelahiran",
    "Pengurusan Surat Kematian",
    "Surat Keterangan Tidak Mampu",
    "Surat Pernyataan Waris",
    "Surat Ijin Keramaian",
    "Pengurusan Surat Ijin Usaha",
    "Pengantar Surat Nikah",
    "Pengurusan Surat Pensiun",
    "Surat Keterangan Penghasilan",
    "Surat Keterangan Permohonan KPR",
    "Surat Keterangan Bersih Diri",
    "Surat Keterangan Catatan Kepolisian",
    "Surat Tunjangan Keluarga",
    "Surat Pengurusan Paspor",
    "Surat Keterangan Domisili",
    "Surat Boro Kerja",
    "Pengurusan KTP Baru",
    "Pengurusan KK Baru",
    "Surat Ijin Mendirikan Bangunan"
  ];
  String? selectedKeperluan1;

  List<String> listKeperluan2 = [
    "Pengurusan Surat Pindah",
    "Pengurusan Surat Datang",
    "Surat Kontrak Rumah",
    "Pengurusan Surat Kelahiran",
    "Pengurusan Surat Kematian",
    "Surat Keterangan Tidak Mampu",
    "Surat Pernyataan Waris",
    "Surat Ijin Keramaian",
    "Pengurusan Surat Ijin Usaha",
    "Pengantar Surat Nikah",
    "Pengurusan Surat Pensiun",
    "Surat Keterangan Penghasilan",
    "Surat Keterangan Permohonan KPR",
    "Surat Keterangan Bersih Diri",
    "Surat Keterangan Catatan Kepolisian",
    "Surat Tunjangan Keluarga",
    "Surat Pengurusan Paspor",
    "Surat Keterangan Domisili",
    "Surat Boro Kerja",
    "Pengurusan KTP Baru",
    "Pengurusan KK Baru",
    "Surat Ijin Mendirikan Bangunan"
  ];
  String? selectedKeperluan2;

  var keperluan = "Pengurusan KTP baru";

  // Future storepengantar(Pengantar pengantar) async {
  //   isSaving = true;
  //   pengantar.nama = namaC.text;
  //   pengantar.pekerjaan = pekerjaanC.text;
  //   pengantar.agama = selectedAgama;
  //   pengantar.status = selectedStatus;
  //   pengantar.alamat = alamatC.text;
  //   pengantar.pendidikan = selectedPendidikan;
  //   pengantar.keperluan1 = keperluan;
  //   // pengantar.keperluan2 = selectedKeperluan2;
  //   pengantar.kk = int.tryParse(kkC.text);
  //   pengantar.wni = selectedWNI;
  //   pengantar.kelamin = selectedKelamin;
  //   pengantar.nik = int.tryParse(nikC.text);
  //   pengantar.tanggallahir = selectedTanggal;
  //   pengantar.tempatlahir = tempatC.text;
  //   pengantar.email = emailC.text;
  //   if (pengantar.id == null) {
  //     pengantar.waktu = DateTime.now();
  //   }
  //   try {
  //     await pengantar.save();
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isSaving = false;
  //   }
  // }

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
    kkC = TextEditingController();
    namaC = TextEditingController();
    tempatC = TextEditingController();
    pekerjaanC = TextEditingController();
    nikC = TextEditingController();
    alamatC = TextEditingController();
    rtC = TextEditingController();
    rwC = TextEditingController();
    kelurahanC = TextEditingController();
    kecamatanC = TextEditingController();
    emailC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namaC.clear();
    pekerjaanC.clear();
    tempatC.clear();
    nikC.clear();
    alamatC.clear();
    selectedAgama = '';
    selectedKelamin = '';
    selectedStatus = '';
    selectedWNI = '';
    selectGoldarah = '';
    rtC.clear();
    rwC.clear();
    kecamatanC.clear();
    kelurahanC.clear();
    selectedTanggal = DateTime.now();
    imagePath.value = '';
    emailC.clear();
    kkC.clear();
  }
}
