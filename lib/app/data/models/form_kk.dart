import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String sid = "id";
const String sdatakeluarga = "datakeluarga";
const String snamakepala = "namakepala";
const String snamalengkap = "namalengkap";
const String salamat = "alamat";
const String skodeppos = "kodepos";
const String stelepon = "telepon";
const String sjumkeluarga = "jumkeluarga";
const String snamasponsor = "namasponsor";
const String stipesponsor = "tipesponsor";
const String salamatsponsor = "alamatsponsor";
const String sgelardepan = "gelardepan";
const String sgelarbelakang = "gelarbelakang";
const String snopaspor = "nopaspor";
const String stanggalpaspor = "tanggalpaspor";
const String snowali = "nowali";
const String saktalahir = "aktalahir";
const String snoakta = "noaktalahir";
const String sorgagama = "orgagama";
const String saktakawin = "aktakawin";
const String stanggalkawin = "tanggalkawin";
const String snoaktakawin = "noaktakawin";
const String saktacerai = "aktacerai";
const String stanggalcerai = "tanggalcerai";
const String snoaktacerai = "noaktacerai";
const String sstatuskeluarga = "statuskeluarga";
const String scacat = "cacat";
const String sjeniscacat = "jeniscacat";
const String spendidikan = "pendidikan";
const String stempatlahir = "tempatlahir";
const String stanggallahir = "tanggallahir";
const String sagama = "agama";
const String sstatuskawin = "statuskawin";
// const String swni = "wni";
const String spekerjaan = "pekerjaan";
const String snikibu = "nikibu";
const String snamaibu = "namaibu";
const String snikayah = "nikayah";
const String snamaayah = "namaayah";
const String sgoldarah = "goldarah";
const String snoitas = "noitas";
const String stempatitas = "tempatitas";
const String stanggalterbititas = "tanggalterbititas";
const String stanggalitas = "tanggalitas";
const String stempatpertama = "tempatpertama";
const String stanggalpertama = "tanggalpertama";
const String srt = "rt";
const String srw = "rw";
const String skelamin = "kelamin";
const String skewarganegaraan = "kewarganegaraan";
const String swaktu = "waktu";
const String semail = "email";

class KK {
  String? id;
  String? datakeluarga;
  String? namakepala;
  String? namalengkap;
  String? alamat;
  int? kodeppos;
  int? telepon;
  int? jumkeluarga;
  String? kewarganegaraan;
  String? namasponsor;
  String? tipesponsor;
  String? alamatsponsor;
  String? gelardepan;
  String? gelarbelakang;
  String? nopaspor;
  DateTime? tanggalpaspor;
  int? nowali;
  String? aktalahir;
  String? noakta;
  String? orgagama;
  String? aktakawin;
  DateTime? tanggalkawin;
  String? noaktakawin;
  String? aktacerai;
  DateTime? tanggalcerai;
  String? noaktacerai;
  String? statuskeluarga;
  String? cacat;
  String? jeniscacat;
  String? pendidikan;
  String? tempatlahir;
  DateTime? tanggallahir;
  String? agama;
  String? statuskawin;
  // String? wni;
  String? pekerjaan;
  int? nikibu;
  String? namaibu;
  int? nikayah;
  String? namaayah;
  String? goldarah;
  String? noitas;
  String? tempatitas;
  DateTime? tanggalterbititas;
  DateTime? tanggalitas;
  String? tempatpertama;
  DateTime? tanggalpertama;
  int? rt;
  int? rw;
  String? kelamin;
  DateTime? waktu;
  String? email;

  KK({
    this.agama,
    this.aktacerai,
    this.aktakawin,
    this.aktalahir,
    this.alamat,
    this.alamatsponsor,
    this.tipesponsor,
    this.cacat,
    this.datakeluarga,
    this.gelarbelakang,
    this.gelardepan,
    this.goldarah,
    this.id,
    this.jeniscacat,
    this.jumkeluarga,
    this.kelamin,
    this.kodeppos,
    this.namaayah,
    this.namaibu,
    this.namakepala,
    this.namalengkap,
    this.nikayah,
    this.namasponsor,
    this.nikibu,
    this.noakta,
    this.noaktacerai,
    this.noaktakawin,
    this.noitas,
    this.nopaspor,
    this.nowali,
    this.orgagama,
    this.pekerjaan,
    this.pendidikan,
    this.rt,
    this.rw,
    this.statuskawin,
    this.statuskeluarga,
    this.tanggalcerai,
    this.tanggalitas,
    this.tanggalkawin,
    this.tanggallahir,
    this.tanggalpaspor,
    this.tanggalpertama,
    this.tanggalterbititas,
    this.telepon,
    this.tempatitas,
    this.tempatlahir,
    this.tempatpertama,
    this.waktu,
    // this.wni,
    this.kewarganegaraan,
    this.email,
  });

  KK fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return KK(
      id: doc.id,
      namakepala: json[snamakepala],
      namalengkap: json[snamalengkap],
      namaayah: json[snamaayah],
      namaibu: json[snamaibu],
      namasponsor: json[snamasponsor],
      kelamin: json[skelamin],
      tempatlahir: json[stempatlahir],
      tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
      agama: json[sagama],
      statuskawin: json[sstatuskawin],
      statuskeluarga: json[sstatuskeluarga],
      // wni: json[swni],
      pekerjaan: json[spekerjaan],
      nikibu: json[snikibu],
      nikayah: json[nikayah],
      goldarah: json[sgoldarah],
      rt: json[srt],
      rw: json[srw],
      alamat: json[salamat],
      waktu: (json[swaktu] as Timestamp?)?.toDate(),
      aktacerai: json[saktacerai],
      aktakawin: json[saktakawin],
      aktalahir: json[saktalahir],
      alamatsponsor: json[salamatsponsor],
      cacat: json[scacat],
      datakeluarga: json[sdatakeluarga],
      gelarbelakang: json[sgelarbelakang],
      gelardepan: json[sgelardepan],
      jeniscacat: json[sjeniscacat],
      jumkeluarga: json[sjumkeluarga],
      kodeppos: json[skodeppos],
      noakta: json[snoakta],
      noaktacerai: json[saktacerai],
      noaktakawin: json[saktakawin],
      noitas: json[snoitas],
      nopaspor: json[snopaspor],
      nowali: json[snowali],
      orgagama: json[sorgagama],
      pendidikan: json[spendidikan],
      telepon: json[stelepon],
      tempatitas: json[stempatitas],
      tempatpertama: json[stempatpertama],
      tipesponsor: json[stipesponsor],
      kewarganegaraan: json[skewarganegaraan],
      tanggalcerai: (json[stanggalcerai] as Timestamp?)?.toDate(),
      tanggalitas: (json[stanggalitas] as Timestamp?)?.toDate(),
      tanggalkawin: (json[stanggalkawin] as Timestamp?)?.toDate(),
      tanggalpaspor: (json[stanggalpaspor] as Timestamp?)?.toDate(),
      tanggalpertama: (json[stanggalpertama] as Timestamp?)?.toDate(),
      tanggalterbititas: (json[stanggalterbititas] as Timestamp?)?.toDate(),
      email: json[semail],
    );
  }

  Map<String, dynamic> get toJson => {
        sid: id,
        skewarganegaraan: kewarganegaraan,
        snamalengkap: namalengkap,
        sdatakeluarga: datakeluarga,
        skodeppos: kodeppos,
        sjumkeluarga: jumkeluarga,
        salamatsponsor: alamatsponsor,
        snowali: nowali,
        saktalahir: aktalahir,
        snoakta: noakta,
        sgoldarah: goldarah,
        sorgagama: orgagama,
        saktakawin: aktakawin,
        snoaktakawin: noaktakawin,
        stanggalkawin: tanggalkawin,
        saktacerai: aktacerai,
        snoaktacerai: noaktacerai,
        stanggalcerai: tanggalcerai,
        sstatuskeluarga: statuskeluarga,
        scacat: cacat,
        sjeniscacat: jeniscacat,
        spendidikan: pendidikan,
        snoitas: noitas,
        stanggalitas: tanggalitas,
        stanggalterbititas: tanggalterbititas,
        stempatitas: tempatitas,
        stempatpertama: tempatpertama,
        stanggalpertama: tanggalpertama,
        snikibu: nikibu,
        snamaibu: namaibu,
        snikayah: nikayah,
        snamaayah: namaayah,
        snamakepala: namakepala,
        sgelardepan: gelardepan,
        sgelarbelakang: gelarbelakang,
        snopaspor: nopaspor,
        stanggalpaspor: tanggalpaspor,
        snamasponsor: namasponsor,
        stipesponsor: tipesponsor,
        skelamin: kelamin,
        stempatlahir: tempatlahir,
        stanggallahir: tanggallahir,
        sagama: agama,
        sstatuskawin: statuskawin,
        // swni: wni,
        spekerjaan: pekerjaan,
        salamat: alamat,
        swaktu: waktu,
        srt: rt,
        srw: rw,
        semail: email,
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
}
