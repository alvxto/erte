// import 'package:erte/app/data/models/absen.dart';
// import 'package:erte/app/data/models/s_pengantar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class AdminSuratController extends GetxController {
//   late TextEditingController namaC;
//   late TextEditingController emailC;
//   late TextEditingController alamatC;
//   late TextEditingController keperluanC;

//   RxList<Absen> rxAbsens = RxList<Absen>();
//   List<Absen> get absens => rxAbsens.value;
//   set absens(List<Absen> value) => rxAbsens.value = value;

//   List<String> listKeperluan1 = [
//     "Pengurusan Surat Pindah",
//     "Pengurusan Surat Datang",
//     "Surat Kontrak Rumah",
//     "Pengurusan Surat Kelahiran",
//     "Pengurusan Surat Kematian",
//     "Surat Keterangan Tidak Mampu",
//     "Surat Pernyataan Waris",
//     "Surat Ijin Keramaian",
//     "Pengurusan Surat Ijin Usaha",
//     "Pengantar Surat Nikah",
//     "Pengurusan Surat Pensiun",
//     "Surat Keterangan Penghasilan",
//     "Surat Keterangan Permohonan KPR",
//     "Surat Keterangan Bersih Diri",
//     "Surat Keterangan Catatan Kepolisian",
//     "Surat Tunjangan Keluarga",
//     "Surat Pengurusan Paspor",
//     "Surat Keterangan Domisili",
//     "Surat Boro Kerja",
//     "Pengurusan KTP Baru",
//     "Pengurusan KK Baru",
//     "Surat Ijin Mendirikan Bangunan"
//   ];
//   String? selectedKeperluan1;

//   List<String> listKeperluan2 = [
//     "Pengurusan Surat Pindah",
//     "Pengurusan Surat Datang",
//     "Surat Kontrak Rumah",
//     "Pengurusan Surat Kelahiran",
//     "Pengurusan Surat Kematian",
//     "Surat Keterangan Tidak Mampu",
//     "Surat Pernyataan Waris",
//     "Surat Ijin Keramaian",
//     "Pengurusan Surat Ijin Usaha",
//     "Pengantar Surat Nikah",
//     "Pengurusan Surat Pensiun",
//     "Surat Keterangan Penghasilan",
//     "Surat Keterangan Permohonan KPR",
//     "Surat Keterangan Bersih Diri",
//     "Surat Keterangan Catatan Kepolisian",
//     "Surat Tunjangan Keluarga",
//     "Surat Pengurusan Paspor",
//     "Surat Keterangan Domisili",
//     "Surat Boro Kerja",
//     "Pengurusan KTP Baru",
//     "Pengurusan KK Baru",
//     "Surat Ijin Mendirikan Bangunan"
//   ];
//   String? selectedKeperluan2;

//   modelToController(Absen absen) {
//     namaC.text = absen.nama ?? '';
//     emailC.text = absen.email ?? '';
//     alamatC.text = absen.alamat ?? '';
//     selectedKeperluan1 = absen.keperluan1;
//     selectedKeperluan2 = absen.keperluan2;
//   }

//   @override
//   void onInit() {
//     namaC = TextEditingController();
//     emailC = TextEditingController();
//     alamatC = TextEditingController();
//     selectedKeperluan1 = '';
//     selectedKeperluan2 = '';
//     keperluanC = TextEditingController();
//     rxAbsens.bindStream(Absen().streamList());
//     super.onInit();
//   }
// }

import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/user.dart';

class AdminSuratController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController alamatC;
  late TextEditingController emailC;

  RxList<Pengantar> rxUser = RxList<Pengantar>();
  List<Pengantar> get users => rxUser.value;
  set users(List<Pengantar> value) => rxUser.value = value;

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

  controllertomodel(Pengantar pengantar) {
    namaC.text = pengantar.nama ?? '';
    alamatC.text = pengantar.alamat ?? '';
    selectedKeperluan1 = pengantar.keperluan1;
    selectedKeperluan2 = pengantar.keperluan2;
    emailC.text = pengantar.email ?? '';
    if (pengantar.id == 'null') {
      pengantar.waktu = DateTime.now();
    }
  }

  void onInit() {
    namaC = TextEditingController();
    alamatC = TextEditingController();
    emailC = TextEditingController();
    selectedKeperluan1 = '';
    selectedKeperluan2 = '';
    rxUser.bindStream(Pengantar().stlist());
    super.onInit();
  }
}
