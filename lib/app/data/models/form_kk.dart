import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String sid = "id";
const String sdatakeluarga = "datakeluarga";
const String snamakepala = "namakepala";
const String snamalengkap = "namalengkap";
const String snamalengkap2 = "namalengkap2";
const String snamalengkap3 = "namalengkap3";
const String snamalengkap4 = "namalengkap4";
const String snamalengkap5 = "namalengkap5";
const String snamalengkap6 = "namalengkap6";
const String snamalengkap7 = "namalengkap7";
const String salamat = "alamat";
const String skodeppos = "kodepos";
const String stelepon = "telepon";
const String sjumkeluarga = "jumkeluarga";
const String snamasponsor = "namasponsor";
const String snamasponsor2 = "namasponsor2";
const String snamasponsor3 = "namasponsor3";
const String snamasponsor4 = "namasponsor4";
const String snamasponsor5 = "namasponsor5";
const String snamasponsor6 = "namasponsor6";
const String snamasponsor7 = "namasponsor7";
const String stipesponsor = "tipesponsor";
const String stipesponsor2 = "tipesponsor2";
const String stipesponsor3 = "tipesponsor3";
const String stipesponsor4 = "tipesponsor4";
const String stipesponsor5 = "tipesponsor5";
const String stipesponsor6 = "tipesponsor6";
const String stipesponsor7 = "tipesponsor7";
const String salamatsponsor = "alamatsponsor";
const String salamatsponsor2 = "alamatsponsor2";
const String salamatsponsor3 = "alamatsponsor3";
const String salamatsponsor4 = "alamatsponsor4";
const String salamatsponsor5 = "alamatsponsor5";
const String salamatsponsor6 = "alamatsponsor6";
const String salamatsponsor7 = "alamatsponsor7";
const String sgelardepan = "gelardepan";
const String sgelardepan2 = "gelardepan2";
const String sgelardepan3 = "gelardepan3";
const String sgelardepan4 = "gelardepan4";
const String sgelardepan5 = "gelardepan5";
const String sgelardepan6 = "gelardepan6";
const String sgelardepan7 = "gelardepan7";
const String sgelarbelakang = "gelarbelakang";
const String sgelarbelakang2 = "gelarbelakang2";
const String sgelarbelakang3 = "gelarbelakang3";
const String sgelarbelakang4 = "gelarbelakang4";
const String sgelarbelakang5 = "gelarbelakang5";
const String sgelarbelakang6 = "gelarbelakang6";
const String sgelarbelakang7 = "gelarbelakang7";
const String snopaspor = "nopaspor";
const String snopaspor2 = "nopaspor2";
const String snopaspor3 = "nopaspor3";
const String snopaspor4 = "nopaspor4";
const String snopaspor5 = "nopaspor5";
const String snopaspor6 = "nopaspor6";
const String snopaspor7 = "nopaspor7";
const String stanggalpaspor = "tanggalpaspor";
const String stanggalpaspor2 = "tanggalpaspor2";
const String stanggalpaspor3 = "tanggalpaspor3";
const String stanggalpaspor4 = "tanggalpaspor4";
const String stanggalpaspor5 = "tanggalpaspor5";
const String stanggalpaspor6 = "tanggalpaspor6";
const String stanggalpaspor7 = "tanggalpaspor7";
const String snowali = "nowali";
const String snowali2 = "nowali2";
const String snowali3 = "nowali3";
const String snowali4 = "nowali4";
const String snowali5 = "nowali5";
const String snowali6 = "nowali6";
const String snowali7 = "nowali7";
const String saktalahir = "aktalahir";
const String saktalahir2 = "aktalahir2";
const String saktalahir3 = "aktalahir3";
const String saktalahir4 = "aktalahir4";
const String saktalahir5 = "aktalahir5";
const String saktalahir6 = "aktalahir6";
const String saktalahir7 = "aktalahir7";
const String snoakta = "noaktalahir";
const String snoakta2 = "noaktalahir2";
const String snoakta3 = "noaktalahir3";
const String snoakta4 = "noaktalahir4";
const String snoakta5 = "noaktalahir5";
const String snoakta6 = "noaktalahir6";
const String snoakta7 = "noaktalahir7";
const String sorgagama = "orgagama";
const String sorgagama2 = "orgagama2";
const String sorgagama3 = "orgagama3";
const String sorgagama4 = "orgagama4";
const String sorgagama5 = "orgagama5";
const String sorgagama6 = "orgagama6";
const String sorgagama7 = "orgagama7";
const String saktakawin = "aktakawin";
const String saktakawin2 = "aktakawin2";
const String saktakawin3 = "aktakawin3";
const String saktakawin4 = "aktakawin4";
const String saktakawin5 = "aktakawin5";
const String saktakawin6 = "aktakawin6";
const String saktakawin7 = "aktakawin7";
const String stanggalkawin = "tanggalkawin";
const String stanggalkawin2 = "tanggalkawin2";
const String stanggalkawin3 = "tanggalkawin3";
const String stanggalkawin4 = "tanggalkawin4";
const String stanggalkawin5 = "tanggalkawin5";
const String stanggalkawin6 = "tanggalkawin6";
const String stanggalkawin7 = "tanggalkawin7";
const String snoaktakawin = "noaktakawin";
const String snoaktakawin2 = "noaktakawin2";
const String snoaktakawin3 = "noaktakawin3";
const String snoaktakawin4 = "noaktakawin4";
const String snoaktakawin5 = "noaktakawin5";
const String snoaktakawin6 = "noaktakawin6";
const String snoaktakawin7 = "noaktakawin7";
const String saktacerai = "aktacerai";
const String saktacerai2 = "aktacerai2";
const String saktacerai3 = "aktacerai3";
const String saktacerai4 = "aktacerai4";
const String saktacerai5 = "aktacerai5";
const String saktacerai6 = "aktacerai6";
const String saktacerai7 = "aktacerai7";
const String stanggalcerai = "tanggalcerai";
const String stanggalcerai2 = "tanggalcerai2";
const String stanggalcerai3 = "tanggalcerai3";
const String stanggalcerai4 = "tanggalcerai4";
const String stanggalcerai5 = "tanggalcerai5";
const String stanggalcerai6 = "tanggalcerai6";
const String stanggalcerai7 = "tanggalcerai7";
const String snoaktacerai = "noaktacerai";
const String snoaktacerai2 = "noaktacerai2";
const String snoaktacerai3 = "noaktacerai3";
const String snoaktacerai4 = "noaktacerai4";
const String snoaktacerai5 = "noaktacerai5";
const String snoaktacerai6 = "noaktacerai6";
const String snoaktacerai7 = "noaktacerai7";
const String sstatuskeluarga = "statuskeluarga";
const String sstatuskeluarga2 = "statuskeluarga2";
const String sstatuskeluarga3 = "statuskeluarga3";
const String sstatuskeluarga4 = "statuskeluarga4";
const String sstatuskeluarga5 = "statuskeluarga5";
const String sstatuskeluarga6 = "statuskeluarga6";
const String sstatuskeluarga7 = "statuskeluarga7";
const String scacat = "cacat";
const String scacat2 = "cacat2";
const String scacat3 = "cacat3";
const String scacat4 = "cacat4";
const String scacat5 = "cacat5";
const String scacat6 = "cacat6";
const String scacat7 = "cacat7";
const String sjeniscacat = "jeniscacat";
const String sjeniscacat2 = "jeniscacat2";
const String sjeniscacat3 = "jeniscacat3";
const String sjeniscacat4 = "jeniscacat4";
const String sjeniscacat5 = "jeniscacat5";
const String sjeniscacat6 = "jeniscacat6";
const String sjeniscacat7 = "jeniscacat7";
const String spendidikan = "pendidikan";
const String spendidikan2 = "pendidikan2";
const String spendidikan3 = "pendidikan3";
const String spendidikan4 = "pendidikan4";
const String spendidikan5 = "pendidikan5";
const String spendidikan6 = "pendidikan6";
const String spendidikan7 = "pendidikan7";
const String stempatlahir = "tempatlahir";
const String stempatlahir2 = "tempatlahir2";
const String stempatlahir3 = "tempatlahir3";
const String stempatlahir4 = "tempatlahir4";
const String stempatlahir5 = "tempatlahir5";
const String stempatlahir6 = "tempatlahir6";
const String stempatlahir7 = "tempatlahir7";
const String stanggallahir = "tanggallahir";
const String stanggallahir2 = "tanggallahir2";
const String stanggallahir3 = "tanggallahir3";
const String stanggallahir4 = "tanggallahir4";
const String stanggallahir5 = "tanggallahir5";
const String stanggallahir6 = "tanggallahir6";
const String stanggallahir7 = "tanggallahir7";
const String sagama = "agama";
const String sagama2 = "agama2";
const String sagama3 = "agama3";
const String sagama4 = "agama4";
const String sagama5 = "agama5";
const String sagama6 = "agama6";
const String sagama7 = "agama7";
const String sstatuskawin = "statuskawin";
const String sstatuskawin2 = "statuskawin2";
const String sstatuskawin3 = "statuskawin3";
const String sstatuskawin4 = "statuskawin4";
const String sstatuskawin5 = "statuskawin5";
const String sstatuskawin6 = "statuskawin6";
const String sstatuskawin7 = "statuskawin7";
// const String swni = "wni";
const String spekerjaan = "pekerjaan";
const String spekerjaan2 = "pekerjaan2";
const String spekerjaan3 = "pekerjaan3";
const String spekerjaan4 = "pekerjaan4";
const String spekerjaan5 = "pekerjaan5";
const String spekerjaan6 = "pekerjaan6";
const String spekerjaan7 = "pekerjaan7";
const String snikibu = "nikibu";
const String snikibu2 = "nikibu2";
const String snikibu3 = "nikibu3";
const String snikibu4 = "nikibu4";
const String snikibu5 = "nikibu5";
const String snikibu6 = "nikibu6";
const String snikibu7 = "nikibu7";
const String snamaibu = "namaibu";
const String snamaibu2 = "namaibu2";
const String snamaibu3 = "namaibu3";
const String snamaibu4 = "namaibu4";
const String snamaibu5 = "namaibu5";
const String snamaibu6 = "namaibu6";
const String snamaibu7 = "namaibu7";
const String snikayah = "nikayah";
const String snikayah2 = "nikayah2";
const String snikayah3 = "nikayah3";
const String snikayah4 = "nikayah4";
const String snikayah5 = "nikayah5";
const String snikayah6 = "nikayah6";
const String snikayah7 = "nikayah7";
const String snamaayah = "namaayah";
const String snamaayah2 = "namaayah2";
const String snamaayah3 = "namaayah3";
const String snamaayah4 = "namaayah4";
const String snamaayah5 = "namaayah5";
const String snamaayah6 = "namaayah6";
const String snamaayah7 = "namaayah7";
const String sgoldarah = "goldarah";
const String sgoldarah2 = "goldarah2";
const String sgoldarah3 = "goldarah3";
const String sgoldarah4 = "goldarah4";
const String sgoldarah5 = "goldarah5";
const String sgoldarah6 = "goldarah6";
const String sgoldarah7 = "goldarah7";
const String snoitas = "noitas";
const String snoitas2 = "noitas2";
const String snoitas3 = "noitas3";
const String snoitas4 = "noitas4";
const String snoitas5 = "noitas5";
const String snoitas6 = "noitas6";
const String snoitas7 = "noitas7";
const String stempatitas = "tempatitas";
const String stempatitas2 = "tempatitas2";
const String stempatitas3 = "tempatitas3";
const String stempatitas4 = "tempatitas4";
const String stempatitas5 = "tempatitas5";
const String stempatitas6 = "tempatitas6";
const String stempatitas7 = "tempatitas7";
const String stanggalterbititas = "tanggalterbititas";
const String stanggalterbititas2 = "tanggalterbititas2";
const String stanggalterbititas3 = "tanggalterbititas3";
const String stanggalterbititas4 = "tanggalterbititas4";
const String stanggalterbititas5 = "tanggalterbititas5";
const String stanggalterbititas6 = "tanggalterbititas6";
const String stanggalterbititas7 = "tanggalterbititas7";
const String stanggalitas = "tanggalitas";
const String stanggalitas2 = "tanggalitas2";
const String stanggalitas3 = "tanggalitas3";
const String stanggalitas4 = "tanggalitas4";
const String stanggalitas5 = "tanggalitas5";
const String stanggalitas6 = "tanggalitas6";
const String stanggalitas7 = "tanggalitas7";
const String stempatpertama = "tempatpertama";
const String stempatpertama2 = "tempatpertama2";
const String stempatpertama3 = "tempatpertama3";
const String stempatpertama4 = "tempatpertama4";
const String stempatpertama5 = "tempatpertama5";
const String stempatpertama6 = "tempatpertama6";
const String stempatpertama7 = "tempatpertama7";
const String stanggalpertama = "tanggalpertama";
const String stanggalpertama2 = "tanggalpertama2";
const String stanggalpertama3 = "tanggalpertama3";
const String stanggalpertama4 = "tanggalpertama4";
const String stanggalpertama5 = "tanggalpertama5";
const String stanggalpertama6 = "tanggalpertama6";
const String stanggalpertama7 = "tanggalpertama7";
const String srt = "rt";
const String srw = "rw";
const String skelamin = "kelamin";
const String skelamin2 = "kelamin2";
const String skelamin3 = "kelamin3";
const String skelamin4 = "kelamin4";
const String skelamin5 = "kelamin5";
const String skelamin6 = "kelamin6";
const String skelamin7 = "kelamin7";
const String skewarganegaraan = "kewarganegaraan";
const String skewarganegaraan2 = "kewarganegaraan2";
const String skewarganegaraan3 = "kewarganegaraan3";
const String skewarganegaraan4 = "kewarganegaraan4";
const String skewarganegaraan5 = "kewarganegaraan5";
const String skewarganegaraan6 = "kewarganegaraan6";
const String skewarganegaraan7 = "kewarganegaraan7";
const String swaktu = "waktu";
const String semail = "email";
const String snomer = "nomer";
const String skeperluan1 = "keperluan1";
const String skk = "kk";
const String snik = "nik";
const String swni = "wni";
const String spendidikan_pngntr = "pendidikan_pngntr";

class KK {
  String? id;
  String? datakeluarga;
  String? namakepala;
  String? namalengkap;
  String? namalengkap2;
  String? namalengkap3;
  String? namalengkap4;
  String? namalengkap5;
  String? namalengkap6;
  String? namalengkap7;
  String? alamat;
  int? kodeppos;
  int? telepon;
  int? jumkeluarga;
  String? kewarganegaraan;
  String? kewarganegaraan2;
  String? kewarganegaraan3;
  String? kewarganegaraan4;
  String? kewarganegaraan5;
  String? kewarganegaraan6;
  String? kewarganegaraan7;
  String? namasponsor;
  String? namasponsor2;
  String? namasponsor3;
  String? namasponsor4;
  String? namasponsor5;
  String? namasponsor6;
  String? namasponsor7;
  String? tipesponsor;
  String? tipesponsor2;
  String? tipesponsor3;
  String? tipesponsor4;
  String? tipesponsor5;
  String? tipesponsor6;
  String? tipesponsor7;
  String? alamatsponsor;
  String? alamatsponsor2;
  String? alamatsponsor3;
  String? alamatsponsor4;
  String? alamatsponsor5;
  String? alamatsponsor6;
  String? alamatsponsor7;
  String? gelardepan;
  String? gelardepan2;
  String? gelardepan3;
  String? gelardepan4;
  String? gelardepan5;
  String? gelardepan6;
  String? gelardepan7;
  String? gelarbelakang;
  String? gelarbelakang2;
  String? gelarbelakang3;
  String? gelarbelakang4;
  String? gelarbelakang5;
  String? gelarbelakang6;
  String? gelarbelakang7;
  String? nopaspor;
  String? nopaspor2;
  String? nopaspor3;
  String? nopaspor4;
  String? nopaspor5;
  String? nopaspor6;
  String? nopaspor7;
  DateTime? tanggalpaspor;
  DateTime? tanggalpaspor2;
  DateTime? tanggalpaspor3;
  DateTime? tanggalpaspor4;
  DateTime? tanggalpaspor5;
  DateTime? tanggalpaspor6;
  DateTime? tanggalpaspor7;
  int? nowali;
  int? nowali2;
  int? nowali3;
  int? nowali4;
  int? nowali5;
  int? nowali6;
  int? nowali7;
  String? aktalahir;
  String? aktalahir2;
  String? aktalahir3;
  String? aktalahir4;
  String? aktalahir5;
  String? aktalahir6;
  String? aktalahir7;
  String? noakta;
  String? noakta2;
  String? noakta3;
  String? noakta4;
  String? noakta5;
  String? noakta6;
  String? noakta7;
  String? orgagama;
  String? orgagama2;
  String? orgagama3;
  String? orgagama4;
  String? orgagama5;
  String? orgagama6;
  String? orgagama7;
  String? aktakawin;
  String? aktakawin2;
  String? aktakawin3;
  String? aktakawin4;
  String? aktakawin5;
  String? aktakawin6;
  String? aktakawin7;
  DateTime? tanggalkawin;
  DateTime? tanggalkawin2;
  DateTime? tanggalkawin3;
  DateTime? tanggalkawin4;
  DateTime? tanggalkawin5;
  DateTime? tanggalkawin6;
  DateTime? tanggalkawin7;
  String? noaktakawin;
  String? noaktakawin2;
  String? noaktakawin3;
  String? noaktakawin4;
  String? noaktakawin5;
  String? noaktakawin6;
  String? noaktakawin7;
  String? aktacerai;
  String? aktacerai2;
  String? aktacerai3;
  String? aktacerai4;
  String? aktacerai5;
  String? aktacerai6;
  String? aktacerai7;
  DateTime? tanggalcerai;
  DateTime? tanggalcerai2;
  DateTime? tanggalcerai3;
  DateTime? tanggalcerai4;
  DateTime? tanggalcerai5;
  DateTime? tanggalcerai6;
  DateTime? tanggalcerai7;
  String? noaktacerai;
  String? noaktacerai2;
  String? noaktacerai3;
  String? noaktacerai4;
  String? noaktacerai5;
  String? noaktacerai6;
  String? noaktacerai7;
  String? statuskeluarga;
  String? statuskeluarga2;
  String? statuskeluarga3;
  String? statuskeluarga4;
  String? statuskeluarga5;
  String? statuskeluarga6;
  String? statuskeluarga7;
  String? cacat;
  String? cacat2;
  String? cacat3;
  String? cacat4;
  String? cacat5;
  String? cacat6;
  String? cacat7;
  String? jeniscacat;
  String? jeniscacat2;
  String? jeniscacat3;
  String? jeniscacat4;
  String? jeniscacat5;
  String? jeniscacat6;
  String? jeniscacat7;
  String? pendidikan;
  String? pendidikan2;
  String? pendidikan3;
  String? pendidikan4;
  String? pendidikan5;
  String? pendidikan6;
  String? pendidikan7;
  String? tempatlahir;
  String? tempatlahir2;
  String? tempatlahir3;
  String? tempatlahir4;
  String? tempatlahir5;
  String? tempatlahir6;
  String? tempatlahir7;
  DateTime? tanggallahir;
  DateTime? tanggallahir2;
  DateTime? tanggallahir3;
  DateTime? tanggallahir4;
  DateTime? tanggallahir5;
  DateTime? tanggallahir6;
  DateTime? tanggallahir7;
  String? agama;
  String? agama2;
  String? agama3;
  String? agama4;
  String? agama5;
  String? agama6;
  String? agama7;
  String? statuskawin;
  String? statuskawin2;
  String? statuskawin3;
  String? statuskawin4;
  String? statuskawin5;
  String? statuskawin6;
  String? statuskawin7;
  // String? wni;
  String? pekerjaan;
  String? pekerjaan2;
  String? pekerjaan3;
  String? pekerjaan4;
  String? pekerjaan5;
  String? pekerjaan6;
  String? pekerjaan7;
  int? nikibu;
  int? nikibu2;
  int? nikibu3;
  int? nikibu4;
  int? nikibu5;
  int? nikibu6;
  int? nikibu7;
  String? namaibu;
  String? namaibu2;
  String? namaibu3;
  String? namaibu4;
  String? namaibu5;
  String? namaibu6;
  String? namaibu7;
  int? nikayah;
  int? nikayah2;
  int? nikayah3;
  int? nikayah4;
  int? nikayah5;
  int? nikayah6;
  int? nikayah7;
  String? namaayah;
  String? namaayah2;
  String? namaayah3;
  String? namaayah4;
  String? namaayah5;
  String? namaayah6;
  String? namaayah7;
  String? goldarah;
  String? goldarah2;
  String? goldarah3;
  String? goldarah4;
  String? goldarah5;
  String? goldarah6;
  String? goldarah7;
  String? noitas;
  String? noitas2;
  String? noitas3;
  String? noitas4;
  String? noitas5;
  String? noitas6;
  String? noitas7;
  String? tempatitas;
  String? tempatitas2;
  String? tempatitas3;
  String? tempatitas4;
  String? tempatitas5;
  String? tempatitas6;
  String? tempatitas7;
  DateTime? tanggalterbititas;
  DateTime? tanggalterbititas2;
  DateTime? tanggalterbititas3;
  DateTime? tanggalterbititas4;
  DateTime? tanggalterbititas5;
  DateTime? tanggalterbititas6;
  DateTime? tanggalterbititas7;
  DateTime? tanggalitas;
  DateTime? tanggalitas2;
  DateTime? tanggalitas3;
  DateTime? tanggalitas4;
  DateTime? tanggalitas5;
  DateTime? tanggalitas6;
  DateTime? tanggalitas7;
  String? tempatpertama;
  String? tempatpertama2;
  String? tempatpertama3;
  String? tempatpertama4;
  String? tempatpertama5;
  String? tempatpertama6;
  String? tempatpertama7;
  DateTime? tanggalpertama;
  DateTime? tanggalpertama2;
  DateTime? tanggalpertama3;
  DateTime? tanggalpertama4;
  DateTime? tanggalpertama5;
  DateTime? tanggalpertama6;
  DateTime? tanggalpertama7;
  int? rt;
  int? rw;
  String? kelamin;
  String? kelamin2;
  String? kelamin3;
  String? kelamin4;
  String? kelamin5;
  String? kelamin6;
  String? kelamin7;
  DateTime? waktu;
  String? email;
  String? keperluan1;
  int? nomer;
  int? nik;
  int? kk;
  String? wni;
  String? pendidikan_pngntr;

  KK({
    this.agama,
    this.agama2,
    this.agama3,
    this.agama4,
    this.agama5,
    this.agama6,
    this.agama7,
    this.aktacerai,
    this.aktacerai2,
    this.aktacerai3,
    this.aktacerai4,
    this.aktacerai5,
    this.aktacerai6,
    this.aktacerai7,
    this.aktakawin,
    this.aktakawin2,
    this.aktakawin3,
    this.aktakawin4,
    this.aktakawin5,
    this.aktakawin6,
    this.aktakawin7,
    this.aktalahir,
    this.aktalahir2,
    this.aktalahir3,
    this.aktalahir4,
    this.aktalahir5,
    this.aktalahir6,
    this.aktalahir7,
    this.alamat,
    this.alamatsponsor,
    this.alamatsponsor2,
    this.alamatsponsor3,
    this.alamatsponsor4,
    this.alamatsponsor5,
    this.alamatsponsor6,
    this.alamatsponsor7,
    this.tipesponsor,
    this.tipesponsor2,
    this.tipesponsor3,
    this.tipesponsor4,
    this.tipesponsor5,
    this.tipesponsor6,
    this.tipesponsor7,
    this.cacat,
    this.cacat2,
    this.cacat3,
    this.cacat4,
    this.cacat5,
    this.cacat6,
    this.cacat7,
    this.datakeluarga,
    this.gelarbelakang,
    this.gelarbelakang2,
    this.gelarbelakang3,
    this.gelarbelakang4,
    this.gelarbelakang5,
    this.gelarbelakang6,
    this.gelarbelakang7,
    this.gelardepan,
    this.gelardepan2,
    this.gelardepan3,
    this.gelardepan4,
    this.gelardepan5,
    this.gelardepan6,
    this.gelardepan7,
    this.goldarah,
    this.goldarah2,
    this.goldarah3,
    this.goldarah4,
    this.goldarah5,
    this.goldarah6,
    this.goldarah7,
    this.id,
    this.jeniscacat,
    this.jeniscacat2,
    this.jeniscacat3,
    this.jeniscacat4,
    this.jeniscacat5,
    this.jeniscacat6,
    this.jeniscacat7,
    this.jumkeluarga,
    this.kelamin,
    this.kelamin2,
    this.kelamin3,
    this.kelamin4,
    this.kelamin5,
    this.kelamin6,
    this.kelamin7,
    this.kodeppos,
    this.namaayah,
    this.namaayah2,
    this.namaayah3,
    this.namaayah4,
    this.namaayah5,
    this.namaayah6,
    this.namaayah7,
    this.namaibu,
    this.namaibu2,
    this.namaibu3,
    this.namaibu4,
    this.namaibu5,
    this.namaibu6,
    this.namaibu7,
    this.namakepala,
    this.namalengkap,
    this.namalengkap2,
    this.namalengkap3,
    this.namalengkap4,
    this.namalengkap5,
    this.namalengkap6,
    this.namalengkap7,
    this.nikayah,
    this.nikayah2,
    this.nikayah3,
    this.nikayah4,
    this.nikayah5,
    this.nikayah6,
    this.nikayah7,
    this.namasponsor,
    this.namasponsor2,
    this.namasponsor3,
    this.namasponsor4,
    this.namasponsor5,
    this.namasponsor6,
    this.namasponsor7,
    this.nikibu,
    this.nikibu2,
    this.nikibu3,
    this.nikibu4,
    this.nikibu5,
    this.nikibu6,
    this.nikibu7,
    this.noakta,
    this.noakta2,
    this.noakta3,
    this.noakta4,
    this.noakta5,
    this.noakta6,
    this.noakta7,
    this.noaktacerai,
    this.noaktacerai2,
    this.noaktacerai3,
    this.noaktacerai4,
    this.noaktacerai5,
    this.noaktacerai6,
    this.noaktacerai7,
    this.noaktakawin,
    this.noaktakawin2,
    this.noaktakawin3,
    this.noaktakawin4,
    this.noaktakawin5,
    this.noaktakawin6,
    this.noaktakawin7,
    this.noitas,
    this.noitas2,
    this.noitas3,
    this.noitas4,
    this.noitas5,
    this.noitas6,
    this.noitas7,
    this.nopaspor,
    this.nopaspor2,
    this.nopaspor3,
    this.nopaspor4,
    this.nopaspor5,
    this.nopaspor6,
    this.nopaspor7,
    this.nowali,
    this.nowali2,
    this.nowali3,
    this.nowali4,
    this.nowali5,
    this.nowali6,
    this.nowali7,
    this.orgagama,
    this.orgagama2,
    this.orgagama3,
    this.orgagama4,
    this.orgagama5,
    this.orgagama6,
    this.orgagama7,
    this.pekerjaan,
    this.pekerjaan2,
    this.pekerjaan3,
    this.pekerjaan4,
    this.pekerjaan5,
    this.pekerjaan6,
    this.pekerjaan7,
    this.pendidikan,
    this.pendidikan2,
    this.pendidikan3,
    this.pendidikan4,
    this.pendidikan5,
    this.pendidikan6,
    this.pendidikan7,
    this.rt,
    this.rw,
    this.statuskawin,
    this.statuskawin2,
    this.statuskawin3,
    this.statuskawin4,
    this.statuskawin5,
    this.statuskawin6,
    this.statuskawin7,
    this.statuskeluarga,
    this.statuskeluarga2,
    this.statuskeluarga3,
    this.statuskeluarga4,
    this.statuskeluarga5,
    this.statuskeluarga6,
    this.statuskeluarga7,
    this.tanggalcerai,
    this.tanggalcerai2,
    this.tanggalcerai3,
    this.tanggalcerai4,
    this.tanggalcerai5,
    this.tanggalcerai6,
    this.tanggalcerai7,
    this.tanggalitas,
    this.tanggalitas2,
    this.tanggalitas3,
    this.tanggalitas4,
    this.tanggalitas5,
    this.tanggalitas6,
    this.tanggalitas7,
    this.tanggalkawin,
    this.tanggalkawin2,
    this.tanggalkawin3,
    this.tanggalkawin4,
    this.tanggalkawin5,
    this.tanggalkawin6,
    this.tanggalkawin7,
    this.tanggallahir,
    this.tanggallahir2,
    this.tanggallahir3,
    this.tanggallahir4,
    this.tanggallahir5,
    this.tanggallahir6,
    this.tanggallahir7,
    this.tanggalpaspor,
    this.tanggalpaspor2,
    this.tanggalpaspor3,
    this.tanggalpaspor4,
    this.tanggalpaspor5,
    this.tanggalpaspor6,
    this.tanggalpaspor7,
    this.tanggalpertama,
    this.tanggalpertama2,
    this.tanggalpertama3,
    this.tanggalpertama4,
    this.tanggalpertama5,
    this.tanggalpertama6,
    this.tanggalpertama7,
    this.tanggalterbititas,
    this.tanggalterbititas2,
    this.tanggalterbititas3,
    this.tanggalterbititas4,
    this.tanggalterbititas5,
    this.tanggalterbititas6,
    this.tanggalterbititas7,
    this.telepon,
    this.tempatitas,
    this.tempatitas2,
    this.tempatitas3,
    this.tempatitas4,
    this.tempatitas5,
    this.tempatitas6,
    this.tempatitas7,
    this.tempatlahir,
    this.tempatlahir2,
    this.tempatlahir3,
    this.tempatlahir4,
    this.tempatlahir5,
    this.tempatlahir6,
    this.tempatlahir7,
    this.tempatpertama,
    this.tempatpertama2,
    this.tempatpertama3,
    this.tempatpertama4,
    this.tempatpertama5,
    this.tempatpertama6,
    this.tempatpertama7,
    this.waktu,
    // this.wni,
    this.kewarganegaraan,
    this.kewarganegaraan2,
    this.kewarganegaraan3,
    this.kewarganegaraan4,
    this.kewarganegaraan5,
    this.kewarganegaraan6,
    this.kewarganegaraan7,
    this.email,
    this.keperluan1,
    this.kk,
    this.nik,
    this.nomer,
    this.wni,
    this.pendidikan_pngntr,
  });

  KK fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return KK(
      id: doc.id,
      namakepala: json[snamakepala],
      namalengkap: json[snamalengkap],
      namalengkap2: json[snamalengkap2],
      namalengkap3: json[snamalengkap3],
      namalengkap4: json[snamalengkap4],
      namalengkap5: json[snamalengkap5],
      namalengkap6: json[snamalengkap6],
      namalengkap7: json[snamalengkap7],
      namaayah: json[snamaayah],
      namaayah2: json[snamaayah2],
      namaayah3: json[snamaayah3],
      namaayah4: json[snamaayah4],
      namaayah5: json[snamaayah5],
      namaayah6: json[snamaayah6],
      namaayah7: json[snamaayah7],
      namaibu: json[snamaibu],
      namaibu2: json[snamaibu2],
      namaibu3: json[snamaibu3],
      namaibu4: json[snamaibu4],
      namaibu5: json[snamaibu5],
      namaibu6: json[snamaibu6],
      namaibu7: json[snamaibu7],
      namasponsor: json[snamasponsor],
      namasponsor2: json[snamasponsor2],
      namasponsor3: json[snamasponsor3],
      namasponsor4: json[snamasponsor4],
      namasponsor5: json[snamasponsor5],
      namasponsor6: json[snamasponsor6],
      namasponsor7: json[snamasponsor7],
      kelamin: json[skelamin],
      kelamin2: json[skelamin2],
      kelamin3: json[skelamin3],
      kelamin4: json[skelamin4],
      kelamin5: json[skelamin5],
      kelamin6: json[skelamin6],
      kelamin7: json[skelamin7],
      tempatlahir: json[stempatlahir],
      tempatlahir2: json[stempatlahir2],
      tempatlahir3: json[stempatlahir3],
      tempatlahir4: json[stempatlahir4],
      tempatlahir5: json[stempatlahir5],
      tempatlahir6: json[stempatlahir6],
      tempatlahir7: json[stempatlahir7],
      tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
      tanggallahir2: (json[stanggallahir2] as Timestamp?)?.toDate(),
      tanggallahir3: (json[stanggallahir3] as Timestamp?)?.toDate(),
      tanggallahir4: (json[stanggallahir4] as Timestamp?)?.toDate(),
      tanggallahir5: (json[stanggallahir5] as Timestamp?)?.toDate(),
      tanggallahir6: (json[stanggallahir6] as Timestamp?)?.toDate(),
      tanggallahir7: (json[stanggallahir7] as Timestamp?)?.toDate(),
      agama: json[sagama],
      agama2: json[sagama2],
      agama3: json[sagama3],
      agama4: json[sagama4],
      agama5: json[sagama5],
      agama6: json[sagama6],
      agama7: json[sagama7],
      statuskawin: json[sstatuskawin],
      statuskawin2: json[sstatuskawin2],
      statuskawin3: json[sstatuskawin3],
      statuskawin4: json[sstatuskawin4],
      statuskawin5: json[sstatuskawin5],
      statuskawin6: json[sstatuskawin6],
      statuskawin7: json[sstatuskawin7],
      statuskeluarga: json[sstatuskeluarga],
      statuskeluarga2: json[sstatuskeluarga2],
      statuskeluarga3: json[sstatuskeluarga3],
      statuskeluarga4: json[sstatuskeluarga4],
      statuskeluarga5: json[sstatuskeluarga5],
      statuskeluarga6: json[sstatuskeluarga6],
      statuskeluarga7: json[sstatuskeluarga7],
      // wni: json[swni],
      pekerjaan: json[spekerjaan],
      pekerjaan2: json[spekerjaan2],
      pekerjaan3: json[spekerjaan3],
      pekerjaan4: json[spekerjaan4],
      pekerjaan5: json[spekerjaan5],
      pekerjaan6: json[spekerjaan6],
      pekerjaan7: json[spekerjaan7],
      nikibu: json[snikibu],
      nikibu2: json[snikibu],
      nikibu3: json[snikibu],
      nikibu4: json[snikibu],
      nikibu5: json[snikibu],
      nikibu6: json[snikibu],
      nikibu7: json[snikibu],
      nikayah: json[nikayah],
      nikayah2: json[nikayah2],
      nikayah3: json[nikayah3],
      nikayah4: json[nikayah4],
      nikayah5: json[nikayah5],
      nikayah6: json[nikayah6],
      nikayah7: json[nikayah7],
      goldarah: json[sgoldarah],
      goldarah2: json[sgoldarah2],
      goldarah3: json[sgoldarah3],
      goldarah4: json[sgoldarah4],
      goldarah5: json[sgoldarah5],
      goldarah6: json[sgoldarah6],
      goldarah7: json[sgoldarah7],
      rt: json[srt],
      rw: json[srw],
      alamat: json[salamat],
      waktu: (json[swaktu] as Timestamp?)?.toDate(),
      aktacerai: json[saktacerai],
      aktacerai2: json[saktacerai2],
      aktacerai3: json[saktacerai3],
      aktacerai4: json[saktacerai4],
      aktacerai5: json[saktacerai5],
      aktacerai6: json[saktacerai6],
      aktacerai7: json[saktacerai7],
      aktakawin: json[saktakawin],
      aktakawin2: json[saktakawin2],
      aktakawin3: json[saktakawin3],
      aktakawin4: json[saktakawin4],
      aktakawin5: json[saktakawin5],
      aktakawin6: json[saktakawin6],
      aktakawin7: json[saktakawin7],
      aktalahir: json[saktalahir],
      aktalahir2: json[saktalahir2],
      aktalahir3: json[saktalahir3],
      aktalahir4: json[saktalahir4],
      aktalahir5: json[saktalahir5],
      aktalahir6: json[saktalahir6],
      aktalahir7: json[saktalahir7],
      alamatsponsor: json[salamatsponsor],
      alamatsponsor2: json[salamatsponsor2],
      alamatsponsor3: json[salamatsponsor3],
      alamatsponsor4: json[salamatsponsor4],
      alamatsponsor5: json[salamatsponsor5],
      alamatsponsor6: json[salamatsponsor6],
      alamatsponsor7: json[salamatsponsor7],
      cacat: json[scacat],
      cacat2: json[scacat2],
      cacat3: json[scacat3],
      cacat4: json[scacat4],
      cacat5: json[scacat5],
      cacat6: json[scacat6],
      cacat7: json[scacat7],
      datakeluarga: json[sdatakeluarga],
      gelarbelakang: json[sgelarbelakang],
      gelarbelakang2: json[sgelarbelakang2],
      gelarbelakang3: json[sgelarbelakang3],
      gelarbelakang4: json[sgelarbelakang4],
      gelarbelakang5: json[sgelarbelakang5],
      gelarbelakang6: json[sgelarbelakang6],
      gelarbelakang7: json[sgelarbelakang7],
      gelardepan: json[sgelardepan],
      gelardepan2: json[sgelardepan],
      gelardepan3: json[sgelardepan],
      gelardepan4: json[sgelardepan],
      gelardepan5: json[sgelardepan],
      gelardepan6: json[sgelardepan],
      gelardepan7: json[sgelardepan],
      jeniscacat: json[sjeniscacat],
      jeniscacat2: json[sjeniscacat2],
      jeniscacat3: json[sjeniscacat3],
      jeniscacat4: json[sjeniscacat4],
      jeniscacat5: json[sjeniscacat5],
      jeniscacat6: json[sjeniscacat6],
      jeniscacat7: json[sjeniscacat7],
      jumkeluarga: json[sjumkeluarga],
      kodeppos: json[skodeppos],
      noakta: json[snoakta],
      noakta2: json[snoakta2],
      noakta3: json[snoakta3],
      noakta4: json[snoakta4],
      noakta5: json[snoakta5],
      noakta6: json[snoakta6],
      noakta7: json[snoakta7],
      noaktacerai: json[saktacerai],
      noaktacerai2: json[saktacerai2],
      noaktacerai3: json[saktacerai3],
      noaktacerai4: json[saktacerai4],
      noaktacerai5: json[saktacerai5],
      noaktacerai6: json[saktacerai6],
      noaktacerai7: json[saktacerai7],
      noaktakawin: json[saktakawin],
      noaktakawin2: json[saktakawin2],
      noaktakawin3: json[saktakawin3],
      noaktakawin4: json[saktakawin4],
      noaktakawin5: json[saktakawin5],
      noaktakawin6: json[saktakawin6],
      noaktakawin7: json[saktakawin7],
      noitas: json[snoitas],
      noitas2: json[snoitas2],
      noitas3: json[snoitas3],
      noitas4: json[snoitas4],
      noitas5: json[snoitas5],
      noitas6: json[snoitas6],
      noitas7: json[snoitas7],
      nopaspor: json[snopaspor],
      nopaspor2: json[snopaspor2],
      nopaspor3: json[snopaspor3],
      nopaspor4: json[snopaspor4],
      nopaspor5: json[snopaspor5],
      nopaspor6: json[snopaspor6],
      nopaspor7: json[snopaspor7],
      nowali: json[snowali],
      nowali2: json[snowali2],
      nowali3: json[snowali3],
      nowali4: json[snowali4],
      nowali5: json[snowali5],
      nowali6: json[snowali6],
      nowali7: json[snowali7],
      orgagama: json[sorgagama],
      orgagama2: json[sorgagama2],
      orgagama3: json[sorgagama3],
      orgagama4: json[sorgagama4],
      orgagama5: json[sorgagama5],
      orgagama6: json[sorgagama6],
      orgagama7: json[sorgagama7],
      pendidikan: json[spendidikan],
      pendidikan2: json[spendidikan2],
      pendidikan3: json[spendidikan3],
      pendidikan4: json[spendidikan4],
      pendidikan5: json[spendidikan5],
      pendidikan6: json[spendidikan6],
      pendidikan7: json[spendidikan7],
      telepon: json[stelepon],
      tempatitas: json[stempatitas],
      tempatitas2: json[stempatitas2],
      tempatitas3: json[stempatitas3],
      tempatitas4: json[stempatitas4],
      tempatitas5: json[stempatitas5],
      tempatitas6: json[stempatitas6],
      tempatitas7: json[stempatitas7],
      tempatpertama: json[stempatpertama],
      tempatpertama2: json[stempatpertama2],
      tempatpertama3: json[stempatpertama3],
      tempatpertama4: json[stempatpertama4],
      tempatpertama5: json[stempatpertama5],
      tempatpertama6: json[stempatpertama6],
      tempatpertama7: json[stempatpertama7],
      tipesponsor: json[stipesponsor],
      tipesponsor2: json[stipesponsor2],
      tipesponsor3: json[stipesponsor3],
      tipesponsor4: json[stipesponsor4],
      tipesponsor5: json[stipesponsor5],
      tipesponsor6: json[stipesponsor6],
      tipesponsor7: json[stipesponsor7],
      kewarganegaraan: json[skewarganegaraan],
      kewarganegaraan2: json[skewarganegaraan2],
      kewarganegaraan3: json[skewarganegaraan3],
      kewarganegaraan4: json[skewarganegaraan4],
      kewarganegaraan5: json[skewarganegaraan5],
      kewarganegaraan6: json[skewarganegaraan6],
      kewarganegaraan7: json[skewarganegaraan7],
      tanggalcerai: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai2: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai3: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai4: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai5: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai6: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalcerai7: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalitas: (json[stanggalitas] as Timestamp?)?.toDate(),
      tanggalitas2: (json[stanggalitas2] as Timestamp?)?.toDate(),
      tanggalitas3: (json[stanggalitas3] as Timestamp?)?.toDate(),
      tanggalitas4: (json[stanggalitas4] as Timestamp?)?.toDate(),
      tanggalitas5: (json[stanggalitas5] as Timestamp?)?.toDate(),
      tanggalitas6: (json[stanggalitas6] as Timestamp?)?.toDate(),
      tanggalitas7: (json[stanggalitas7] as Timestamp?)?.toDate(),
      tanggalkawin: (json[stanggalkawin] as Timestamp?)?.toDate(),
      tanggalkawin2: (json[stanggalkawin2] as Timestamp?)?.toDate(),
      tanggalkawin3: (json[stanggalkawin3] as Timestamp?)?.toDate(),
      tanggalkawin4: (json[stanggalkawin4] as Timestamp?)?.toDate(),
      tanggalkawin5: (json[stanggalkawin5] as Timestamp?)?.toDate(),
      tanggalkawin6: (json[stanggalkawin6] as Timestamp?)?.toDate(),
      tanggalkawin7: (json[stanggalkawin7] as Timestamp?)?.toDate(),
      tanggalpaspor: (json[stanggalpaspor] as Timestamp?)?.toDate(),
      tanggalpaspor2: (json[stanggalpaspor2] as Timestamp?)?.toDate(),
      tanggalpaspor3: (json[stanggalpaspor3] as Timestamp?)?.toDate(),
      tanggalpaspor4: (json[stanggalpaspor4] as Timestamp?)?.toDate(),
      tanggalpaspor5: (json[stanggalpaspor5] as Timestamp?)?.toDate(),
      tanggalpaspor6: (json[stanggalpaspor6] as Timestamp?)?.toDate(),
      tanggalpaspor7: (json[stanggalpaspor7] as Timestamp?)?.toDate(),
      tanggalpertama: (json[stanggalpertama] as Timestamp?)?.toDate(),
      tanggalpertama2: (json[stanggalpertama2] as Timestamp?)?.toDate(),
      tanggalpertama3: (json[stanggalpertama3] as Timestamp?)?.toDate(),
      tanggalpertama4: (json[stanggalpertama4] as Timestamp?)?.toDate(),
      tanggalpertama5: (json[stanggalpertama5] as Timestamp?)?.toDate(),
      tanggalpertama6: (json[stanggalpertama6] as Timestamp?)?.toDate(),
      tanggalpertama7: (json[stanggalpertama7] as Timestamp?)?.toDate(),
      tanggalterbititas: (json[stanggalterbititas] as Timestamp?)?.toDate(),
      tanggalterbititas2: (json[stanggalterbititas2] as Timestamp?)?.toDate(),
      tanggalterbititas3: (json[stanggalterbititas3] as Timestamp?)?.toDate(),
      tanggalterbititas4: (json[stanggalterbititas4] as Timestamp?)?.toDate(),
      tanggalterbititas5: (json[stanggalterbititas5] as Timestamp?)?.toDate(),
      tanggalterbititas6: (json[stanggalterbititas6] as Timestamp?)?.toDate(),
      tanggalterbititas7: (json[stanggalterbititas7] as Timestamp?)?.toDate(),
      email: json[semail],
      nomer: json[snomer],
      keperluan1: json[skeperluan1],
      nik: json[snik],
      kk: json[skk],
      wni: json[swni],
      pendidikan_pngntr: json[spendidikan_pngntr],
    );
  }

  KK.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    id = doc.id;
    namakepala = json[snamakepala];
    namalengkap = json[snamalengkap];
    namalengkap2 = json[snamalengkap2];
    namalengkap3 = json[snamalengkap3];
    namalengkap4 = json[snamalengkap4];
    namalengkap5 = json[snamalengkap5];
    namalengkap6 = json[snamalengkap6];
    namalengkap7 = json[snamalengkap7];
    namaayah = json[snamaayah];
    namaayah2 = json[snamaayah2];
    namaayah3 = json[snamaayah3];
    namaayah4 = json[snamaayah4];
    namaayah5 = json[snamaayah5];
    namaayah6 = json[snamaayah6];
    namaayah7 = json[snamaayah7];
    namaibu = json[snamaibu];
    namaibu2 = json[snamaibu2];
    namaibu3 = json[snamaibu3];
    namaibu4 = json[snamaibu4];
    namaibu5 = json[snamaibu5];
    namaibu6 = json[snamaibu6];
    namaibu7 = json[snamaibu7];
    namasponsor = json[snamasponsor];
    namasponsor2 = json[snamasponsor2];
    namasponsor3 = json[snamasponsor3];
    namasponsor4 = json[snamasponsor4];
    namasponsor5 = json[snamasponsor5];
    namasponsor6 = json[snamasponsor6];
    namasponsor7 = json[snamasponsor7];
    kelamin = json[skelamin];
    kelamin2 = json[skelamin2];
    kelamin3 = json[skelamin3];
    kelamin4 = json[skelamin4];
    kelamin5 = json[skelamin5];
    kelamin6 = json[skelamin6];
    kelamin7 = json[skelamin7];
    tempatlahir = json[stempatlahir];
    tempatlahir2 = json[stempatlahir2];
    tempatlahir3 = json[stempatlahir3];
    tempatlahir4 = json[stempatlahir4];
    tempatlahir5 = json[stempatlahir5];
    tempatlahir6 = json[stempatlahir6];
    tempatlahir7 = json[stempatlahir7];
    tanggallahir = (json[stanggallahir] as Timestamp?)?.toDate();
    tanggallahir2 = (json[stanggallahir2] as Timestamp?)?.toDate();
    tanggallahir3 = (json[stanggallahir3] as Timestamp?)?.toDate();
    tanggallahir4 = (json[stanggallahir4] as Timestamp?)?.toDate();
    tanggallahir5 = (json[stanggallahir5] as Timestamp?)?.toDate();
    tanggallahir6 = (json[stanggallahir6] as Timestamp?)?.toDate();
    tanggallahir7 = (json[stanggallahir7] as Timestamp?)?.toDate();
    agama = json[sagama];
    agama2 = json[sagama2];
    agama3 = json[sagama3];
    agama4 = json[sagama4];
    agama5 = json[sagama5];
    agama6 = json[sagama6];
    agama7 = json[sagama7];
    statuskawin = json[sstatuskawin];
    statuskawin2 = json[sstatuskawin2];
    statuskawin3 = json[sstatuskawin3];
    statuskawin4 = json[sstatuskawin4];
    statuskawin5 = json[sstatuskawin5];
    statuskawin6 = json[sstatuskawin6];
    statuskawin7 = json[sstatuskawin7];
    statuskeluarga = json[sstatuskeluarga];
    statuskeluarga2 = json[sstatuskeluarga2];
    statuskeluarga3 = json[sstatuskeluarga3];
    statuskeluarga4 = json[sstatuskeluarga4];
    statuskeluarga5 = json[sstatuskeluarga5];
    statuskeluarga6 = json[sstatuskeluarga6];
    statuskeluarga7 = json[sstatuskeluarga7];
    // wni= json[swni];
    pekerjaan = json[spekerjaan];
    pekerjaan2 = json[spekerjaan2];
    pekerjaan3 = json[spekerjaan3];
    pekerjaan4 = json[spekerjaan4];
    pekerjaan5 = json[spekerjaan5];
    pekerjaan6 = json[spekerjaan6];
    pekerjaan7 = json[spekerjaan7];
    nikibu = json[snikibu];
    nikibu2 = json[snikibu];
    nikibu3 = json[snikibu];
    nikibu4 = json[snikibu];
    nikibu5 = json[snikibu];
    nikibu6 = json[snikibu];
    nikibu7 = json[snikibu];
    nikayah = json[nikayah];
    nikayah2 = json[nikayah2];
    nikayah3 = json[nikayah3];
    nikayah4 = json[nikayah4];
    nikayah5 = json[nikayah5];
    nikayah6 = json[nikayah6];
    nikayah7 = json[nikayah7];
    goldarah = json[sgoldarah];
    goldarah2 = json[sgoldarah2];
    goldarah3 = json[sgoldarah3];
    goldarah4 = json[sgoldarah4];
    goldarah5 = json[sgoldarah5];
    goldarah6 = json[sgoldarah6];
    goldarah7 = json[sgoldarah7];
    rt = json[srt];
    rw = json[srw];
    alamat = json[salamat];
    waktu = (json[swaktu] as Timestamp?)?.toDate();
    aktacerai = json[saktacerai];
    aktacerai2 = json[saktacerai2];
    aktacerai3 = json[saktacerai3];
    aktacerai4 = json[saktacerai4];
    aktacerai5 = json[saktacerai5];
    aktacerai6 = json[saktacerai6];
    aktacerai7 = json[saktacerai7];
    aktakawin = json[saktakawin];
    aktakawin2 = json[saktakawin2];
    aktakawin3 = json[saktakawin3];
    aktakawin4 = json[saktakawin4];
    aktakawin5 = json[saktakawin5];
    aktakawin6 = json[saktakawin6];
    aktakawin7 = json[saktakawin7];
    aktalahir = json[saktalahir];
    aktalahir2 = json[saktalahir2];
    aktalahir3 = json[saktalahir3];
    aktalahir4 = json[saktalahir4];
    aktalahir5 = json[saktalahir5];
    aktalahir6 = json[saktalahir6];
    aktalahir7 = json[saktalahir7];
    alamatsponsor = json[salamatsponsor];
    alamatsponsor2 = json[salamatsponsor2];
    alamatsponsor3 = json[salamatsponsor3];
    alamatsponsor4 = json[salamatsponsor4];
    alamatsponsor5 = json[salamatsponsor5];
    alamatsponsor6 = json[salamatsponsor6];
    alamatsponsor7 = json[salamatsponsor7];
    cacat = json[scacat];
    cacat2 = json[scacat2];
    cacat3 = json[scacat3];
    cacat4 = json[scacat4];
    cacat5 = json[scacat5];
    cacat6 = json[scacat6];
    cacat7 = json[scacat7];
    datakeluarga = json[sdatakeluarga];
    gelarbelakang = json[sgelarbelakang];
    gelarbelakang2 = json[sgelarbelakang2];
    gelarbelakang3 = json[sgelarbelakang3];
    gelarbelakang4 = json[sgelarbelakang4];
    gelarbelakang5 = json[sgelarbelakang5];
    gelarbelakang6 = json[sgelarbelakang6];
    gelarbelakang7 = json[sgelarbelakang7];
    gelardepan = json[sgelardepan];
    gelardepan2 = json[sgelardepan];
    gelardepan3 = json[sgelardepan];
    gelardepan4 = json[sgelardepan];
    gelardepan5 = json[sgelardepan];
    gelardepan6 = json[sgelardepan];
    gelardepan7 = json[sgelardepan];
    jeniscacat = json[sjeniscacat];
    jeniscacat2 = json[sjeniscacat2];
    jeniscacat3 = json[sjeniscacat3];
    jeniscacat4 = json[sjeniscacat4];
    jeniscacat5 = json[sjeniscacat5];
    jeniscacat6 = json[sjeniscacat6];
    jeniscacat7 = json[sjeniscacat7];
    jumkeluarga = json[sjumkeluarga];
    kodeppos = json[skodeppos];
    noakta = json[snoakta];
    noakta2 = json[snoakta2];
    noakta3 = json[snoakta3];
    noakta4 = json[snoakta4];
    noakta5 = json[snoakta5];
    noakta6 = json[snoakta6];
    noakta7 = json[snoakta7];
    noaktacerai = json[saktacerai];
    noaktacerai2 = json[saktacerai2];
    noaktacerai3 = json[saktacerai3];
    noaktacerai4 = json[saktacerai4];
    noaktacerai5 = json[saktacerai5];
    noaktacerai6 = json[saktacerai6];
    noaktacerai7 = json[saktacerai7];
    noaktakawin = json[saktakawin];
    noaktakawin2 = json[saktakawin2];
    noaktakawin3 = json[saktakawin3];
    noaktakawin4 = json[saktakawin4];
    noaktakawin5 = json[saktakawin5];
    noaktakawin6 = json[saktakawin6];
    noaktakawin7 = json[saktakawin7];
    noitas = json[snoitas];
    noitas2 = json[snoitas2];
    noitas3 = json[snoitas3];
    noitas4 = json[snoitas4];
    noitas5 = json[snoitas5];
    noitas6 = json[snoitas6];
    noitas7 = json[snoitas7];
    nopaspor = json[snopaspor];
    nopaspor2 = json[snopaspor2];
    nopaspor3 = json[snopaspor3];
    nopaspor4 = json[snopaspor4];
    nopaspor5 = json[snopaspor5];
    nopaspor6 = json[snopaspor6];
    nopaspor7 = json[snopaspor7];
    nowali = json[snowali];
    nowali2 = json[snowali2];
    nowali3 = json[snowali3];
    nowali4 = json[snowali4];
    nowali5 = json[snowali5];
    nowali6 = json[snowali6];
    nowali7 = json[snowali7];
    orgagama = json[sorgagama];
    orgagama2 = json[sorgagama2];
    orgagama3 = json[sorgagama3];
    orgagama4 = json[sorgagama4];
    orgagama5 = json[sorgagama5];
    orgagama6 = json[sorgagama6];
    orgagama7 = json[sorgagama7];
    pendidikan = json[spendidikan];
    pendidikan2 = json[spendidikan2];
    pendidikan3 = json[spendidikan3];
    pendidikan4 = json[spendidikan4];
    pendidikan5 = json[spendidikan5];
    pendidikan6 = json[spendidikan6];
    pendidikan7 = json[spendidikan7];
    telepon = json[stelepon];
    tempatitas = json[stempatitas];
    tempatitas2 = json[stempatitas2];
    tempatitas3 = json[stempatitas3];
    tempatitas4 = json[stempatitas4];
    tempatitas5 = json[stempatitas5];
    tempatitas6 = json[stempatitas6];
    tempatitas7 = json[stempatitas7];
    tempatpertama = json[stempatpertama];
    tempatpertama2 = json[stempatpertama2];
    tempatpertama3 = json[stempatpertama3];
    tempatpertama4 = json[stempatpertama4];
    tempatpertama5 = json[stempatpertama5];
    tempatpertama6 = json[stempatpertama6];
    tempatpertama7 = json[stempatpertama7];
    tipesponsor = json[stipesponsor];
    tipesponsor2 = json[stipesponsor2];
    tipesponsor3 = json[stipesponsor3];
    tipesponsor4 = json[stipesponsor4];
    tipesponsor5 = json[stipesponsor5];
    tipesponsor6 = json[stipesponsor6];
    tipesponsor7 = json[stipesponsor7];
    kewarganegaraan = json[skewarganegaraan];
    kewarganegaraan2 = json[skewarganegaraan2];
    kewarganegaraan3 = json[skewarganegaraan3];
    kewarganegaraan4 = json[skewarganegaraan4];
    kewarganegaraan5 = json[skewarganegaraan5];
    kewarganegaraan6 = json[skewarganegaraan6];
    kewarganegaraan7 = json[skewarganegaraan7];
    tanggalcerai = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai2 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai3 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai4 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai5 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai6 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalcerai7 = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalitas = (json[stanggalitas] as Timestamp?)?.toDate();
    tanggalitas2 = (json[stanggalitas2] as Timestamp?)?.toDate();
    tanggalitas3 = (json[stanggalitas3] as Timestamp?)?.toDate();
    tanggalitas4 = (json[stanggalitas4] as Timestamp?)?.toDate();
    tanggalitas5 = (json[stanggalitas5] as Timestamp?)?.toDate();
    tanggalitas6 = (json[stanggalitas6] as Timestamp?)?.toDate();
    tanggalitas7 = (json[stanggalitas7] as Timestamp?)?.toDate();
    tanggalkawin = (json[stanggalkawin] as Timestamp?)?.toDate();
    tanggalkawin2 = (json[stanggalkawin2] as Timestamp?)?.toDate();
    tanggalkawin3 = (json[stanggalkawin3] as Timestamp?)?.toDate();
    tanggalkawin4 = (json[stanggalkawin4] as Timestamp?)?.toDate();
    tanggalkawin5 = (json[stanggalkawin5] as Timestamp?)?.toDate();
    tanggalkawin6 = (json[stanggalkawin6] as Timestamp?)?.toDate();
    tanggalkawin7 = (json[stanggalkawin7] as Timestamp?)?.toDate();
    tanggalpaspor = (json[stanggalpaspor] as Timestamp?)?.toDate();
    tanggalpaspor2 = (json[stanggalpaspor2] as Timestamp?)?.toDate();
    tanggalpaspor3 = (json[stanggalpaspor3] as Timestamp?)?.toDate();
    tanggalpaspor4 = (json[stanggalpaspor4] as Timestamp?)?.toDate();
    tanggalpaspor5 = (json[stanggalpaspor5] as Timestamp?)?.toDate();
    tanggalpaspor6 = (json[stanggalpaspor6] as Timestamp?)?.toDate();
    tanggalpaspor7 = (json[stanggalpaspor7] as Timestamp?)?.toDate();
    tanggalpertama = (json[stanggalpertama] as Timestamp?)?.toDate();
    tanggalpertama2 = (json[stanggalpertama2] as Timestamp?)?.toDate();
    tanggalpertama3 = (json[stanggalpertama3] as Timestamp?)?.toDate();
    tanggalpertama4 = (json[stanggalpertama4] as Timestamp?)?.toDate();
    tanggalpertama5 = (json[stanggalpertama5] as Timestamp?)?.toDate();
    tanggalpertama6 = (json[stanggalpertama6] as Timestamp?)?.toDate();
    tanggalpertama7 = (json[stanggalpertama7] as Timestamp?)?.toDate();
    tanggalterbititas = (json[stanggalterbititas] as Timestamp?)?.toDate();
    tanggalterbititas2 = (json[stanggalterbititas2] as Timestamp?)?.toDate();
    tanggalterbititas3 = (json[stanggalterbititas3] as Timestamp?)?.toDate();
    tanggalterbititas4 = (json[stanggalterbititas4] as Timestamp?)?.toDate();
    tanggalterbititas5 = (json[stanggalterbititas5] as Timestamp?)?.toDate();
    tanggalterbititas6 = (json[stanggalterbititas6] as Timestamp?)?.toDate();
    tanggalterbititas7 = (json[stanggalterbititas7] as Timestamp?)?.toDate();
    email = json[semail];
    nomer = json[snomer];
    keperluan1 = json[skeperluan1];
    nik = json[snik];
    kk = json[skk];
    wni = json[swni];
    pendidikan_pngntr = json[spendidikan_pngntr];
  }

  Map<String, dynamic> get toJson => {
        sid: id,
        skewarganegaraan: kewarganegaraan,
        skewarganegaraan2: kewarganegaraan2,
        skewarganegaraan3: kewarganegaraan3,
        skewarganegaraan4: kewarganegaraan4,
        skewarganegaraan5: kewarganegaraan5,
        skewarganegaraan6: kewarganegaraan6,
        skewarganegaraan7: kewarganegaraan7,
        snamalengkap: namalengkap,
        snamalengkap2: namalengkap2,
        snamalengkap3: namalengkap3,
        snamalengkap4: namalengkap4,
        snamalengkap5: namalengkap5,
        snamalengkap6: namalengkap6,
        snamalengkap7: namalengkap7,
        sdatakeluarga: datakeluarga,
        skodeppos: kodeppos,
        sjumkeluarga: jumkeluarga,
        salamatsponsor: alamatsponsor,
        salamatsponsor2: alamatsponsor2,
        salamatsponsor3: alamatsponsor3,
        salamatsponsor4: alamatsponsor4,
        salamatsponsor5: alamatsponsor5,
        salamatsponsor6: alamatsponsor6,
        salamatsponsor7: alamatsponsor7,
        snowali: nowali,
        snowali2: nowali2,
        snowali3: nowali3,
        snowali4: nowali4,
        snowali5: nowali5,
        snowali6: nowali6,
        snowali7: nowali7,
        saktalahir: aktalahir,
        saktalahir2: aktalahir2,
        saktalahir3: aktalahir3,
        saktalahir4: aktalahir4,
        saktalahir5: aktalahir5,
        saktalahir6: aktalahir6,
        saktalahir7: aktalahir7,
        snoakta: noakta,
        snoakta2: noakta2,
        snoakta3: noakta3,
        snoakta4: noakta4,
        snoakta5: noakta5,
        snoakta6: noakta6,
        snoakta7: noakta7,
        sgoldarah: goldarah,
        sgoldarah2: goldarah2,
        sgoldarah3: goldarah3,
        sgoldarah4: goldarah4,
        sgoldarah5: goldarah5,
        sgoldarah6: goldarah6,
        sgoldarah7: goldarah7,
        sorgagama: orgagama,
        sorgagama2: orgagama2,
        sorgagama3: orgagama3,
        sorgagama4: orgagama4,
        sorgagama5: orgagama5,
        sorgagama6: orgagama6,
        sorgagama7: orgagama7,
        saktakawin: aktakawin,
        saktakawin2: aktakawin2,
        saktakawin3: aktakawin3,
        saktakawin4: aktakawin4,
        saktakawin5: aktakawin5,
        saktakawin6: aktakawin6,
        saktakawin7: aktakawin7,
        snoaktakawin: noaktakawin,
        snoaktakawin2: noaktakawin2,
        snoaktakawin3: noaktakawin3,
        snoaktakawin4: noaktakawin4,
        snoaktakawin5: noaktakawin5,
        snoaktakawin6: noaktakawin6,
        snoaktakawin7: noaktakawin7,
        stanggalkawin: tanggalkawin,
        stanggalkawin2: tanggalkawin2,
        stanggalkawin3: tanggalkawin3,
        stanggalkawin4: tanggalkawin4,
        stanggalkawin5: tanggalkawin5,
        stanggalkawin6: tanggalkawin6,
        stanggalkawin7: tanggalkawin7,
        saktacerai: aktacerai,
        saktacerai2: aktacerai2,
        saktacerai3: aktacerai3,
        saktacerai4: aktacerai4,
        saktacerai5: aktacerai5,
        saktacerai6: aktacerai6,
        saktacerai7: aktacerai7,
        snoaktacerai: noaktacerai,
        snoaktacerai2: noaktacerai2,
        snoaktacerai3: noaktacerai3,
        snoaktacerai4: noaktacerai4,
        snoaktacerai5: noaktacerai5,
        snoaktacerai6: noaktacerai6,
        snoaktacerai7: noaktacerai7,
        stanggalcerai: tanggalcerai,
        stanggalcerai2: tanggalcerai2,
        stanggalcerai3: tanggalcerai3,
        stanggalcerai4: tanggalcerai4,
        stanggalcerai5: tanggalcerai5,
        stanggalcerai6: tanggalcerai6,
        stanggalcerai7: tanggalcerai7,
        sstatuskeluarga: statuskeluarga,
        sstatuskeluarga2: statuskeluarga2,
        sstatuskeluarga3: statuskeluarga3,
        sstatuskeluarga4: statuskeluarga4,
        sstatuskeluarga5: statuskeluarga5,
        sstatuskeluarga6: statuskeluarga6,
        sstatuskeluarga7: statuskeluarga7,
        scacat: cacat,
        scacat2: cacat2,
        scacat3: cacat3,
        scacat4: cacat4,
        scacat5: cacat5,
        scacat6: cacat6,
        scacat7: cacat7,
        sjeniscacat: jeniscacat,
        sjeniscacat2: jeniscacat2,
        sjeniscacat3: jeniscacat3,
        sjeniscacat4: jeniscacat4,
        sjeniscacat5: jeniscacat5,
        sjeniscacat6: jeniscacat6,
        sjeniscacat7: jeniscacat7,
        spendidikan: pendidikan,
        spendidikan2: pendidikan2,
        spendidikan3: pendidikan3,
        spendidikan4: pendidikan4,
        spendidikan5: pendidikan5,
        spendidikan6: pendidikan6,
        spendidikan7: pendidikan7,
        snoitas: noitas,
        snoitas2: noitas2,
        snoitas3: noitas3,
        snoitas4: noitas4,
        snoitas5: noitas5,
        snoitas6: noitas6,
        snoitas7: noitas7,
        stanggalitas: tanggalitas,
        stanggalitas2: tanggalitas2,
        stanggalitas3: tanggalitas3,
        stanggalitas4: tanggalitas4,
        stanggalitas5: tanggalitas5,
        stanggalitas6: tanggalitas6,
        stanggalitas7: tanggalitas7,
        stanggalterbititas: tanggalterbititas,
        stanggalterbititas2: tanggalterbititas2,
        stanggalterbititas3: tanggalterbititas3,
        stanggalterbititas4: tanggalterbititas4,
        stanggalterbititas5: tanggalterbititas5,
        stanggalterbititas6: tanggalterbititas6,
        stanggalterbititas7: tanggalterbititas7,
        stempatitas: tempatitas,
        stempatitas2: tempatitas2,
        stempatitas3: tempatitas3,
        stempatitas4: tempatitas4,
        stempatitas5: tempatitas5,
        stempatitas6: tempatitas6,
        stempatitas7: tempatitas7,
        stempatpertama: tempatpertama,
        stempatpertama2: tempatpertama2,
        stempatpertama3: tempatpertama3,
        stempatpertama4: tempatpertama4,
        stempatpertama5: tempatpertama5,
        stempatpertama6: tempatpertama6,
        stempatpertama7: tempatpertama7,
        stanggalpertama: tanggalpertama,
        stanggalpertama2: tanggalpertama2,
        stanggalpertama3: tanggalpertama3,
        stanggalpertama4: tanggalpertama4,
        stanggalpertama5: tanggalpertama5,
        stanggalpertama6: tanggalpertama6,
        stanggalpertama7: tanggalpertama7,
        snikibu: nikibu,
        snikibu2: nikibu2,
        snikibu3: nikibu3,
        snikibu4: nikibu4,
        snikibu5: nikibu5,
        snikibu6: nikibu6,
        snikibu7: nikibu7,
        snamaibu: namaibu,
        snamaibu2: namaibu2,
        snamaibu3: namaibu3,
        snamaibu4: namaibu4,
        snamaibu5: namaibu5,
        snamaibu6: namaibu6,
        snamaibu7: namaibu7,
        snikayah: nikayah,
        snikayah2: nikayah2,
        snikayah3: nikayah3,
        snikayah4: nikayah4,
        snikayah5: nikayah5,
        snikayah6: nikayah6,
        snikayah7: nikayah7,
        snamaayah: namaayah,
        snamaayah2: namaayah2,
        snamaayah3: namaayah3,
        snamaayah4: namaayah4,
        snamaayah5: namaayah5,
        snamaayah6: namaayah6,
        snamaayah7: namaayah7,
        snamakepala: namakepala,
        sgelardepan: gelardepan,
        sgelardepan2: gelardepan2,
        sgelardepan3: gelardepan3,
        sgelardepan4: gelardepan4,
        sgelardepan5: gelardepan5,
        sgelardepan6: gelardepan6,
        sgelardepan7: gelardepan7,
        sgelarbelakang: gelarbelakang,
        sgelarbelakang2: gelarbelakang2,
        sgelarbelakang3: gelarbelakang3,
        sgelarbelakang4: gelarbelakang4,
        sgelarbelakang5: gelarbelakang5,
        sgelarbelakang6: gelarbelakang6,
        sgelarbelakang7: gelarbelakang7,
        snopaspor: nopaspor,
        snopaspor2: nopaspor2,
        snopaspor3: nopaspor3,
        snopaspor4: nopaspor4,
        snopaspor5: nopaspor5,
        snopaspor6: nopaspor6,
        snopaspor7: nopaspor7,
        stanggalpaspor: tanggalpaspor,
        stanggalpaspor2: tanggalpaspor2,
        stanggalpaspor3: tanggalpaspor3,
        stanggalpaspor4: tanggalpaspor4,
        stanggalpaspor5: tanggalpaspor5,
        stanggalpaspor6: tanggalpaspor6,
        stanggalpaspor7: tanggalpaspor7,
        snamasponsor: namasponsor,
        snamasponsor2: namasponsor2,
        snamasponsor3: namasponsor3,
        snamasponsor4: namasponsor4,
        snamasponsor5: namasponsor5,
        snamasponsor6: namasponsor6,
        snamasponsor7: namasponsor7,
        stipesponsor: tipesponsor,
        stipesponsor2: tipesponsor2,
        stipesponsor3: tipesponsor3,
        stipesponsor4: tipesponsor4,
        stipesponsor5: tipesponsor5,
        stipesponsor6: tipesponsor6,
        stipesponsor7: tipesponsor7,
        skelamin: kelamin,
        skelamin2: kelamin2,
        skelamin3: kelamin3,
        skelamin4: kelamin4,
        skelamin5: kelamin5,
        skelamin6: kelamin6,
        skelamin7: kelamin7,
        stempatlahir: tempatlahir,
        stempatlahir2: tempatlahir2,
        stempatlahir3: tempatlahir3,
        stempatlahir4: tempatlahir4,
        stempatlahir5: tempatlahir5,
        stempatlahir6: tempatlahir6,
        stempatlahir7: tempatlahir7,
        stanggallahir: tanggallahir,
        stanggallahir2: tanggallahir2,
        stanggallahir3: tanggallahir3,
        stanggallahir4: tanggallahir4,
        stanggallahir5: tanggallahir5,
        stanggallahir6: tanggallahir6,
        stanggallahir7: tanggallahir7,
        sagama: agama,
        sagama2: agama2,
        sagama3: agama3,
        sagama4: agama4,
        sagama5: agama5,
        sagama6: agama6,
        sagama7: agama7,
        sstatuskawin: statuskawin,
        sstatuskawin2: statuskawin2,
        sstatuskawin3: statuskawin3,
        sstatuskawin4: statuskawin4,
        sstatuskawin5: statuskawin5,
        sstatuskawin6: statuskawin6,
        sstatuskawin7: statuskawin7,
        // swni: wni,
        spekerjaan: pekerjaan,
        spekerjaan2: pekerjaan2,
        spekerjaan3: pekerjaan3,
        spekerjaan4: pekerjaan4,
        spekerjaan5: pekerjaan5,
        spekerjaan6: pekerjaan6,
        spekerjaan7: pekerjaan7,
        salamat: alamat,
        swaktu: waktu,
        skeperluan1: keperluan1,
        srt: rt,
        srw: rw,
        semail: email,
        swni: wni,
        spendidikan_pngntr: pendidikan_pngntr,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        kkCollection,
      ),
      storageReference: storage.ref(kkCollection));

  Future<KK> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (id != null) {
      db.edit(toJson);
    }
    return this;
  }

  Future<KK> streamList() async {
    print("getStream");
    return await db.collectionReference
        .orderBy("waktu", descending: true)
        .get()
        .then((event) {
      if (event.docs.length > 0) {
        return fromJson(event.docs.first);
      } else {
        return KK();
      }
    });
  }

  Stream<List<KK>> listKK() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<KK> list = [];
      for (var doc in query.docs) {
        list.add(
          KK.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
