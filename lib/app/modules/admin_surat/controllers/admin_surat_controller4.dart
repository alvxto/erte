import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_kk.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class AdminSuratController4 extends GetxController {
  late TextEditingController namalengkapC;
  late TextEditingController namakepalaC;
  late TextEditingController namasponsorC;
  late TextEditingController namaayahC;
  late TextEditingController namaibuC;
  late TextEditingController kodeposC;
  late TextEditingController jumkeluargaC;
  late TextEditingController teleponC;
  late TextEditingController gelardepanC;
  late TextEditingController gelarbelakangC;
  late TextEditingController nopasporC;
  late TextEditingController tempatC;
  late TextEditingController pekerjaanC;
  late TextEditingController nikibuC;
  late TextEditingController nikayahC;
  late TextEditingController noitasC;
  late TextEditingController tempatItasC;

  late TextEditingController tempatPertamaC;

  late TextEditingController alamatC;
  late TextEditingController alamatsponsorC;

  late TextEditingController rtC;
  late TextEditingController rwC;
  late TextEditingController nowaliC;

  late TextEditingController noaktalahirC;

  late TextEditingController noaktakawinC;

  late TextEditingController noaktaceraiC;

  late TextEditingController orgagamaC;

  late TextEditingController kewarganegaraanC;

  late TextEditingController emailC;
  late TextEditingController nikC;
  late TextEditingController kkC;

  RxList<KK> rxKK = RxList<KK>();
  List<KK> get listAnggota => rxKK.value;
  set listAnggota(List<KK> value) => rxKK.value = value;

  //Tanggal Lahir
  Rx<DateTime?> _selectedTanggallahir = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir => _selectedTanggallahir.value;
  set selectedTanggallahir(DateTime? value) =>
      _selectedTanggallahir.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggallahir = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir;
  }

  //Tanggal Itas
  Rx<DateTime?> _selectedTanggalItas = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas => _selectedTanggalItas.value;
  set selectedTanggalItas(DateTime? value) =>
      _selectedTanggalItas.value = value;

  tanggalItas(dynamic context) async {
    selectedTanggalItas = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas;
  }

  //Tanggal terbit itas
  Rx<DateTime?> _selectedTanggalTerbitItas = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas => _selectedTanggalTerbitItas.value;
  set selectedTanggalTerbitItas(DateTime? value) =>
      _selectedTanggalTerbitItas.value = value;

  tanggalTerbitItas(dynamic context) async {
    selectedTanggalTerbitItas = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas;
  }

  // Tanggal Kawin
  Rx<DateTime?> _selectedTanggalkawin = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin => _selectedTanggalkawin.value;
  set selectedTanggalkawin(DateTime? value) =>
      _selectedTanggalkawin.value = value;

  tanggalkawin(dynamic context) async {
    selectedTanggalkawin = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin;
  }

  //Tanggal cerai
  Rx<DateTime?> _selectedTanggalcerai = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai => _selectedTanggalcerai.value;
  set selectedTanggalcerai(DateTime? value) =>
      _selectedTanggalcerai.value = value;

  tanggalcerai(dynamic context) async {
    selectedTanggalcerai = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai;
  }

  //tanggal paspor
  Rx<DateTime?> _selectedTanggalpaspor = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor => _selectedTanggalpaspor.value;
  set selectedTanggalpaspor(DateTime? value) =>
      _selectedTanggalpaspor.value = value;

  tanggalPaspor(dynamic context) async {
    selectedTanggalpaspor = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor;
  }

  //tanggal pertama
  Rx<DateTime?> _selectedTanggalpertama = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama => _selectedTanggalpertama.value;
  set selectedTanggalpertama(DateTime? value) =>
      _selectedTanggalpertama.value = value;

  tanggalPertama(dynamic context) async {
    selectedTanggalpertama = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama;
  }

  // Jenis Kelamin
  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  //Akta Lahir
  var _selectedAktalahir = ''.obs;
  String get selectedAktalahir => _selectedAktalahir.value;
  set selectedAktalahir(String value) => _selectedAktalahir.value = value;

  //Akta Kawin
  var _selectedAktakawin = ''.obs;
  String get selectedAktakawin => _selectedAktakawin.value;
  set selectedAktakawin(String value) => _selectedAktakawin.value = value;

  // Akta Cerai
  var _selectedAktacerai = ''.obs;
  String get selectedAktacerai => _selectedAktacerai.value;
  set selectedAktacerai(String value) => _selectedAktacerai.value = value;

  // Cacat
  var _selectedCacat = ''.obs;
  String get selectedCacat => _selectedCacat.value;
  set selectedCacat(String value) => _selectedCacat.value = value;

  //Data Keluarga
  var _selectedDataKeluarga = ''.obs;
  String get selectedDataKeluarga => _selectedDataKeluarga.value;
  set selectedDataKeluarga(String value) => _selectedDataKeluarga.value = value;

  //Pendidikan Pengantar
  List<String> ListPendidikan_pngntr = [
    "SD",
    "SLTP",
    "SLTA",
    "SMK",
    "SI",
    "SII",
    "Sederajat"
  ];
  String? selectedPendidikan_pngntr;

  // Pendidikan
  List<String> listPendidikan = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma I/II",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan;

  //Agama
  List<String> listAgama = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama;

  // Jenis Cacat
  List<String> listJenisCacat = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat;

  // Hubungan
  List<String> listHubungan = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan;

  List<String> listSponsor = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor;

  List<String> listStatusPngntr = [
    "Belum Kawin",
    "Kawin",
    "Cerai Hidup",
    "Cerai Mati",
  ];
  String? selectedstatuskwinpngntr;

  List<String> listStatus = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus;

  List<String> listGoldarah = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah;

  List<String> listPekerjaan = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan;

  late File image;
  var imagePath = ''.obs;

  var _selectedWNI = ''.obs;
  String get selectedWNI => _selectedWNI.value;
  set selectedWNI(String value) => _selectedWNI.value = value;

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

  // modelToController(kk kk) {
  //   namaC.text = kk.nama ?? '';
  //   tempatC.text = kk.tempatlahir ?? '';
  //   pekerjaanC.text = kk.pekerjaan ?? '';
  //   alamatC.text = kk.alamat ?? '';
  //   nikC.text = kk.nik?.toString() ?? '';
  //   selectedAgama = kk.agama;
  //   selectedKelamin = kk.kelamin ?? '';
  //   selectedTanggal = kk.tanggallahir ?? DateTime.now();
  //   selectedPendidikan = kk.pekerjaan;
  //   selectedStatus = kk.status;
  //   selectedWNI = kk.wni ?? '';
  //   rtC.text = kk.rt ?? '';
  //   rwC.text = kk.rw ?? '';
  //   kelurahanC.text = kk.kelurahan ?? '';
  //   kecamatanC.text = kk.kecamatan ?? '';
  //   selectGoldarah = kk.goldarah ?? '';
  // }

  Future store(KK kk, Anggota anggota) async {
    isSaving = true;

    kk.datakeluarga = selectedDataKeluarga;
    kk.jumkeluarga = int.tryParse(jumkeluargaC.text);
    kk.namakepala = namakepalaC.text;
    anggota.namalengkap = namalengkapC.text;
    anggota.gelarbelakang = gelarbelakangC.text;
    anggota.gelardepan = gelardepanC.text;
    anggota.nopaspor = nopasporC.text;
    anggota.tanggalpaspor = selectedTanggalpaspor;
    anggota.namasponsor = namasponsorC.text;
    anggota.tipesponsor = selectedSponsor;
    anggota.alamatsponsor = alamatsponsorC.text;
    kk.kodepos = int.tryParse(kodeposC.text);
    kk.telepon = int.tryParse(teleponC.text);
    anggota.pekerjaan = selectedPekerjaan;
    anggota.agama = selectedAgama;
    anggota.statuskwinpngntr = selectedstatuskwinpngntr;
    anggota.statuskawin = selectedStatus;
    kk.alamat = alamatC.text;
    anggota.kelamin = selectedKelamin;
    anggota.nikibu = int.tryParse(nikibuC.text);
    anggota.tanggallahir = selectedTanggallahir;
    anggota.tempatlahir = tempatC.text;
    anggota.kewarganegaraan = kewarganegaraanC.text;
    anggota.nowali = int.tryParse(nowaliC.text);
    kk.rt = int.tryParse(rtC.text);
    kk.rw = int.tryParse(rwC.text);
    anggota.goldarah = selectGoldarah;
    anggota.aktalahir = selectedAktalahir;
    anggota.noakta = noaktalahirC.text;
    anggota.orgagama = orgagamaC.text;
    anggota.noaktakawin = noaktakawinC.text;
    anggota.aktakawin = selectedAktakawin;
    anggota.tanggalkawin = selectedTanggalkawin;
    anggota.aktacerai = selectedAktacerai;
    anggota.noaktacerai = noaktaceraiC.text;
    anggota.tanggalcerai = selectedTanggalcerai;
    anggota.statuskeluarga = selectedHubungan;
    anggota.cacat = selectedCacat;
    anggota.jeniscacat = selectedJenisCacat;
    anggota.pendidikan = selectedPendidikan;
    anggota.noitas = noitasC.text;
    anggota.tempatitas = tempatItasC.text;
    anggota.tanggalterbititas = selectedTanggalTerbitItas;
    anggota.tanggalitas = selectedTanggalItas;
    anggota.tempatpertama = tempatPertamaC.text;
    anggota.tanggalpertama = selectedTanggalpertama;
    anggota.nikayah = int.tryParse(nikayahC.text);
    anggota.namaibu = namaibuC.text;
    anggota.namaayah = namaayahC.text;
    kk.email = emailC.text;
    kk.keperluan1 = keperluan;
    kk.wni = selectedWNI;
    kk.nik = int.tryParse(nikC.text);
    kk.kk = int.tryParse(kkC.text);
    kk.pendidikan_pngntr = selectedPendidikan_pngntr;
    if (kk.id == null) {
      kk.waktu = DateTime.now();
    }
    try {
      await kk.save();
      Get.defaultDialog(
        title: "Berhasil",
        middleText:
            "Surat Pengajuan Anda Berhasil dan Tunggu Persetujuan Ketua RT",
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

  modelcontroller(KK kk, Anggota anggota) async {
    namalengkapC.text = anggota.namalengkap ?? '';
    alamatC.text = kk.alamat ?? '';
    keperluan = kk.keperluan1 ?? '';
    emailC.text = kk.email ?? '';
  }

  var keperluan = "Pengurusan KK baru";

  void getPDF(KK kk, bool show, Anggota anggota) async {
    final pdf = pw.Document();
    final pdf2 = pw.Document();

    final logopemkot = await networkImage(
        'https://firebasestorage.googleapis.com/v0/b/erte-30198.appspot.com/o/images%2FLogo%20Pemkot%20MLG.png?alt=media&token=1c1b540e-1f74-49c5-acd0-f83f68013d90');

    pdf.addPage(
      pw.Page(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Container(
                            height: 25,
                            width: 25,
                            child: pw.Image(logopemkot))),
                    pw.SizedBox(width: 20),
                    pw.Column(children: [
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text("PEMERINTAH KOTA MALANG",
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold),
                              textAlign: pw.TextAlign.center)),
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text("FORMULIR BIODATA KELUARGA",
                              textAlign: pw.TextAlign.center,
                              style: pw.TextStyle(
                                  fontSize: 7,
                                  fontWeight: pw.FontWeight.bold))),
                    ]),
                    pw.Row(children: [
                      pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Column(children: [
                            pw.Container(height: 7),
                            pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000),
                                        width: 1)),
                                child: pw.Padding(
                                    padding: pw.EdgeInsets.all(3),
                                    child: pw.Text(" GRATIS ",
                                        style: pw.TextStyle(
                                            fontSize: 15,
                                            fontWeight: pw.FontWeight.bold))))
                          ])),
                      pw.SizedBox(width: 10),
                      pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Column(children: [
                            pw.Container(
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Text("     F-1.01     ")),
                            pw.Container(height: 5)
                          ])),
                    ])
                  ]),
              pw.SizedBox(height: 0),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Container(
                    decoration: pw.BoxDecoration(
                        color: PdfColor.fromInt(0xFFCAD2D5),
                        border: pw.Border.all(
                            width: 0.5, color: PdfColor.fromInt(0xFF000000))),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.only(top: 1, bottom: 1),
                        child: pw.Text(
                            " PERHATIAN : ISILAH FORMULIR DENGAN HURUF CETAK YANG JELAS SERTA MENGIKUTI *TATA CARA PENGISIAN FORMULIR* PADA HALAMAN BELAKANG ",
                            style: pw.TextStyle(
                                fontSize: 5, fontWeight: pw.FontWeight.bold)))),
              ),
              pw.SizedBox(height: 2),
              pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text("PILIH SALAH SATU :",
                      style: pw.TextStyle(
                          decoration: pw.TextDecoration.underline,
                          decorationThickness: 2,
                          fontSize: 5,
                          fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 2),
              pw.Row(children: [
                pw.Row(children: [
                  kk.datakeluarga == "Keluarga WNI"
                      ? pw.Container(
                          alignment: pw.Alignment.center,
                          width: 10,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColor.fromInt(0xFF000000),
                                  width: 0.1)),
                          child:
                              pw.Text(" V ", style: pw.TextStyle(fontSize: 5)))
                      : pw.Container(
                          width: 10,
                          height: 5,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColor.fromInt(0xFF000000),
                                  width: 0.1)),
                        ),
                  pw.SizedBox(width: 2),
                  pw.Align(
                      child: pw.Text(
                          "Input Data Kepala Keluarga dan Anggota Keluarga WNI",
                          style: pw.TextStyle(fontSize: 5))),
                ]),
                pw.SizedBox(width: 20),
                pw.Row(children: [
                  kk.datakeluarga == "Keluarga WNA"
                      ? pw.Container(
                          alignment: pw.Alignment.center,
                          width: 10,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColor.fromInt(0xFF000000),
                                  width: 0.1)),
                          child:
                              pw.Text(" V ", style: pw.TextStyle(fontSize: 5)))
                      : pw.Container(
                          width: 10,
                          height: 5,
                          decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                  color: PdfColor.fromInt(0xFF000000),
                                  width: 0.1)),
                        ),
                  pw.SizedBox(width: 2),
                  pw.Align(
                      child: pw.Text(
                          "Input Data Kepala Keluarga dan Anggota Keluarga Orang Asing",
                          style: pw.TextStyle(fontSize: 5))),
                ])
              ]),
              pw.SizedBox(height: 1),
              pw.Row(children: [
                pw.Align(
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text("DATA KEPALA KELUARGA",
                        style: pw.TextStyle(
                            fontSize: 5, fontWeight: pw.FontWeight.bold))),
                pw.SizedBox(width: 400),
                pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.Text("DATA WILAYAH (diisi oleh petugas) :",
                        style: pw.TextStyle(
                            fontSize: 5, fontWeight: pw.FontWeight.bold))),
              ]),
              pw.SizedBox(height: 1),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Align(
                                child: pw.Text("Nama Kepala Keluarga",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Alamat",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Kode Pos",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Telepon",
                                    style: pw.TextStyle(fontSize: 5))),
                            //
                          ]),
                      pw.SizedBox(width: 60),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            kk.namakepala != null
                                ? pw.Container(
                                    width: 330,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                    child: pw.Text(" ${kk.namakepala} ",
                                        style: pw.TextStyle(fontSize: 5)))
                                : pw.Container(
                                    width: 330,
                                    height: 5,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                  ),
                            pw.SizedBox(height: 2),
                            kk.alamat != null
                                ? pw.Container(
                                    width: 330,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                    child: pw.Text(" ${kk.alamat} ",
                                        style: pw.TextStyle(fontSize: 5)))
                                : pw.Container(
                                    width: 330,
                                    height: 5,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                  ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  kk.kodepos != null
                                      ? pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 30,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                          child: pw.Text(" ${kk.kodepos} ",
                                              style: pw.TextStyle(fontSize: 5)))
                                      : pw.Container(
                                          width: 30,
                                          height: 5,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                        ),
                                  pw.SizedBox(width: 5),
                                  pw.Align(
                                      child: pw.Text(" RT  ",
                                          style: pw.TextStyle(fontSize: 5))),
                                  kk.rt != null
                                      ? pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 20,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                          child: pw.Text(" 0${kk.rt} ",
                                              style: pw.TextStyle(fontSize: 5)))
                                      : pw.Container(
                                          width: 30,
                                          height: 5,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                        ),
                                  pw.SizedBox(width: 5),
                                  pw.Align(
                                      child: pw.Text(" RW  ",
                                          style: pw.TextStyle(fontSize: 5))),
                                  kk.rw != null
                                      ? pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 20,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                          child: pw.Text(" 0${kk.rw} ",
                                              style: pw.TextStyle(fontSize: 5)))
                                      : pw.Container(
                                          width: 30,
                                          height: 5,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                        ),
                                  pw.SizedBox(width: 5),
                                  pw.Align(
                                      child: pw.Text(
                                          " Jumlah Anggota Keluarga  ",
                                          style: pw.TextStyle(fontSize: 5))),
                                  kk.jumkeluarga != null
                                      ? pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 15,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                          child: pw.Text(" ${kk.jumkeluarga} ",
                                              style: pw.TextStyle(fontSize: 5)))
                                      : pw.Container(
                                          width: 15,
                                          height: 5,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  color: PdfColor.fromInt(
                                                      0xFF000000),
                                                  width: 0.1)),
                                        ),
                                  pw.Align(
                                      child: pw.Text("  Orang",
                                          style: pw.TextStyle(fontSize: 5))),
                                ]),
                            pw.SizedBox(height: 2),
                            kk.telepon != null
                                ? pw.Container(
                                    width: 80,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                    child: pw.Text(" 0${kk.telepon} ",
                                        style: pw.TextStyle(fontSize: 5)))
                                : pw.Container(
                                    width: 80,
                                    height: 5,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color: PdfColor.fromInt(0xFF000000),
                                            width: 0.1)),
                                  ),
                          ]),
                    ]),
                    pw.Row(children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Align(
                                child: pw.Text("Kode-Nama Provinsi",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Kode-Nama Kabupaten/Kota   ",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Kode-Nama Kecamatan",
                                    style: pw.TextStyle(fontSize: 5))),
                            pw.SizedBox(height: 2),

                            pw.Align(
                                child: pw.Text("Kode-Nama Kelurahan",
                                    style: pw.TextStyle(fontSize: 5))),
                            //
                          ]),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(" :  ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                            pw.SizedBox(height: 2),
                            pw.Text(" : ", style: pw.TextStyle(fontSize: 5)),
                          ]),
                      pw.Column(children: [
                        pw.SizedBox(height: 1.5),
                        pw.Container(
                            width: 10,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 10,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 10,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 10,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                      ]),
                      pw.SizedBox(width: 4),
                      pw.Column(children: [
                        pw.SizedBox(height: 1.5),
                        pw.Container(
                            width: 180,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 180,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 180,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2),
                        pw.Container(
                            width: 180,
                            height: 6,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1))),
                        pw.SizedBox(height: 2)
                      ])
                    ])
                  ]),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text("DATA ANGGOTA KELUARGA",
                      style: pw.TextStyle(
                          fontSize: 5, fontWeight: pw.FontWeight.bold))),
              // Tabel Pertama
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(
                      width: 800,
                      height: 94,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                              color: PdfColor.fromInt(0xFF000000), width: 0.1)),
                      child: pw.Row(children: [
                        pw.Column(children: [
                          pw.Container(
                              width: 9,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("No",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("1",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("1",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("2",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("3",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("4",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("5",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("6",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 9,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("7",
                                      style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Nama Lengkap
                        pw.Column(children: [
                          pw.Container(
                              width: 150,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Nama Lengkap",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 150,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("2",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.namalengkap == null
                              ? pw.Container(
                                  width: 150,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                )
                              : pw.Container(
                                  width: 150,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("${anggota.namalengkap}",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Gelar
                        pw.Column(children: [
                          pw.Container(
                              width: 50,
                              height: 7.5,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Gelar",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Row(children: [
                            pw.Column(children: [
                              pw.Container(
                                  width: 25,
                                  height: 7.5,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColor.fromInt(0xFF000000),
                                          width: 0.1)),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("Depan",
                                          style: pw.TextStyle(fontSize: 4)))),
                              pw.Container(
                                  width: 25,
                                  height: 9,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColor.fromInt(0xFFD9DFDE),
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("3",
                                          style: pw.TextStyle(fontSize: 3.5)))),
                              anggota.gelardepan == null
                                  ? pw.Container(
                                      width: 25,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    )
                                  : pw.Container(
                                      width: 25,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                              "${anggota.gelardepan}",
                                              style:
                                                  pw.TextStyle(fontSize: 4)))),
                            ]),
                            pw.Column(children: [
                              pw.Container(
                                  width: 25,
                                  height: 7.5,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColor.fromInt(0xFF000000),
                                          width: 0.1)),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("Belakang",
                                          style: pw.TextStyle(fontSize: 4)))),
                              pw.Container(
                                  width: 25,
                                  height: 9,
                                  decoration: pw.BoxDecoration(
                                      color: PdfColor.fromInt(0xFFD9DFDE),
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("4",
                                          style: pw.TextStyle(fontSize: 3.5)))),
                              anggota.gelarbelakang == null
                                  ? pw.Container(
                                      width: 25,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    )
                                  : pw.Container(
                                      width: 25,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                              "${anggota.gelarbelakang}",
                                              style:
                                                  pw.TextStyle(fontSize: 4)))),
                            ]),
                          ]),
                        ]),
                        // Kolom Nomor Sponsor
                        pw.Column(children: [
                          pw.Container(
                              width: 50,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Nomor Paspor",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 50,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("5",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.nopaspor == null
                              ? pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                )
                              : pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("${anggota.nopaspor}",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Tanggal Berakhir Sponsor
                        pw.Column(children: [
                          pw.Container(
                              width: 50,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Tgl. Berakhir Paspor",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 50,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("6",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.tanggalpaspor == DateTime(2050, 1, 1)
                              ? pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                )
                              : pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                          "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalpaspor!)}",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Nama Sponsor
                        pw.Column(children: [
                          pw.Container(
                              width: 105.5,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Nama Sponsor",
                                      style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 105.5,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("7",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.namasponsor == null
                              ? pw.Container(
                                  width: 105.5,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                )
                              : pw.Container(
                                  width: 105.5,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("${anggota.namasponsor}",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Tipe Sponsor
                        pw.Column(children: [
                          pw.Container(
                              width: 32,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Tipe\nSponsor",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 32,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("8-(lihat kode)",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          pw.Row(children: [
                            pw.Container(
                                width: 8,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.tipesponsor ==
                                        "Organisasi Internasional"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("1",
                                                        style: pw.TextStyle(
                                                            fontSize: 4))))
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                            pw.Container(
                                width: 8,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.tipesponsor == "Pemerintah"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("2",
                                                        style: pw.TextStyle(
                                                            fontSize: 4))))
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("2",
                                            style: pw.TextStyle(fontSize: 4)))),
                            pw.Container(
                                width: 8,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.tipesponsor == "Perusahaan"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("3",
                                                        style: pw.TextStyle(
                                                            fontSize: 4))))
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("3",
                                            style: pw.TextStyle(fontSize: 4)))),
                            pw.Container(
                                width: 8,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.tipesponsor == "Perorangan"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("4",
                                                        style: pw.TextStyle(
                                                            fontSize: 4))))
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("4",
                                            style: pw.TextStyle(fontSize: 4))))
                          ]),
                        ]),
                        // Kolom Jenis Kelamin
                        pw.Column(children: [
                          pw.Container(
                              width: 32,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Jenis\nKelamin",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 32,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("10-(lihat kode)",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          pw.Row(children: [
                            pw.Container(
                                width: 16,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.kelamin == "Laki-Laki"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("1",
                                                        style: pw.TextStyle(
                                                            fontSize: 4)))),
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                            pw.Container(
                                width: 16,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: anggota.kelamin == "Perempuan"
                                    ? pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                            pw.Container(
                                                height: 7,
                                                width: 7,
                                                decoration: pw.BoxDecoration(
                                                    shape: pw.BoxShape.circle,
                                                    border: pw.Border.all(
                                                        width: 0.1,
                                                        color: PdfColor.fromInt(
                                                            0xFF000000))),
                                                child: pw.Align(
                                                    alignment:
                                                        pw.Alignment.center,
                                                    child: pw.Text("2",
                                                        style: pw.TextStyle(
                                                            fontSize: 4)))),
                                          ])
                                    : pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("2",
                                            style: pw.TextStyle(fontSize: 4)))),
                          ]),
                        ]),
                        // Kolom Tempat Lahir
                        pw.Column(children: [
                          pw.Container(
                              width: 100,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Tempat\nLahir",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 100,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("11",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.tempatlahir == null
                              ? pw.Container(
                                  width: 100,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                )
                              : pw.Container(
                                  width: 100,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                  child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("${anggota.tempatlahir}",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                        // Kolom Tanggal Bulan Tahun Lahir
                        pw.Column(children: [
                          pw.Container(
                              width: 50,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Tanggal/Bulan/Tahun\nLahir",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 50,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("12",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.tanggallahir == DateTime(2050, 1, 1)
                              ? pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColor.fromInt(0xFF000000),
                                          width: 0.1)),
                                )
                              : pw.Container(
                                  width: 50,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          color: PdfColor.fromInt(0xFF000000),
                                          width: 0.1)),
                                  child: pw.Text(
                                      "${DateFormat("dd MMMM y", 'id').format(anggota.tanggallahir!)}",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center)),
                        ])
                      ]))),

              // Tabel Ke 2

              pw.SizedBox(height: 3),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Container(
                  width: 800,
                  height: 94,
                  decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                          color: PdfColor.fromInt(0xFF000000), width: 0.1)),
                  child: pw.Row(
                    children: [
                      pw.Column(children: [
                        pw.Container(
                            width: 9,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("No",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("1",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("1",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("2",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("3",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("4",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("5",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("6",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("7",
                                    style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Kewarganegaraan
                      pw.Column(children: [
                        pw.Container(
                            width: 45,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Kewarganegaraan",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 45,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("13",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.kewarganegaraan == null
                            ? pw.Container(
                                width: 45,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 45,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.kewarganegaraan}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Nomor SK
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nomor SK Penetapan WNI",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("14",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.nowali == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.nowali}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Akta Lahir
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Akta Lahir",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("15-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Row(children: [
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktalahir == "Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("1",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("1",
                                          style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktalahir == "Tidak Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("2",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("2",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                      ]),
                      // Kolom Nomor Akta Kelahiran
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nomor Akta Kelahiran",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("16",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.noakta == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.noakta}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Gol. Darah
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Gol. Darah",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("17-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),

                        //  Gol. Darah
                        anggota.goldarah == null
                            ? pw.Row(children: [
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  width: 12,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                ),
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  width: 12,
                                  height: 10,
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000))),
                                ),
                              ])
                            : anggota.goldarah == "A"
                                ? pw.Row(children: [
                                    pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text("0",
                                                style: pw.TextStyle(
                                                    fontSize: 4)))),
                                    pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text("1",
                                                style: pw.TextStyle(
                                                    fontSize: 4)))),
                                  ])
                                : pw.SizedBox(),
                        anggota.goldarah == "B"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("2",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "AB"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("3",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "O"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("4",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "A+"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("5",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "A-"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("6",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "B+"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("7",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "B-"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("8",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "AB+"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("9",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "AB-"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "O+"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "O-"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("2",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                        anggota.goldarah == "Tidak Tahu"
                            ? pw.Row(children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("1",
                                            style: pw.TextStyle(fontSize: 4)))),
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("3",
                                            style: pw.TextStyle(fontSize: 4)))),
                              ])
                            : pw.SizedBox(),
                      ]),
                      // Kolom Agama
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Agama",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("18-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        // Agama
                        anggota.agama == null
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                ],
                              )
                            : anggota.agama == "Islam"
                                ? pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text("0",
                                                style:
                                                    pw.TextStyle(fontSize: 4))),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text("1",
                                                style:
                                                    pw.TextStyle(fontSize: 4))),
                                      ),
                                    ],
                                  )
                                : pw.SizedBox(),
                        anggota.agama == "Kristen"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("2",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.agama == "Katholik"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("3",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.agama == "Hindu"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("4",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.agama == "Budha"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("5",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.agama == "Konghucu"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("6",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.agama == "Lainnya"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("0",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text("7",
                                            style: pw.TextStyle(fontSize: 4))),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                      ]),
                      // Kolom Nama Organisasi
                      pw.Column(children: [
                        pw.Container(
                            width: 90,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Nama Organisasi Kepercayaan\nTerhadap Tuhan YME",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 90,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("19",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.orgagama == null
                            ? pw.Container(
                                width: 90,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 90,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.orgagama}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Status Perkawinan
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Status\nPerkawinan",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("20-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),

                        // Status Perkawinan
                        anggota.statuskawin == null
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                ],
                              )
                            : anggota.statuskawin == "Belum Kawin"
                                ? pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "0",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "1",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : pw.SizedBox(),
                        anggota.statuskawin == "Kawin Tercatat"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "2",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskawin == "Kawin Belum Tercatat"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "3",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskawin == "Cerai Hidup Tercatat"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "4",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskawin == "Cerai Hidup Belum Tercatat"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "5",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskawin == "Cerai Mati"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "6",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                      ]),
                      // Kolom Akta Perkawinan
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Akta\nPerkawinan",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("21-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Row(children: [
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktakawin == "Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("1",
                                                      style: pw.TextStyle(
                                                          fontSize: 4))))
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("1",
                                          style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktakawin == "Tidak Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("2",
                                                      style: pw.TextStyle(
                                                          fontSize: 4))))
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("2",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                      ]),
                      // Kolom Nomor Akta Perkawinan
                      pw.Column(children: [
                        pw.Container(
                            width: 50,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nomor Akta Perkawinan",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 50,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("22",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.noaktakawin == null
                            ? pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.noaktakawin}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Tanggal Perkawinan
                      pw.Column(children: [
                        pw.Container(
                            width: 48,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Tanggal Perkawinan\n(tgl/bln/thn)",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 48,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("23",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tanggalkawin == DateTime(2050, 1, 1)
                            ? pw.Container(
                                width: 48,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000),
                                        width: 0.1)),
                              )
                            : pw.Container(
                                width: 48,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000),
                                        width: 0.1)),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                        "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalkawin!)}",
                                        style: pw.TextStyle(fontSize: 4),
                                        textAlign: pw.TextAlign.center))),
                      ]),
                      // Kolom Akta Cerai
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Akta Cerai",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("24-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Row(children: [
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktacerai == "Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("1",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("1",
                                          style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.aktacerai == "Tidak Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("2",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("2",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                      ]),
                      // Kolom Nomor Akta Perceraian
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nomor Akta Perceraian",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("25",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.noaktacerai == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.noaktacerai}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      // Kolom Tanggal Perceraian
                      pw.Column(children: [
                        pw.Container(
                            width: 48,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Tanggal Perceraian\n(tgl/bln/thn)",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 48,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("26",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tanggalcerai == DateTime(2050, 1, 1)
                            ? pw.Container(
                                width: 48,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000),
                                        width: 0.1)),
                              )
                            : pw.Container(
                                width: 48,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        color: PdfColor.fromInt(0xFF000000),
                                        width: 0.1)),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                        "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalcerai!)}",
                                        style: pw.TextStyle(fontSize: 4),
                                        textAlign: pw.TextAlign.center))),
                      ]),
                      // Kolom Status Hubungan Keluarga
                      pw.Column(children: [
                        pw.Container(
                            width: 42,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Status Dalam\nHubungan Keluarga",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 42,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("27-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.statuskeluarga == null
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                  ),
                                ],
                              )
                            : anggota.statuskeluarga == "Kepala Keluarga"
                                ? pw.Row(
                                    children: [
                                      pw.Container(
                                        width: 21,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "0",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        width: 21,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "1",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : pw.SizedBox(),
                        anggota.statuskeluarga == "Suami"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "2",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Istri"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "3",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Anak"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "4",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Menantu"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "5",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Cucu"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "6",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Orang Tua"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "7",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Mertua"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "8",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Famili"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "9",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.statuskeluarga == "Lainnya"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "1",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    width: 21,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            width: 0.1,
                                            color:
                                                PdfColor.fromInt(0xFF000000))),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                      ]),
                      // Kolom Kelainan Fisik
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Kelainan\nFisik/Mental",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("28-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Row(children: [
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.cacat == "Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("1",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("1",
                                          style: pw.TextStyle(fontSize: 4)))),
                          pw.Container(
                              width: 12,
                              height: 10,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: anggota.cacat == "Tidak Ada"
                                  ? pw.Row(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      children: [
                                          pw.Container(
                                              height: 7,
                                              width: 7,
                                              decoration: pw.BoxDecoration(
                                                  shape: pw.BoxShape.circle,
                                                  border: pw.Border.all(
                                                      width: 0.1,
                                                      color: PdfColor.fromInt(
                                                          0xFF000000))),
                                              child: pw.Align(
                                                  alignment:
                                                      pw.Alignment.center,
                                                  child: pw.Text("2",
                                                      style: pw.TextStyle(
                                                          fontSize: 4)))),
                                        ])
                                  : pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text("2",
                                          style: pw.TextStyle(fontSize: 4)))),
                        ]),
                      ]),
                      // Kolom Penyandang Cacat
                      pw.Column(children: [
                        pw.Container(
                            width: 24,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Penyandang\nCacat",
                                    style: pw.TextStyle(fontSize: 4),
                                    textAlign: pw.TextAlign.center))),
                        pw.Container(
                            width: 24,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("29-(lihat kode)",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.jeniscacat == null
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : anggota.jeniscacat == "Cacat Fisik"
                                ? pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            width: 0.1,
                                            color: PdfColor.fromInt(0xFF000000),
                                          ),
                                        ),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "0",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 12,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                            width: 0.1,
                                            color: PdfColor.fromInt(0xFF000000),
                                          ),
                                        ),
                                        child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text(
                                            "1",
                                            style: pw.TextStyle(fontSize: 4),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : pw.SizedBox(),
                        anggota.jeniscacat == "Cacat Netra/Buta"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "2",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.jeniscacat == "Cacat Rungu/Bicara"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "3",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.jeniscacat == "Cacat Mental/Jiwa"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "4",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.jeniscacat == "Cacat Fisik dan Mental"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "5",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                        anggota.jeniscacat == "Cacat Lainnya"
                            ? pw.Row(
                                children: [
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "0",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                  pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 12,
                                    height: 10,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000),
                                      ),
                                    ),
                                    child: pw.Align(
                                      alignment: pw.Alignment.center,
                                      child: pw.Text(
                                        "6",
                                        style: pw.TextStyle(fontSize: 4),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : pw.SizedBox(),
                      ]),
                      //Kolom Pendidikan
                      pw.Column(
                        children: [
                          pw.Container(
                              width: 24,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Pendidikan\nTerakhir",
                                      style: pw.TextStyle(fontSize: 4),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 24,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("30-(lihat kode)",
                                      style: pw.TextStyle(fontSize: 3.5)))),
                          anggota.pendidikan == null
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    ),
                                  ],
                                )
                              : anggota.pendidikan == "Tidak/Belum Sekolah"
                                  ? pw.Row(
                                      children: [
                                        pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 12,
                                          height: 10,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                              width: 0.1,
                                              color:
                                                  PdfColor.fromInt(0xFF000000),
                                            ),
                                          ),
                                          child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text(
                                              "0",
                                              style: pw.TextStyle(fontSize: 4),
                                            ),
                                          ),
                                        ),
                                        pw.Container(
                                          alignment: pw.Alignment.center,
                                          width: 12,
                                          height: 10,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                              width: 0.1,
                                              color:
                                                  PdfColor.fromInt(0xFF000000),
                                            ),
                                          ),
                                          child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text(
                                              "1",
                                              style: pw.TextStyle(fontSize: 4),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : pw.SizedBox(),
                          anggota.pendidikan == "Belum Tamat SD/Sederajat"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "2",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "Tamat SD/Sederajat"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "3",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "SLTP/Sederajat"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "4",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "SLTA/Sederajat"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "5",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "Diploma VII"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "6",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan ==
                                  "Akademi/Diploma III/Sarjana Muda"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "7",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "Diploma IV/Strata I/Strata II"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "8",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "Strata III"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "9",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                          anggota.pendidikan == "Lainnya"
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "1",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                    pw.Container(
                                      alignment: pw.Alignment.center,
                                      width: 12,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                          width: 0.1,
                                          color: PdfColor.fromInt(0xFF000000),
                                        ),
                                      ),
                                      child: pw.Align(
                                        alignment: pw.Alignment.center,
                                        child: pw.Text(
                                          "0",
                                          style: pw.TextStyle(fontSize: 4),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : pw.SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(height: 3),

              // Tabel Ke 3

              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Container(
                    width: 800,
                    height: 94,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            color: PdfColor.fromInt(0xFF000000), width: 0.1)),
                    child: pw.Row(children: [
                      pw.Column(children: [
                        pw.Container(
                            width: 9,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("No",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("1",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("1",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("2",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("3",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("4",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("5",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("6",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 9,
                            height: 10,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("7",
                                    style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Column(children: [
                          pw.Container(
                              width: 32,
                              height: 15,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      color: PdfColor.fromInt(0xFF000000),
                                      width: 0.1)),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("Jenis\nPekerjaan",
                                      style: pw.TextStyle(
                                        fontSize: 5,
                                      ),
                                      textAlign: pw.TextAlign.center))),
                          pw.Container(
                              width: 32,
                              height: 9,
                              decoration: pw.BoxDecoration(
                                  color: PdfColor.fromInt(0xFFD9DFDE),
                                  border: pw.Border.all(
                                      width: 0.1,
                                      color: PdfColor.fromInt(0xFF000000))),
                              child: pw.Align(
                                  alignment: pw.Alignment.center,
                                  child: pw.Text("31-(lihat kode)",
                                      style: pw.TextStyle(fontSize: 4)))),
                          anggota.pekerjaan == null
                              ? pw.Row(
                                  children: [
                                    pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    ),
                                    pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                    ),
                                  ],
                                )
                              : anggota.pekerjaan == "Belum/Tidak Bekerja"
                                  ? pw.Row(children: [
                                      pw.Container(
                                        width: 16,
                                        height: 10,
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all(
                                                width: 0.1,
                                                color: PdfColor.fromInt(
                                                    0xFF000000))),
                                        child: pw.Align(
                                            alignment: pw.Alignment.center,
                                            child: pw.Text("0",
                                                style:
                                                    pw.TextStyle(fontSize: 5))),
                                      ),
                                      pw.Container(
                                          width: 16,
                                          height: 10,
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 0.1,
                                                  color: PdfColor.fromInt(
                                                      0xFF000000))),
                                          child: pw.Align(
                                              alignment: pw.Alignment.center,
                                              child: pw.Text("1",
                                                  style: pw.TextStyle(
                                                      fontSize: 5))))
                                    ])
                                  : pw.SizedBox(),
                          anggota.pekerjaan == "Mengurus Rumah Tangga"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pelajar/Mahasiswa"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pensiunan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pegawai Negeri Sipil"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tentara Nasional Indonesia"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Kepolisian RI"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Perdagangan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Petani/Pekebun"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Peternak"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Nelayan/Perikanan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Industri"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Konstruksi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Transportasi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Karyawan Swasta"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Karyawan BUMN"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Karyawan BUMD"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Karyawan Honorer"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Buruh Harian Lepas"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Buruh Tani/Perkebunan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Buruh Nelayan/Perikanan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Buruh Peternakan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pembantu Rumah Tangga"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Cukur"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Listrik"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Batu"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Kayu"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Sol Sepatu"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Las/Pandai Besi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Jahit"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tukang Gigi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penata Rias"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penata Busana"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penata Rambut"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Mekanik"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Seniman"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tabib"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Paraji"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Perancang Busana"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penterjemah"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Imam Masjid"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pendeta"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pastor"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wartawan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Ustadz/Mubaligh"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Juru Masak"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Promotor Acara"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota DPR-RI"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota DPD"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota BPK"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Presiden"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wakil Presiden"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota Mahkamah Konstitusi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota Kabinet/Kementrian"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Duta Besar"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Gubernur"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wakil Gubernur"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Bupati"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wakil Bupati"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Walikota"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wakil Walikota"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota DPRD Provinsi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota DPRD Kab/Kota"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Dosen"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Guru"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pilot"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pengacara"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Notaris"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Arsitek"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Akuntan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Konsultan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Dokter"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Bidan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Perawat"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Apoteker"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Psikiater/Psikolog"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penyiar Televisi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Penyiar Radio"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pelaut"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Peneliti"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Sopir"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pialang"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Paranormal"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pedagang"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Perangkat Desa"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Kepala Desa"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Biarawati"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Wiraswasta"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Anggota Lembaga Tinggi Lainnya"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Artis"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("0",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Atlit"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("1",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Chef"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("2",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Manajer"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("3",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Tenaga Tata Usaha"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("4",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Operator"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("5",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Pekerja Pengolahan Kerajinan"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("6",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Teknisi"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("7",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Asisten Ahli"
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("8",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                          anggota.pekerjaan == "Lainnya........."
                              ? pw.Row(children: [
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5)))),
                                  pw.Container(
                                      width: 16,
                                      height: 10,
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 0.1,
                                              color: PdfColor.fromInt(
                                                  0xFF000000))),
                                      child: pw.Align(
                                          alignment: pw.Alignment.center,
                                          child: pw.Text("9",
                                              style:
                                                  pw.TextStyle(fontSize: 5))))
                                ])
                              : pw.SizedBox(),
                        ]),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nomor ITAS/ITAP",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("32",
                                    style: pw.TextStyle(fontSize: 4)))),
                        anggota.noitas == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.noitas}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Tempat Terbit ITAS/ITAP",
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("33",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tempatitas == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.tempatitas}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 50,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Tgl. Terbit ITAS/ITAP\n(tgl/bln/thn)",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 50,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("34",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tanggalterbititas == DateTime(2050, 1, 1)
                            ? pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                        "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalterbititas!)}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 50,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Tgl. Berakhir ITAS/ITAP\n(tgl/bln/thn)",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 50,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("35",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tanggalitas == DateTime(2050, 1, 1)
                            ? pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                        "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalitas!)}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 60,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Tempat Kedatangan\nPertama",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 60,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("36",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tempatpertama == null
                            ? pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 60,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.tempatpertama}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 50,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    "Tgl. Kedatangan Pertama\n(tgl/bln/thn)",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 3)))),
                        pw.Container(
                            width: 50,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("37",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.tanggalpertama == DateTime(2050, 1, 1)
                            ? pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 50,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                        "${DateFormat("dd MMMM y", 'id').format(anggota.tanggalpertama!)}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 89.25,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("NIK Ibu",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 89.25,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("38",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.nikibu == null
                            ? pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.nikibu}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 89.25,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nama Ibu",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 89.25,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("39",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.namaibu == null
                            ? pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.namaibu}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 89.25,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("NIK Ayah",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 89.25,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("40",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.nikayah == null
                            ? pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.nikayah}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                      pw.Column(children: [
                        pw.Container(
                            width: 89.25,
                            height: 15,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    color: PdfColor.fromInt(0xFF000000),
                                    width: 0.1)),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("Nama Ayah",
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(fontSize: 4)))),
                        pw.Container(
                            width: 89.25,
                            height: 9,
                            decoration: pw.BoxDecoration(
                                color: PdfColor.fromInt(0xFFD9DFDE),
                                border: pw.Border.all(
                                    width: 0.1,
                                    color: PdfColor.fromInt(0xFF000000))),
                            child: pw.Align(
                                alignment: pw.Alignment.center,
                                child: pw.Text("41",
                                    style: pw.TextStyle(fontSize: 3.5)))),
                        anggota.namaayah == null
                            ? pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                              )
                            : pw.Container(
                                width: 89.25,
                                height: 10,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 0.1,
                                        color: PdfColor.fromInt(0xFF000000))),
                                child: pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text("${anggota.namaayah}",
                                        style: pw.TextStyle(fontSize: 4)))),
                      ]),
                    ])),
              ),
              pw.SizedBox(height: 4),

              //Row Bagian TTD
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                              'Mengetahui,\nKepala Dinas Kependudukan dan Pencatatan Sipil Kota Malang',
                              style: pw.TextStyle(fontSize: 5)),
                          pw.SizedBox(height: 30),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Container(
                                width: 100,
                                child: pw.Divider(height: 1, thickness: 1)),
                          ),
                          pw.SizedBox(height: 1),
                          pw.Text('NIP :', style: pw.TextStyle(fontSize: 5))
                        ]),
                    pw.Column(children: [
                      pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            '................, .........................................\nKepala Keluarga,',
                            style: pw.TextStyle(fontSize: 5)),
                      ),
                      pw.SizedBox(height: 15),
                      pw.Text("Nama / TTD / Cap Jempol",
                          style: pw.TextStyle(
                              fontSize: 5,
                              color: PdfColor.fromInt(0xFFBFBFBF))),
                      pw.SizedBox(height: 15),
                      pw.Container(
                          width: 80, child: pw.Divider(height: 1, thickness: 1))
                    ]),
                  ]),
              pw.SizedBox(height: 5),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text("PERNYATAAN :",
                      style: pw.TextStyle(
                          decoration: pw.TextDecoration.underline,
                          decorationThickness: 2,
                          fontSize: 5,
                          fontWeight: pw.FontWeight.bold))),
              pw.SizedBox(height: 1),
              pw.Align(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                      "Demikian Formulir ini saya/kami isi dengan sesungguhnya. Apabila keterangan tersebut tidak sesuai dengan keadaan sebenarnya, saya bersedia dikenakan sanksi sesuai ketentuan peraturan perundang-undangan yang berlaku.",
                      style: pw.TextStyle(fontSize: 5)))
            ],
          );
        },
      ),
    );

    pdf2.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              children: [
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "RUKUN TETANGGA ( RT ) II RUKUN WARGA ( RW ) IX",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "KELURAHAN GADANG KECAMATAN SUKUN",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "KOTA MALANG",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(width: 40),
                    pw.Text(
                      "Sekretariat : Jl. Satsui Tubun - ( Perum Green Living Residence )",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(width: 8),
                    pw.Text(
                      "Kode Pos : 65149",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),
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
                          child: pw.Text(
                            "Malang, ${DateFormat("dd MMMM y", 'id').format(DateTime.now())}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Kepada :",
                              style: pw.TextStyle(fontSize: 10),
                            )),
                        pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Yth. Sdr. Lurah Gadang",
                              style: pw.TextStyle(fontSize: 10),
                            )),
                        pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Kecamatan Sukun Kota Malang",
                              style: pw.TextStyle(fontSize: 10),
                            )),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "di MALANG",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Text(
                  "SURAT PENGANTAR",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                // pw.Divider(
                //   color: PdfColor.fromInt(0xFF000000),
                //   height: 1,
                //   thickness: 2,
                // ),
                pw.SizedBox(
                  height: 2,
                ),
                pw.Text(
                  "Nomor : ${kk.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
                  style: pw.TextStyle(fontSize: 10),
                ),
                pw.SizedBox(
                  height: 8,
                ),
                pw.Text(
                  "Yang bertanda tangan dibawah ini Ketua RT. II RW. IX Kelurahan Gadang Kecamatan",
                  style: pw.TextStyle(fontSize: 10),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Sukun Kota Malang dengan ini menerangkan bahwa :",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.SizedBox(height: 8),
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
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Jenis Kelamin",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Tempat / Tgl. Lahir",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Agama",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Status",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Kewarganegaraan",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Pendidikan",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Pekerjaan",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "NIK",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Nomor Kartu Keluarga",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Alamat",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 15),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Keperluan",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                        ]),
                    pw.SizedBox(width: 20),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        anggota.namalengkap != null
                            ? pw.Text(
                                " : ${anggota.namalengkap}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        anggota.kelamin == "Laki-Laki"
                            ? pw.Row(children: [
                                pw.Text(
                                  " : Laki-Laki / ",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                pw.Text(
                                  "Perempuan",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough),
                                )
                              ])
                            : anggota.kelamin == "Perempuan"
                                ? pw.Row(children: [
                                    pw.Text(
                                      " : ",
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    pw.Text(
                                      "Laki-Laki",
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          decoration:
                                              pw.TextDecoration.lineThrough),
                                    ),
                                    pw.Text(
                                      " / Perempuan",
                                      style: pw.TextStyle(fontSize: 10),
                                    )
                                  ])
                                : pw.Row(children: [
                                    pw.Text(
                                      " : ",
                                      style: pw.TextStyle(fontSize: 10),
                                    ),
                                    pw.Text(
                                      "Laki-Laki",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    pw.Text(
                                      " / Perempuan",
                                      style: pw.TextStyle(fontSize: 10),
                                    )
                                  ]),
                        pw.SizedBox(height: 8),
                        anggota.tempatlahir != null &&
                                anggota.tanggallahir == DateTime(2050, 1, 1)
                            ? pw.Text(
                                ": ${anggota.tempatlahir} / ...........................",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : .......... / ${DateFormat("dd MMMM y", 'id').format(anggota.tanggallahir!)}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        anggota.agama == "Islam"
                            ? pw.Row(children: [
                                pw.Text(" : ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Islam",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Katholik",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Kristen",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Hindu",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Budha",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Khonghucu",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                              ])
                            : anggota.agama == "Katholik"
                                ? pw.Row(children: [
                                    pw.Text(" : ",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text("Islam",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Katholik",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Kristen",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Hindu",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Budha",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Khonghucu",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                  ])
                                : anggota.agama == "Kristen"
                                    ? pw.Row(children: [
                                        pw.Text(" : ",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text("Islam",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Katholik",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Kristen",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Hindu",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Budha",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Khonghucu",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                      ])
                                    : anggota.agama == "Hindu"
                                        ? pw.Row(children: [
                                            pw.Text(" : ",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text("Islam",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Katholik",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Kristen",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Hindu",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Budha",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Khonghucu",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                          ])
                                        : anggota.agama == "Budha"
                                            ? pw.Row(children: [
                                                pw.Text(" : ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text("Islam",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Katholik",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Kristen",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Hindu",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Budha",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Khonghucu",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                              ])
                                            : anggota.agama == "Khonghucu"
                                                ? pw.Row(children: [
                                                    pw.Text(" : ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text("Islam",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Katholik",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Kristen",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Hindu",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Budha",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Khonghucu",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                  ])
                                                : pw.Row(children: [
                                                    pw.Text(" : ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Islam",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Katholik",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Kristen",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Hindu",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Budha",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(
                                                      "Khonghucu",
                                                      style: pw.TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ]),
                        pw.SizedBox(height: 8),
                        anggota.statuskwinpngntr == "Belum Kawin"
                            ? pw.Row(children: [
                                pw.Text(" : ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Belum Kawin",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Kawin",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Cerai Hidup",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Cerai Mati",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                              ])
                            : anggota.statuskwinpngntr == "Kawin"
                                ? pw.Row(children: [
                                    pw.Text(" : ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Belum Kawin",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Kawin",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Cerai Hidup",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Cerai Mati",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                  ])
                                : anggota.statuskwinpngntr == "Cerai Hidup"
                                    ? pw.Row(children: [
                                        pw.Text(" : ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Belum Kawin",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Kawin",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Cerai Hidup",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Cerai Mati",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                      ])
                                    : anggota.statuskwinpngntr == "Cerai Mati"
                                        ? pw.Row(children: [
                                            pw.Text(" : ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Belum Kawin",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Kawin",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Cerai Hidup",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Cerai Mati",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                          ])
                                        : pw.Row(children: [
                                            pw.Text(" : ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Belum Kawin",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Kawin",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Cerai Hidup",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Cerai Mati",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                          ]),
                        pw.SizedBox(height: 8),
                        kk.wni == "WNI"
                            ? pw.Row(children: [
                                pw.Text(" : ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("WNI",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("WNA",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                              ])
                            : kk.wni == "WNA"
                                ? pw.Row(children: [
                                    pw.Text(" : ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("WNI",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("WNA",
                                        style: pw.TextStyle(fontSize: 10)),
                                  ])
                                : pw.Row(children: [
                                    pw.Text(" : ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("WNI",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("WNA",
                                        style: pw.TextStyle(fontSize: 10)),
                                  ]),
                        pw.SizedBox(height: 8),
                        kk.pendidikan_pngntr == "SD"
                            ? pw.Row(children: [
                                pw.Text(" : ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SD",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SLTP",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SLTA",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SMK",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SI",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("SII",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                                pw.Text(" / ",
                                    style: pw.TextStyle(fontSize: 10)),
                                pw.Text("Sederajat",
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        decoration:
                                            pw.TextDecoration.lineThrough)),
                              ])
                            : kk.pendidikan_pngntr == "SLTP"
                                ? pw.Row(children: [
                                    pw.Text(" : ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SD",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SLTP",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SLTA",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SMK",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SI",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("SII",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                    pw.Text(" / ",
                                        style: pw.TextStyle(fontSize: 10)),
                                    pw.Text("Sederajat",
                                        style: pw.TextStyle(
                                            fontSize: 10,
                                            decoration:
                                                pw.TextDecoration.lineThrough)),
                                  ])
                                : kk.pendidikan_pngntr == "SLTA"
                                    ? pw.Row(children: [
                                        pw.Text(" : ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SD",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SLTP",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SLTA",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SMK",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SI",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("SII",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                        pw.Text(" / ",
                                            style: pw.TextStyle(fontSize: 10)),
                                        pw.Text("Sederajat",
                                            style: pw.TextStyle(
                                                fontSize: 10,
                                                decoration: pw.TextDecoration
                                                    .lineThrough)),
                                      ])
                                    : kk.pendidikan_pngntr == "SMK"
                                        ? pw.Row(children: [
                                            pw.Text(" : ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SD",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SLTP",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SLTA",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SMK",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SI",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("SII",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                            pw.Text(" / ",
                                                style:
                                                    pw.TextStyle(fontSize: 10)),
                                            pw.Text("Sederajat",
                                                style: pw.TextStyle(
                                                    fontSize: 10,
                                                    decoration: pw
                                                        .TextDecoration
                                                        .lineThrough)),
                                          ])
                                        : kk.pendidikan_pngntr == "SI"
                                            ? pw.Row(children: [
                                                pw.Text(" : ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SD",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SLTP",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SLTA",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SMK",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SI",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("SII",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                                pw.Text(" / ",
                                                    style: pw.TextStyle(
                                                        fontSize: 10)),
                                                pw.Text("Sederajat",
                                                    style: pw.TextStyle(
                                                        fontSize: 10,
                                                        decoration: pw
                                                            .TextDecoration
                                                            .lineThrough)),
                                              ])
                                            : kk.pendidikan_pngntr == "SII"
                                                ? pw.Row(children: [
                                                    pw.Text(" : ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SD",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SLTP",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SLTA",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SMK",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SI",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("SII",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text(" / ",
                                                        style: pw.TextStyle(
                                                            fontSize: 10)),
                                                    pw.Text("Sederajat",
                                                        style: pw.TextStyle(
                                                            fontSize: 10,
                                                            decoration: pw
                                                                .TextDecoration
                                                                .lineThrough)),
                                                  ])
                                                : kk.pendidikan_pngntr ==
                                                        "Sederajat"
                                                    ? pw.Row(children: [
                                                        pw.Text(" : ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SD",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SLTP",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SLTA",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SMK",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SI",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SII",
                                                            style: pw.TextStyle(
                                                                fontSize: 10,
                                                                decoration: pw
                                                                    .TextDecoration
                                                                    .lineThrough)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("Sederajat",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                      ])
                                                    : pw.Row(children: [
                                                        pw.Text(" : ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SD",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SLTP",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SLTA",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SMK",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SI",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("SII",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text(" / ",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                        pw.Text("Sederajat",
                                                            style: pw.TextStyle(
                                                                fontSize: 10)),
                                                      ]),
                        pw.SizedBox(height: 8),
                        anggota.pekerjaan != null
                            ? pw.Text(
                                " : ${anggota.pekerjaan}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        kk.nik != null
                            ? pw.Text(
                                " : ${kk.nik}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        kk.kk != null
                            ? pw.Text(
                                " : ${kk.kk}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        kk.alamat != null
                            ? pw.Text(
                                " : ${kk.alamat}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                " : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 15),
                        kk.keperluan1 == null
                            ? pw.Text(
                                "  1. ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                "  1. ${kk.keperluan1}",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          "  2. ........................................",
                          style: pw.TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    "Demikian untuk menjadikan periksa dan dipergunakan sebagai mestinya.",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Nomor      : ${kk.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(
                    "Tanggal    : ${DateFormat("dd MMMM y", 'id').format(DateTime.now())}",
                    style: pw.TextStyle(fontSize: 10),
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Mengetahui,",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "KETUA RW. IX",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "KELURAHAN GADANG",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 80),
                          pw.Text(
                            "(.......................)",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ]),
                    pw.SizedBox(width: 120),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "KETUA RT. II / RW. IX",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "KELURAHAN GADANG",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.SizedBox(height: 80),
                        pw.Text(
                          "(.......................)",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );

    Uint8List bytes = await pdf.save();
    Uint8List bytes2 = await pdf2.save();

    //file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Form KK.pdf');

    final dir2 = await getApplicationDocumentsDirectory();
    final file2 = File('${dir2.path}/Surat Pengantar KK.pdf');

    //timpa file kosong dengan pdf
    await file.writeAsBytes(bytes);

    await file2.writeAsBytes(bytes2);

    //open file
    if (show == true) {
      await OpenFile.open(file2.path);
    } else if (show == false) {
      final Email email = Email(
        body: 'Email body',
        subject: 'Email subject',
        recipients: [kk.email!],
        attachmentPaths: [file.path, file2.path],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } else {}
  }

  @override
  void onInit() {
    super.onInit();
    namalengkapC = TextEditingController();
    namakepalaC = TextEditingController();
    namasponsorC = TextEditingController();
    namaayahC = TextEditingController();
    namaibuC = TextEditingController();
    kodeposC = TextEditingController();
    jumkeluargaC = TextEditingController();
    teleponC = TextEditingController();
    gelardepanC = TextEditingController();
    gelarbelakangC = TextEditingController();
    nopasporC = TextEditingController();
    tempatC = TextEditingController();
    pekerjaanC = TextEditingController();
    nikibuC = TextEditingController();
    nikayahC = TextEditingController();
    noitasC = TextEditingController();
    tempatItasC = TextEditingController();
    tempatPertamaC = TextEditingController();
    alamatC = TextEditingController();
    alamatsponsorC = TextEditingController();
    rtC = TextEditingController();
    rwC = TextEditingController();
    nowaliC = TextEditingController();

    noaktalahirC = TextEditingController();
    noaktakawinC = TextEditingController();
    noaktaceraiC = TextEditingController();
    orgagamaC = TextEditingController();
    kewarganegaraanC = TextEditingController();
    nikC = TextEditingController();
    kkC = TextEditingController();
    emailC = TextEditingController();
    rxKK.bindStream(KK().listKK());
  }

  @override
  void onReady() {
    super.onReady();
  }
}
