import 'dart:io';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_ktp.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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
import 'package:printing/printing.dart';

class AdminSuratController3 extends GetxController {
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

  RxList<KTP> rxKTP = RxList<KTP>();
  List<KTP> get ktp => rxKTP.value;
  set ktp(List<KTP> value) => rxKTP.value = value;

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

  modelcontroller(KTP ktp) async {
    namaC.text = ktp.nama ?? '';
    alamatC.text = ktp.alamat ?? '';
    keperluan = ktp.keperluan1 ?? '';
    emailC.text = ktp.email ?? '';
  }

  var keperluan = "Pengurusan KTP baru";

  void getPDF(KTP ktp, bool show) async {
    //dokumen
    final pdf = pw.Document();

    //store
    // ktp = await controllertomodelktp(ktp);
    // pengantar = await controllertomodel(pengantar);

    //image
    final image = await networkImage(ktp.image ?? '');

    //page
    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return [
              pw.Column(
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        pw.Column(
                          children: [
                            pw.Text("ARSIP KELURAHAN",
                                style: pw.TextStyle(fontSize: 10)),
                            pw.Container(
                                height: 80,
                                width: 150,
                                decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 1.0, color: PdfColors.black))),
                            pw.Text("Kode Grafer",
                                style: pw.TextStyle(fontSize: 10)),
                          ],
                        ),
                        pw.SizedBox(width: 10),
                        pw.Column(
                          children: [
                            pw.Text("", style: pw.TextStyle(fontSize: 10)),
                            pw.Container(
                              height: 80,
                              width: 165,
                              child: image == ''
                                  ? pw.Center(
                                      child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Text("Pas Foto",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Warna",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("4 x 6",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                        ],
                                      ),
                                      // child: pw.Image(pw.MemoryImage(myimage),
                                      //     fit: pw.BoxFit.cover)
                                    )
                                  : pw.Image(image, fit: pw.BoxFit.cover),
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 1.0, color: PdfColors.black),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(width: 10),
                        pw.Column(children: [
                          pw.Text("ARSIP KELURAHAN",
                              style: pw.TextStyle(fontSize: 10)),
                          pw.Container(
                              height: 80,
                              width: 195,
                              decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 1.0, color: PdfColors.black))),
                          pw.Text("Tanda Tangan / Bidik Jari Pemohon",
                              style: pw.TextStyle(fontSize: 10)),
                        ]),
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "PEMERINTAH KOTA MALANG",
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      children: [
                        ktp.kecamatan != null
                            ? pw.Text(
                                "Kecamatan : ${ktp.kecamatan}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                "Kecamatan : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                        ktp.kelurahan != null
                            ? pw.Text(
                                "Kelurahan : ${ktp.kelurahan}",
                                style: pw.TextStyle(fontSize: 10),
                              )
                            : pw.Text(
                                "Kelurahan : ........................................",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                      ]),
                  pw.Divider(
                    color: PdfColor.fromInt(0xFF000000),
                    height: 1,
                    thickness: 2,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    "Formulir Isian Data Kartu Tanda Penduduk ( KTP )",
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                      "(Harap ditulis LENGKAP dengan HURUF CETAK, beri tanda X pada isian yang dipilih)",
                      style: pw.TextStyle(fontSize: 10)),
                  pw.SizedBox(height: 20),
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
                              "1  NIK",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "2  Nama Lengkap",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "3  Jenis Kelamin",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "4  Tanggal Lahir",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "5  Tempat Lahir",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "6  Status Kawin",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "7  Agama",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "8  Pekerjaan",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "9  Alamat",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                        ],
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  ktp.nik != null
                                      ? pw.Text(
                                          " : ${ktp.nik}",
                                          style: pw.TextStyle(fontSize: 10),
                                        )
                                      : pw.Text(
                                          " : ........................................",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                                  pw.SizedBox(width: 30),
                                  ktp.wni == "WNI"
                                      ? pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Stack(children: [
                                            pw.Center(
                                                child: pw.Text(
                                              "1",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                            pw.Center(
                                                child: pw.Text(
                                              "X",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                          ]),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black)))
                                      : pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Center(
                                              child: pw.Text(
                                            "1",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black))),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    "WNI",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.SizedBox(width: 20),
                                  ktp.wni == "WNA"
                                      ? pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Stack(children: [
                                            pw.Center(
                                                child: pw.Text(
                                              "2",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                            pw.Center(
                                                child: pw.Text(
                                              "X",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                          ]),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black)))
                                      : pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Center(
                                              child: pw.Text(
                                            "2",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black))),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    "WNA",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                ]),
                            pw.SizedBox(height: 10),
                            ktp.nama != null
                                ? pw.Text(
                                    " : ${ktp.nama}",
                                    style: pw.TextStyle(fontSize: 10),
                                  )
                                : pw.Text(
                                    " : ........................................",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    " : ",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.SizedBox(width: 5),
                                  ktp.kelamin == "Laki-Laki"
                                      ? pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Stack(children: [
                                            pw.Center(
                                                child: pw.Text(
                                              "1",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                            pw.Center(
                                                child: pw.Text(
                                              "X",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                          ]),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black)))
                                      : pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Center(
                                              child: pw.Text(
                                            "1",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black))),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    "Laki-laki",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.SizedBox(width: 20),
                                  ktp.kelamin == "Perempuan"
                                      ? pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Stack(children: [
                                            pw.Center(
                                                child: pw.Text(
                                              "2",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                            pw.Center(
                                                child: pw.Text(
                                              "X",
                                              style: pw.TextStyle(fontSize: 10),
                                            )),
                                          ]),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black)))
                                      : pw.Container(
                                          height: 10,
                                          width: 10,
                                          child: pw.Center(
                                              child: pw.Text(
                                            "2",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                          decoration: pw.BoxDecoration(
                                              border: pw.Border.all(
                                                  width: 1,
                                                  color: PdfColors.black))),
                                  pw.SizedBox(width: 5),
                                  pw.Text(
                                    "Perempuan",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  pw.SizedBox(width: 60),
                                  pw.Text(
                                    "Golongan Darah",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  ktp.goldarah != null
                                      ? pw.Text(
                                          " : ${ktp.goldarah}",
                                          style: pw.TextStyle(fontSize: 10),
                                        )
                                      : pw.Text(
                                          " : ..............................",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                                ]),
                            pw.SizedBox(height: 10),
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                  " : ",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                pw.SizedBox(width: 30),
                                pw.Text(
                                  "Tgl.",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                ktp.tanggallahir != null
                                    ? pw.Text(
                                        " : ${DateFormat("dd").format(ktp.waktu!)}",
                                        style: pw.TextStyle(fontSize: 10),
                                      )
                                    : pw.Text(
                                        " : ...........",
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                pw.SizedBox(width: 40),
                                pw.Text(
                                  "Bln.",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                ktp.tanggallahir != null
                                    ? pw.Text(
                                        " : ${DateFormat("M").format(ktp.waktu!)}",
                                        style: pw.TextStyle(fontSize: 10),
                                      )
                                    : pw.Text(
                                        " : ...........",
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                pw.SizedBox(width: 40),
                                pw.Text(
                                  "Thn.",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                                ktp.tanggallahir != null
                                    ? pw.Text(
                                        " : ${DateFormat("y").format(ktp.waktu!)}",
                                        style: pw.TextStyle(fontSize: 10),
                                      )
                                    : pw.Text(
                                        " : ...........",
                                        style: pw.TextStyle(fontSize: 10),
                                      ),
                                pw.SizedBox(width: 40),
                              ],
                            ),
                            pw.SizedBox(height: 10),
                            ktp.tempatlahir != null
                                ? pw.Text(
                                    " : ${ktp.tempatlahir}",
                                    style: pw.TextStyle(fontSize: 10),
                                  )
                                : pw.Text(
                                    " : ..............................",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                            pw.SizedBox(height: 10),
                            pw.Row(children: [
                              pw.Text(
                                " : ",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 5),
                              ktp.status == "Belum Kawin"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "1",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "1",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Belum Kawin",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 20),
                              ktp.status == "Kawin"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "2",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "2",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Kawin",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 20),
                              ktp.status == "Cerai Hidup"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "3",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "3",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Cerai Hidup",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 20),
                              ktp.status == "Cerai Mati"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "4",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "4",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Cerai Mati",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                            ]),
                            pw.SizedBox(height: 10),
                            pw.Row(children: [
                              pw.Text(
                                " : ",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 5),
                              ktp.agama == "Islam"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "1",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "1",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Islam",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 15),
                              ktp.agama == "Kristen"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "2",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "2",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Kristen",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 15),
                              ktp.agama == "Katholik"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "3",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "3",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Katholik",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 15),
                              ktp.agama == "Hindu"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(
                                        children: [
                                          pw.Center(
                                              child: pw.Text(
                                            "4",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                          pw.Center(
                                              child: pw.Text(
                                            "X",
                                            style: pw.TextStyle(fontSize: 10),
                                          )),
                                        ],
                                      ),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "4",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Hindu",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 15),
                              ktp.agama == "Budha"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "5",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "5",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Budha",
                                style: pw.TextStyle(fontSize: 10),
                              ),
                              pw.SizedBox(width: 15),
                              ktp.agama == "Khonghucu"
                                  ? pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Stack(children: [
                                        pw.Center(
                                            child: pw.Text(
                                          "6",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                        pw.Center(
                                            child: pw.Text(
                                          "X",
                                          style: pw.TextStyle(fontSize: 10),
                                        )),
                                      ]),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black)))
                                  : pw.Container(
                                      height: 10,
                                      width: 10,
                                      child: pw.Center(
                                          child: pw.Text(
                                        "6",
                                        style: pw.TextStyle(fontSize: 10),
                                      )),
                                      decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 1,
                                              color: PdfColors.black))),
                              pw.SizedBox(width: 5),
                              pw.Text(
                                "Khonghucu",
                                style: pw.TextStyle(fontSize: 10),
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
                              //       "10",
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
                            pw.SizedBox(height: 10),
                            ktp.pekerjaan != null
                                ? pw.Text(
                                    " : ${ktp.pekerjaan}",
                                    style: pw.TextStyle(fontSize: 10),
                                  )
                                : pw.Text(
                                    " : ..............................",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                            pw.SizedBox(height: 10),
                            ktp.alamat != null
                                ? pw.Text(
                                    " : ${ktp.alamat}",
                                    style: pw.TextStyle(fontSize: 10),
                                  )
                                : pw.Text(
                                    " : ..............................",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                            pw.SizedBox(height: 10),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceEvenly,
                                children: [
                                  pw.SizedBox(width: 9),
                                  pw.Text(
                                    "RT",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  ktp.rt != null
                                      ? pw.Text(
                                          " : ${ktp.rt}",
                                          style: pw.TextStyle(fontSize: 10),
                                        )
                                      : pw.Text(
                                          " : ....................",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                                  pw.SizedBox(width: 30),
                                  pw.Text(
                                    "RW",
                                    style: pw.TextStyle(fontSize: 10),
                                  ),
                                  ktp.rw != null
                                      ? pw.Text(
                                          " : ${ktp.rw}",
                                          style: pw.TextStyle(fontSize: 10),
                                        )
                                      : pw.Text(
                                          " : ....................",
                                          style: pw.TextStyle(fontSize: 10),
                                        ),
                                ]),
                            pw.SizedBox(height: 15),
                          ]),
                    ],
                  ),
                  pw.SizedBox(height: 30),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                    children: [
                      pw.Column(children: [
                        pw.Text(
                          "Mengetahui Lurah",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 50),
                        pw.Text(
                          "(...................)",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text(
                          "RW",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 50),
                        pw.Text(
                          "(...................)",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ]),
                      pw.Column(children: [
                        pw.Text(
                          "RT",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                        pw.SizedBox(height: 50),
                        pw.Text(
                          "(...................)",
                          style: pw.TextStyle(fontSize: 10),
                        ),
                      ]),
                      pw.Column(
                        children: [
                          pw.Text(
                            "Pemohon",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 50),
                          pw.Text(
                            "(...................)",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 200),
              pw.Column(
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
                    "Nomor : ${ktp.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
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
                          ktp.nama != null
                              ? pw.Text(
                                  " : ${ktp.nama}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  " : ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 8),
                          ktp.kelamin == "Laki-Laki"
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
                              : ktp.kelamin == "Perempuan"
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
                          ktp.tempatlahir != null && ktp.tanggallahir != null
                              ? pw.Text(
                                  " : ${ktp.tempatlahir} / ${DateFormat("dd MMMM y", 'id').format(ktp.tanggallahir!)}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  ":........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 8),
                          ktp.agama == "Islam"
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
                              : ktp.agama == "Katholik"
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
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Kristen",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
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
                                  : ktp.agama == "Kristen"
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
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Hindu",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
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
                                      : ktp.agama == "Hindu"
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
                                                      fontSize: 10)),
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
                                                      fontSize: 10,
                                                      decoration: pw
                                                          .TextDecoration
                                                          .lineThrough)),
                                            ])
                                          : ktp.agama == "Budha"
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
                                              : ktp.agama == "Khonghucu"
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
                          ktp.status == "Belum Kawin"
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
                              : ktp.status == "Kawin"
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
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Cerai Hidup",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("Cerai Mati",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
                                    ])
                                  : ktp.status == "Cerai Hidup"
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
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("Cerai Mati",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
                                        ])
                                      : ktp.status == "Cerai Mati"
                                          ? pw.Row(children: [
                                              pw.Text(" : ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Belum Kawin",
                                                  style: pw.TextStyle(
                                                      fontSize: 10,
                                                      decoration: pw
                                                          .TextDecoration
                                                          .lineThrough)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Kawin",
                                                  style: pw.TextStyle(
                                                      fontSize: 10,
                                                      decoration: pw
                                                          .TextDecoration
                                                          .lineThrough)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Cerai Hidup",
                                                  style: pw.TextStyle(
                                                      fontSize: 10,
                                                      decoration: pw
                                                          .TextDecoration
                                                          .lineThrough)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Cerai Mati",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                            ])
                                          : pw.Row(children: [
                                              pw.Text(" : ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Belum Kawin",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Kawin",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Cerai Hidup",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text(" / ",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                              pw.Text("Cerai Mati",
                                                  style: pw.TextStyle(
                                                      fontSize: 10)),
                                            ]),
                          pw.SizedBox(height: 8),
                          ktp.wni == "WNI"
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
                              : ktp.wni == "WNA"
                                  ? pw.Row(children: [
                                      pw.Text(" : ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("WNI",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
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
                          ktp.pendidikan == "SD"
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
                              : ktp.pendidikan == "SLTP"
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
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text(" / ",
                                          style: pw.TextStyle(fontSize: 10)),
                                      pw.Text("SLTA",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              decoration: pw
                                                  .TextDecoration.lineThrough)),
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
                                  : ktp.pendidikan == "SLTA"
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
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text(" / ",
                                              style:
                                                  pw.TextStyle(fontSize: 10)),
                                          pw.Text("SMK",
                                              style: pw.TextStyle(
                                                  fontSize: 10,
                                                  decoration: pw.TextDecoration
                                                      .lineThrough)),
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
                                      : ktp.pendidikan == "SMK"
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
                                                      fontSize: 10)),
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
                                                      fontSize: 10,
                                                      decoration: pw
                                                          .TextDecoration
                                                          .lineThrough)),
                                            ])
                                          : ktp.pendidikan == "SI"
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
                                              : ktp.pendidikan == "SII"
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
                                                  : ktp.pendidikan ==
                                                          "Sederajat"
                                                      ? pw.Row(children: [
                                                          pw.Text(" : ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SD",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SLTP",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SLTA",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SMK",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SI",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SII",
                                                              style: pw.TextStyle(
                                                                  fontSize: 10,
                                                                  decoration: pw
                                                                      .TextDecoration
                                                                      .lineThrough)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("Sederajat",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                        ])
                                                      : pw.Row(children: [
                                                          pw.Text(" : ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SD",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SLTP",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SLTA",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SMK",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SI",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("SII",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text(" / ",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                          pw.Text("Sederajat",
                                                              style:
                                                                  pw.TextStyle(
                                                                      fontSize:
                                                                          10)),
                                                        ]),
                          pw.SizedBox(height: 8),
                          ktp.pekerjaan != null
                              ? pw.Text(
                                  " : ${ktp.pekerjaan}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  " : ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 8),
                          ktp.nik != null
                              ? pw.Text(
                                  " : ${ktp.nik}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  " : ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 8),
                          ktp.kk != null
                              ? pw.Text(
                                  " : ${ktp.kk}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  " : ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 8),
                          ktp.alamat != null
                              ? pw.Text(
                                  " : ${ktp.alamat}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  " : ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                          pw.SizedBox(height: 15),
                          ktp.keperluan1 == null
                              ? pw.Text(
                                  "  1. ........................................",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(
                                  "  1. ${ktp.keperluan1}",
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
                      "Nomor      : ${ktp.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
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
              ),
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
    if (show == true) {
      await OpenFile.open(file.path);
    } else if (show == false) {
      final Email email = Email(
        body: 'Email body',
        subject: 'Email subject',
        recipients: [ktp.email!],
        attachmentPaths: [file.path],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);

      // try {

      // } catch (e) {
      //   Get.defaultDialog(
      //       title: "Error",
      //       middleText: "email invalid",
      //       textConfirm: "Oke",
      //       buttonColor: primary,
      //       onConfirm: () => Get.back(),
      //       titleStyle: TextStyle(color: primary),
      //       middleTextStyle: TextStyle(color: primary));
      // }
    } else {}
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
    rxKTP.bindStream(KTP().listKTP());
  }

  @override
  void onReady() {
    super.onReady();
  }
}
