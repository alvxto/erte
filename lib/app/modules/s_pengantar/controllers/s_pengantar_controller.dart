import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class SPengantarController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController tempatC;
  late TextEditingController pekerjaanC;
  late TextEditingController nikC;
  late TextEditingController kkC;
  late TextEditingController alamatC;
  late TextEditingController keperluanC;
  UserModel? selectedUser;
  late TextEditingController emailC;

  FirebaseStorage storage = FirebaseStorage.instance;

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

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  // modelToController(Pengantar pengantar) {
  //   namaC.text = pengantar.nama ?? '';
  //   tempatC.text = pengantar.tempatlahir ?? '';
  //   pekerjaanC.text = pengantar.pekerjaan ?? '';
  //   alamatC.text = pengantar.alamat ?? '';
  //   keperluanC.text = pengantar.keperluan ?? '';
  //   nikC.text = pengantar.nik?.toString() ?? '';
  //   kkC.text = pengantar.kk?.toString() ?? '';
  //   selectedAgama = pengantar.agama;
  //   selectedKelamin = pengantar.kelamin ?? '';
  //   selectedTanggal = pengantar.tanggallahir ?? DateTime.now();
  //   selectedPendidikan = pengantar.pekerjaan;
  //   selectedStatus = pengantar.status;
  //   selectedWNI = pengantar.wni ?? '';
  // }

  controllertomodel(Pengantar pengantar) async {
    pengantar.nama = namaC.text;
    pengantar.pekerjaan = pekerjaanC.text;
    pengantar.agama = selectedAgama;
    pengantar.pendidikan = selectedPendidikan;
    pengantar.status = selectedStatus;
    pengantar.alamat = alamatC.text;
    pengantar.keperluan1 = selectedKeperluan1;
    pengantar.keperluan2 = selectedKeperluan2;
    pengantar.wni = selectedWNI;
    pengantar.kelamin = selectedKelamin;
    pengantar.nik = int.tryParse(nikC.text);
    pengantar.kk = int.tryParse(kkC.text);
    pengantar.tanggallahir = selectedTanggal;
    pengantar.tempatlahir = tempatC.text;
    pengantar.email = emailC.text;
    if (pengantar.id == null) {
      pengantar.waktu = DateTime.now();
    }
    return pengantar;
  }

  Future store(Pengantar pengantar) async {
    isSaving = true;

    pengantar.nama = namaC.text;
    pengantar.pekerjaan = pekerjaanC.text;
    pengantar.agama = selectedAgama;
    pengantar.pendidikan = selectedPendidikan;
    pengantar.status = selectedStatus;
    pengantar.alamat = alamatC.text;
    pengantar.keperluan1 = selectedKeperluan1;
    pengantar.keperluan2 = selectedKeperluan2;
    pengantar.wni = selectedWNI;
    pengantar.kelamin = selectedKelamin;
    pengantar.nik = int.tryParse(nikC.text);
    pengantar.kk = int.tryParse(kkC.text);
    pengantar.tanggallahir = selectedTanggal;
    pengantar.tempatlahir = tempatC.text;
    pengantar.email = emailC.text;
    if (pengantar.id == null) {
      pengantar.waktu = DateTime.now();
    }
    try {
      await pengantar.save();
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
          kkC.clear();
          alamatC.clear();
          keperluanC.clear();
          selectedAgama = '';
          selectedKelamin = '';
          selectedPendidikan = '';
          selectedStatus = '';
          selectedWNI = '';
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

  void getPDF(Pengantar pengantar) async {
    //dokumen
    final pdf = pw.Document();

    Pengantar nomerC = await Pengantar().streamList();
    if (pengantar.nomer == null) {
      (pengantar.nomer = nomerC.nomer ?? 0) + 1;
    }
    pengantar.nama = namaC.text;
    pengantar.pekerjaan = pekerjaanC.text;
    pengantar.agama = selectedAgama;
    pengantar.pendidikan = selectedPendidikan;
    pengantar.status = selectedStatus;
    pengantar.alamat = alamatC.text;
    pengantar.keperluan1 = selectedKeperluan1;
    pengantar.keperluan2 = selectedKeperluan2;
    pengantar.wni = selectedWNI;
    pengantar.kelamin = selectedKelamin;
    pengantar.nik = int.tryParse(nikC.text);
    pengantar.kk = int.tryParse(kkC.text);
    pengantar.tanggallahir = selectedTanggal;
    pengantar.tempatlahir = tempatC.text;
    pengantar.email = emailC.text;
    if (pengantar.id == null) {
      pengantar.waktu = DateTime.now();
    }

    //page
    pdf.addPage(
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
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "KOTA MALANG",
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold,
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
                    pw.SizedBox(height: 8),
                    pw.Text(
                      "Kode Pos : 65149",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ]),
              pw.SizedBox(height: 6),
              pw.Divider(
                color: PdfColor.fromInt(0xFF000000),
                height: 1,
                thickness: 2,
              ),
              pw.SizedBox(height: 8),
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
              //     color: PdfColor.fromInt(0xFF000000),
              //     height: 1,
              //     thickness: 2,
              //   ),
              pw.SizedBox(
                height: 2,
              ),
              pw.Text(
                "Nomor : ${pengantar.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
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
                  )),
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
                          "Tempat / Tgl Lahir",
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
                    ],
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pengantar.nama != null
                          ? pw.Text(
                              " : ${pengantar.nama}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : ........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.kelamin == "Laki-Laki"
                          ? pw.Row(children: [
                              pw.Text(
                                " : Laki-Laki / ",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.Text(
                                "Perempuan",
                                style: pw.TextStyle(
                                    fontSize: 10,
                                    decoration: pw.TextDecoration.lineThrough),
                              )
                            ])
                          : pengantar.kelamin == "Perempuan"
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
                      pengantar.tempatlahir != null &&
                              pengantar.tanggallahir != null
                          ? pw.Text(
                              " : ${pengantar.tempatlahir} / ${DateFormat("dd MMMM y", 'id').format(pengantar.tanggallahir!)}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              ":........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.agama == "Islam"
                          ? pw.Row(children: [
                              pw.Text(" : ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Islam",
                                  style: pw.TextStyle(fontSize: 10)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Katholik",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Kristen",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Hindu",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Budha",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Khonghucu",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                            ])
                          : pengantar.agama == "Katholik"
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
                              : pengantar.agama == "Kristen"
                                  ? pw.Row(children: [
                                      pw.Text(" : ",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text("Islam",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Katholik",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Kristen",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Hindu",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Budha",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Khonghucu",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                    ])
                                  : pengantar.agama == "Hindu"
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
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Katholik",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Kristen",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
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
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Khonghucu",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                        ])
                                      : pengantar.agama == "Budha"
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
                                          : pengantar.agama == "Khonghucu"
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
                      pengantar.status == "Belum Kawin"
                          ? pw.Row(children: [
                              pw.Text(" : ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Belum Kawin",
                                  style: pw.TextStyle(fontSize: 10)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Kawin",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Cerai Hidup",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Cerai Mati",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                            ])
                          : pengantar.status == "Kawin"
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
                              : pengantar.status == "Cerai Hidup"
                                  ? pw.Row(children: [
                                      pw.Text(" : ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Belum Kawin",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Kawin",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Cerai Hidup",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Cerai Mati",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                    ])
                                  : pengantar.status == "Cerai Mati"
                                      ? pw.Row(children: [
                                          pw.Text(" : ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Belum Kawin",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Kawin",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Cerai Hidup",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
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
                      pengantar.wni == "WNI"
                          ? pw.Row(children: [
                              pw.Text(" : ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("WNI", style: pw.TextStyle(fontSize: 10)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("WNA",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                            ])
                          : pengantar.wni == "WNA"
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
                      pengantar.pendidikan == "SD"
                          ? pw.Row(children: [
                              pw.Text(" : ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SD", style: pw.TextStyle(fontSize: 10)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SLTP",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SLTA",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SMK",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SI",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("SII",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                              pw.Text(" / ", style: pw.TextStyle(fontSize: 10)),
                              pw.Text("Sederajat",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      decoration:
                                          pw.TextDecoration.lineThrough)),
                            ])
                          : pengantar.pendidikan == "SLTP"
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
                              : pengantar.pendidikan == "SLTA"
                                  ? pw.Row(children: [
                                      pw.Text(" : ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SD",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SLTP",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SLTA",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SMK",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SI",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SII",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Sederajat",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                    ])
                                  : pengantar.pendidikan == "SMK"
                                      ? pw.Row(children: [
                                          pw.Text(" : ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("SD",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("SLTP",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("SLTA",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
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
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("SII",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Sederajat",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                        ])
                                      : pengantar.pendidikan == "SI"
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
                                          : pengantar.pendidikan == "SII"
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
                                              : pengantar.pendidikan ==
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
                      pengantar.pekerjaan != null
                          ? pw.Text(
                              " : ${pengantar.pekerjaan}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : ........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.nik != null
                          ? pw.Text(
                              " : ${pengantar.nik}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : ........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.kk != null
                          ? pw.Text(
                              " : ${pengantar.kk}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : ........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.alamat != null
                          ? pw.Text(
                              " : ${pengantar.alamat}",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : ........................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 15),
                      pengantar.keperluan1 == null
                          ? pw.Text(
                              " : 1........................................",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              " : 1. ${pengantar.keperluan1}",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                      pw.SizedBox(height: 8),
                      pengantar.keperluan2 == null
                          ? pw.Text(
                              "   2. .......................................",
                              style: pw.TextStyle(fontSize: 10),
                            )
                          : pw.Text(
                              "   2. ${pengantar.keperluan2}",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "Demikian untuk menjadikan periksa dan dipergunakan sebagai mestinya",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Nomor      : ${pengantar.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
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
              pw.Row(children: [
                pw.SizedBox(width: 36),
                pw.Text(
                  "Mengetahui,",
                  style: pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ]),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 8),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "KETUA RW. IX",
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "KELURAHAN GADANG",
                            style: pw.TextStyle(
                              fontSize: 10,
                            ),
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
          ); // Center
        },
      ),
    );

    //save
    Uint8List bytes = await pdf.save();

    //file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Surat Pengantar.pdf');

    //timpa file kosong dengan pdf
    await file.writeAsBytes(bytes);

    //open file
    await OpenFile.open(file.path);
  }

  @override
  void onInit() {
    super.onInit();
    namaC = TextEditingController();
    tempatC = TextEditingController();
    pekerjaanC = TextEditingController();
    nikC = TextEditingController();
    kkC = TextEditingController();
    alamatC = TextEditingController();
    keperluanC = TextEditingController();
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
    pekerjaanC.clear();
    tempatC.clear();
    nikC.clear();
    kkC.clear();
    alamatC.clear();
    keperluanC.clear();
    selectedAgama = '';
    selectedKelamin = '';
    selectedPendidikan = '';
    selectedStatus = '';
    selectedWNI = '';
    emailC.clear();
    selectedTanggal = DateTime.now();
  }

  // RxInt currentStep = 0.obs;
  // void nextStep() {
  //   currentStep++;
  // }

  // void backStep() {
  //   currentStep = currentStep - 1;
  // }
}
