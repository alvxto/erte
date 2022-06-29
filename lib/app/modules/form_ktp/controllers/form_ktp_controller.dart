import 'dart:io';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_ktp.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
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
  ImagePicker picker = ImagePicker();

  Rx<DateTime?> _selectedTanggal = DateTime.now().obs;
  DateTime? get selectedTanggal => _selectedTanggal.value;
  set selectedTanggal(DateTime? value) => _selectedTanggal.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggal = await showDatePicker(
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
    ktp.nama = namaC.text;
    ktp.pekerjaan = pekerjaanC.text;
    ktp.agama = selectedAgama;
    ktp.status = selectedStatus;
    ktp.alamat = alamatC.text;
    ktp.wni = selectedWNI;
    ktp.kelamin = selectedKelamin;
    ktp.nik = int.tryParse(nikC.text);
    ktp.tanggallahir = selectedTanggal;
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
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
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

  Future storepengantar(Pengantar pengantar) async {
    isSaving = true;
    pengantar.nama = namaC.text;
    pengantar.pekerjaan = pekerjaanC.text;
    pengantar.agama = selectedAgama;
    pengantar.status = selectedStatus;
    pengantar.alamat = alamatC.text;
    pengantar.pendidikan = selectedPendidikan;
    pengantar.keperluan1 = keperluan;
    // pengantar.keperluan2 = selectedKeperluan2;
    pengantar.kk = int.tryParse(kkC.text);
    pengantar.wni = selectedWNI;
    pengantar.kelamin = selectedKelamin;
    pengantar.nik = int.tryParse(nikC.text);
    pengantar.tanggallahir = selectedTanggal;
    pengantar.tempatlahir = tempatC.text;
    pengantar.email = emailC.text;
    if (pengantar.id == null) {
      pengantar.waktu = DateTime.now();
    }
    try {
      await pengantar.save();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

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

  void getPDF() async {
    //dokumen
    final pdf = pw.Document();

    //page
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a3,
          build: (pw.Context context) {
            return [ pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(children: [
                      pw.Text("Arsip Kelurahan",
                          style: pw.TextStyle(fontSize: 15)),
                      pw.Container(
                          height: 120,
                          width: 190,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 1.0, color: PdfColors.black))),
                      pw.Text("Kode Grafer", style: pw.TextStyle(fontSize: 15)),
                    ]),
                    pw.Column(children: [
                      pw.Text("", style: pw.TextStyle(fontSize: 15)),
                      pw.Container(
                          height: 120,
                          width: 205,
                          child: pw.Center(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.center,
                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                children: [
                            pw.Text("Pas Foto",
                                style: pw.TextStyle(fontSize: 15)),
                            pw.Text("Warna", style: pw.TextStyle(fontSize: 15)),
                            pw.Text("4 x 6", style: pw.TextStyle(fontSize: 15)),
                          ])),
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 1.0, color: PdfColors.black))),
                    ]),
                    pw.Column(children: [
                      pw.Text("Arsip Kelurahan",
                          style: pw.TextStyle(fontSize: 15)),
                      pw.Container(
                          height: 120,
                          width: 225,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  width: 1.0, color: PdfColors.black))),
                      pw.Text("Tanda Tangan / Bidik Jari Pemohon",
                          style: pw.TextStyle(fontSize: 15)),
                    ]),
                  ]),
              pw.SizedBox(height: 10),
              pw.Text("Pemerintahan Kota Malang",
                  style: pw.TextStyle(fontSize: 20)),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text(
                        "Kecamatan: ........................................",
                        style: pw.TextStyle(fontSize: 15)),
                    pw.Text(
                        "Kelurahan: ........................................",
                        style: pw.TextStyle(fontSize: 15))
                  ]),
              pw.Divider(
                color: PdfColor.fromInt(0xFF000000),
                height: 1,
                thickness: 2,
              ),
              pw.SizedBox(height: 10),
              pw.Text("Formulir Isian Data Kartu Tanda Penduduk (KTP)",
                  style: pw.TextStyle(fontSize: 20)),
              pw.Text(
                  "Harus ditulis LENGKAP dengan HURUF CETAK, beri tanda X pada isian yang dipilih",
                  style: pw.TextStyle(fontSize: 15)),
              pw.SizedBox(height: 30),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "NIK",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Nama Lengkap",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Jenis Kelamin",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Tanggal Lahir",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Tempat Lahir",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Status Kawin",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Agama",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Pekerjaan",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Alamat",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ),
                          pw.SizedBox(height: 25),
                        ]),
                    pw.SizedBox(width: 20),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  " : ....................................................................",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 30),
                                pw.Container(
                                    height: 20,
                                    width: 20,
                                    child: pw.Center(
                                        child: pw.Text(
                                      "1",
                                      style: pw.TextStyle(fontSize: 15),
                                    )),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 1, color: PdfColors.black))),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  "WNI",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 20),
                                pw.Container(
                                    height: 20,
                                    width: 20,
                                    child: pw.Center(
                                        child: pw.Text(
                                      "2",
                                      style: pw.TextStyle(fontSize: 15),
                                    )),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 1, color: PdfColors.black))),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  "WNA",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                              ]),
                          pw.SizedBox(height: 25),
                          pw.Text(
                            " : ....................................................................",
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  " : ",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 5),
                                pw.Container(
                                    height: 20,
                                    width: 20,
                                    child: pw.Center(
                                        child: pw.Text(
                                      "1",
                                      style: pw.TextStyle(fontSize: 15),
                                    )),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 1, color: PdfColors.black))),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  "Laki-laki",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 20),
                                pw.Container(
                                    height: 20,
                                    width: 20,
                                    child: pw.Center(
                                        child: pw.Text(
                                      "2",
                                      style: pw.TextStyle(fontSize: 15),
                                    )),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 1, color: PdfColors.black))),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  "Perempuan",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 60),
                                pw.Text(
                                  "Golongan Darah",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...................",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                              ]),
                          pw.SizedBox(height: 25),
                          pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  " : ",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 30),
                                pw.Text(
                                  "Tgl.",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...........",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 40),
                                pw.Text(
                                  "Bln.",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...........",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 40),
                                pw.Text(
                                  "Thn.",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...........",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.SizedBox(width: 40),
                              ]),
                          pw.SizedBox(height: 25),
                          pw.Text(
                            " : ....................................................................",
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Row(children: [
                            pw.Text(
                              " : ",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "1",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Belum Kawin",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 20),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "2",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Kawin",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 20),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "3",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Cerai Hidup",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 20),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "4",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Cerai Mati",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                          ]),
                          pw.SizedBox(height: 20),
                          pw.Row(children: [
                            pw.Text(
                              " : ",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 5),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "1",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Islam",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "2",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Kristen",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "3",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Katholik",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "4",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Hindu",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "5",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Budha",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Container(
                                height: 20,
                                width: 20,
                                child: pw.Center(
                                    child: pw.Text(
                                  "6",
                                  style: pw.TextStyle(fontSize: 15),
                                )),
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1, color: PdfColors.black))),
                            pw.SizedBox(width: 5),
                            pw.Text(
                              "Khonghucu",
                              style: pw.TextStyle(fontSize: 15),
                            ),
                            // pw.SizedBox(width: 15),
                            // pw.Container(
                            //     height: 20,
                            //     width: 20,
                            //     child: pw.Center(
                            //         child: pw.Text(
                            //       "7",
                            //       style: pw.TextStyle(fontSize: 15),
                            //     )),
                            //     decoration: pw.BoxDecoration(
                            //         border: pw.Border.all(
                            //             width: 1, color: PdfColors.black))),
                            // pw.SizedBox(width: 5),
                            // pw.Text(
                            //   "Penghayat Kepercayaan",
                            //   style: pw.TextStyle(fontSize: 15),
                            // ),
                            // pw.SizedBox(width: 15),
                            // pw.Container(
                            //     height: 20,
                            //     width: 20,
                            //     child: pw.Center(
                            //         child: pw.Text(
                            //       "8",
                            //       style: pw.TextStyle(fontSize: 15),
                            //     )),
                            //     decoration: pw.BoxDecoration(
                            //         border: pw.Border.all(
                            //             width: 1, color: PdfColors.black))),
                            // pw.SizedBox(width: 5),
                            // pw.Text(
                            //   "Lainnya",
                            //   style: pw.TextStyle(fontSize: 15),
                            // ),
                          ]),
                          pw.SizedBox(height: 25),
                          pw.Text(
                            " : ....................................................................",
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Text(
                            " : ....................................................................",
                            style: pw.TextStyle(fontSize: 15),
                          ),
                          pw.SizedBox(height: 25),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  "RT",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...............",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  "RW",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                                pw.Text(
                                  " : ...............",
                                  style: pw.TextStyle(fontSize: 15),
                                ),
                              ]),
                          pw.SizedBox(height: 25),
                        ]),
                  ]),
                  pw.SizedBox(height: 30),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                    pw.Column(children: [
                      pw.Text("Mengetahui Lurah",
                                  style: pw.TextStyle(fontSize: 20),),
                                  pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                    pw.Column(children: [
                      pw.Text("RW",
                                  style: pw.TextStyle(fontSize: 20),),
                                  pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                    pw.Column(children: [
                      pw.Text("RT",
                                  style: pw.TextStyle(fontSize: 20),),
                                  pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                    pw.Column(children: [
                      pw.Text("Pemohon",
                                  style: pw.TextStyle(fontSize: 20),),
                                  pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                  ])
            ]),
            pw.SizedBox(height: 190),
            pw.Column(children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "Rukun Tetangga (RT) II Rukun Warga (RW) IX",
                  style: pw.TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text("Kelurahan Gadang Kecamatan Sukun",
                    style: pw.TextStyle(fontSize: 20)),
              ),
              pw.Align(
                alignment: pw.Alignment.center,
                child:
                    pw.Text("Kota Malang", style: pw.TextStyle(fontSize: 20)),
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                        "Sekretariat : Jl. Satsui Tubun - (Perum Green Living Residence)",
                          style: pw.TextStyle(fontSize: 15),),
                    pw.Text("Kode Pos : 65149",
                          style: pw.TextStyle(fontSize: 15),),
                  ]),
              pw.Divider(
                color: PdfColor.fromInt(0xFF000000),
                height: 1,
                thickness: 2,
              ),
              pw.SizedBox(height: 5),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("Malang, ${DateFormat("dd MMM y")
                              .format(DateTime.now())}",
                          style: pw.TextStyle(fontSize: 15),)),
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("Kepada",
                          style: pw.TextStyle(fontSize: 15),)),
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("Yth. Sdr. Lurah Gadang",
                          style: pw.TextStyle(fontSize: 15),)),
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("Kecamatan Sukun Kota Malang",
                          style: pw.TextStyle(fontSize: 15),)),
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text("di Malang",
                          style: pw.TextStyle(fontSize: 15),)),
                  ]),
                ]),
              
              pw.SizedBox(
                height: 5,
              ),
              pw.Text("Surat Pengantar",
                          style: pw.TextStyle(fontSize: 20),),
              // pw.Divider(
              //     color: PdfColor.fromInt(0xFF000000),
              //     height: 1,
              //     thickness: 2,
              //   ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text("Nomor : .../...-IX/.../2022",
                          style: pw.TextStyle(fontSize: 15),),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                  "Yang bertanda tangan dibawah ini Ketua RT. II RW. IX Kelurahan Gadang Kecamatan",
                          style: pw.TextStyle(fontSize: 15),),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                      "Sukun Kota Malang dengan ini menerangkan bahwa :",
                          style: pw.TextStyle(fontSize: 15),)),
                          pw.SizedBox(height: 30), 
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                  pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Nama",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Jenis Kelamin",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Tempat / Tgl Lahir",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Agama",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Status",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child:
                    pw.Text("Kewarganegaraan",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Pendidikan",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Pekerjaan",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "NIK",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Nomor Kartu Keluarga",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Alamat",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                    "Keperluan",
                          style: pw.TextStyle(fontSize: 15),),
              ),
                ]),
                pw.SizedBox(width: 20),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : Laki-Laki / Perempuan",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : Islam/Katholik/Kristen/Hindu/Budha/Khonghucu/......",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : Belum Kawin/Kawin/Cerai Hidup/Cerai Mati",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : WNI / WNA",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : SD/SLTP/SLTA/SMK/SI/SII/Sederajat",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : ....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text(" : 1....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                  pw.Text("   2....................................................................",
                          style: pw.TextStyle(fontSize: 15),),
                  pw.SizedBox(height: 10),
                ]),
              ]),
              
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                    "Demikian untuk menjadikan periksa dan dipergunakan sebagai mestinya",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("Nomor : .../IX/01-2022",
                          style: pw.TextStyle(fontSize: 15),),
              ),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text("Tanggal : ${DateFormat("dd MMM y")
                              .format(DateTime.now())}",
                          style: pw.TextStyle(fontSize: 15),)),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text("Mengetahui,",
                          style: pw.TextStyle(fontSize: 18),)),
              pw.SizedBox(height: 20),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Ketua RW. IX",
                          style: pw.TextStyle(fontSize: 20),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Kelurahan Gadang",
                          style: pw.TextStyle(fontSize: 20),
                        ),
                      ),
                      pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Ketua RT. II / RW. IX",
                          style: pw.TextStyle(fontSize: 20),
                        ),
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                          "Kelurahan Gadang",
                          style: pw.TextStyle(fontSize: 20),
                        ),
                      ),
                      pw.SizedBox(height: 80),
                                  pw.Text("(...................)",
                                  style: pw.TextStyle(fontSize: 20),),
                    ]),
                  ])
            ])
            ]; // Center
          }),
    );

    //save
    Uint8List bytes = await pdf.save();

    //file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Form KTP.pdf');

    //timpa file kosong dengan pdf
    await file.writeAsBytes(bytes);

    //open file
    await OpenFile.open(file.path);
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
