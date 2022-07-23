import 'dart:io';
import 'dart:typed_data';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/s_domisili.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class AdminSuratController2 extends GetxController {
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

  RxList<Domisili> rxDomisili = RxList<Domisili>();
  List<Domisili> get domisili => rxDomisili.value;
  set domisili(List<Domisili> value) => rxDomisili.value = value;

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

  modelcontroller(Domisili domisili) async {
    namaC.text = domisili.nama ?? '';
    alamatC.text = domisili.alamat ?? '';
    keperluan = domisili.keperluan!;
    emailC.text = domisili.email ?? '';
  }

  var keperluan = "Surat Keterangan Domisili";

  Future store(Domisili domisili) async {
    isSaving = true;
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

  void getPDF(Domisili domisili, bool show) async {
    //dokumen
    final pdf = pw.Document();

    //page
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(children: [
              pw.Container(height: 50),
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  "RUKUN TETANGGA (RT) II RUKUN WARGA (RW) IX",
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
              pw.Text(
                "Sekretariat : Jl. Satsui Tubun - (Perum Green Living Residence)",
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Divider(
                color: PdfColor.fromInt(0xFF000000),
                height: 1,
                thickness: 1,
              ),
              pw.SizedBox(height: 5),
              pw.SizedBox(
                height: 5,
              ),
              pw.Text(
                "SURAT PERNYATAAN",
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
              pw.SizedBox(height: 6),
              pw.Text(
                "Nomor : ${domisili.nomer} / II-IX / ${DateFormat("dd-M-y").format(DateTime.now())}",
                style: pw.TextStyle(
                  fontSize: 10,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Saya yang bertanda tangan dibawah ini, Ketua RT.02 RW.09 Perumahan Green Living Residence",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 1),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Kota Malang dengan ini menerangkan bahwa warga kami :",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
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
                              "Nama",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Jenis Kelamin",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Tempat, Tgl Lahir",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "No KTP",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Alamat",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.SizedBox(height: 10),
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
                          pw.Text(
                            " : ${domisili.nama}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            " : ${domisili.kelamin}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            " : ${domisili.tempatlahir}, ${DateFormat("dd MMMM y", 'id').format(domisili.tanggallahir!)}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 10),
                          domisili.nktp != null
                              ? pw.Text(
                                  " : ${domisili.nktp}",
                                  style: pw.TextStyle(fontSize: 10),
                                )
                              : pw.Text(" : .................."),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            " : ${domisili.alamat}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            " : ${domisili.keperluan}",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 10),
                        ]),
                  ]),

              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Keterangan ",
                  style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Adalah benar-benar berdomisili atau tinggal di lingkungan RT 02 RW 09 Perumahan Green Living",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 1),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Residence Kota Malang",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "Demikian surat keterangan perjalanan ini dibuat dengan sebenar-benarnya agar dapat dipergunakan",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 1),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(
                  "sebagaimana mestinya.",
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.SizedBox(height: 35),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "Mengetahui",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "Ketua RW 09",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                        pw.Container(height: 55),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "....................................",
                            style: pw.TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Malang, ${DateFormat("dd MMM y", 'id').format(DateTime.now())}",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "Ketua RT 02",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                          pw.Container(height: 55),
                          pw.Align(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              "....................................",
                              style: pw.TextStyle(fontSize: 10),
                            ),
                          ),
                        ]),
                  ])
            ]);
          }),
    );

    //save
    Uint8List bytes = await pdf.save();

    //file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/Surat Domisili.pdf');

    //timpa file kosong dengan pdf
    await file.writeAsBytes(bytes);

    //open file
    if (show == true) {
      await OpenFile.open(file.path);
    } else if (show == false) {
      final Email email = Email(
        body: 'Email body',
        subject: 'Email subject',
        recipients: [domisili.email!],
        attachmentPaths: [file.path],
        isHTML: false,
      );

      await FlutterEmailSender.send(email);
    } else {}
  }

  // Future storepengantar(Pengantar pengantar) async {
  //   isSaving = true;
  //   pengantar.nama = namaC.text;
  //   pengantar.alamat = alamatC.text;
  //   pengantar.keperluan1 = selectedKeperluan1;
  //   pengantar.keperluan2 = selectedKeperluan2;
  //   pengantar.pekerjaan = pekerjaanC.text;
  //   pengantar.agama = selectedAgama;
  //   pengantar.pendidikan = selectedPendidikan;
  //   pengantar.status = selectedStatus;
  //   pengantar.wni = selectedWNI;
  //   pengantar.nik = int.tryParse(nikC.text);
  //   pengantar.kk = int.tryParse(kkC.text);
  //   pengantar.kelamin = selectedKelamin;
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

  @override
  void onInit() {
    super.onInit();
    namaC = TextEditingController();
    tempatC = TextEditingController();
    nktpC = TextEditingController();
    alamatC = TextEditingController();
    emailC = TextEditingController();
    rxDomisili.bindStream(Domisili().listDomisili());
  }

  @override
  void onReady() {
    super.onReady();
  }
}
