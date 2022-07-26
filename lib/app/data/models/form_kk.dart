import 'dart:ffi';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String sid = "id";
const String sdatakeluarga = "datakeluarga";
const String snamakepala = "namakepala";
const String snamalengkap = "namalengkap";
const String salamat = "alamat";
const String skodepos = "kodepos";
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
const String snomer = "nomer";
const String skeperluan1 = "keperluan1";
const String skk = "kk";
const String snik = "nik";
const String swni = "wni";
const String spendidikan_pngntr = "pendidikan_pngntr";
const String sstatuskwinpngntr = "statuskwinpngntr";
const String sListAnggota = "listAnggota";

class Anggota {
  String? id;
  String? namalengkap;
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
  String? statuskwinpngntr;
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
  String? kelamin;

  Anggota({
    this.id,
    this.namalengkap,
    this.kewarganegaraan,
    this.namasponsor,
    this.tipesponsor,
    this.alamatsponsor,
    this.gelardepan,
    this.gelarbelakang,
    this.nopaspor,
    this.tanggalpaspor,
    this.nowali,
    this.aktalahir,
    this.noakta,
    this.orgagama,
    this.aktakawin,
    this.tanggalkawin,
    this.noaktakawin,
    this.aktacerai,
    this.tanggalcerai,
    this.noaktacerai,
    this.statuskeluarga,
    this.cacat,
    this.jeniscacat,
    this.pendidikan,
    this.tempatlahir,
    this.tanggallahir,
    this.agama,
    this.statuskwinpngntr,
    this.statuskawin,
    this.pekerjaan,
    this.nikibu,
    this.nikayah,
    this.namaayah,
    this.goldarah,
    this.noitas,
    this.tempatitas,
    this.tanggalterbititas,
    this.tanggalitas,
    this.tempatpertama,
    this.tanggalpertama,
    this.kelamin,
  });

  Anggota.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    id = doc.id;
    namalengkap = json[snamalengkap];
    namaayah = json[snamaayah];
    namaibu = json[snamaibu];
    namasponsor = json[snamasponsor];
    kelamin = json[skelamin];
    tempatlahir = json[stempatlahir];
    tanggallahir = (json[stanggallahir] as Timestamp?)?.toDate();
    agama = json[sagama];
    statuskawin = json[sstatuskawin];
    statuskeluarga = json[sstatuskeluarga];
    // wni= json[swni];
    pekerjaan = json[spekerjaan];
    nikibu = json[snikibu];
    nikayah = json[nikayah];
    goldarah = json[sgoldarah];
    aktacerai = json[saktacerai];
    aktakawin = json[saktakawin];
    aktalahir = json[saktalahir];
    alamatsponsor = json[salamatsponsor];
    cacat = json[scacat];
    gelarbelakang = json[sgelarbelakang];
    gelardepan = json[sgelardepan];
    jeniscacat = json[sjeniscacat];
    noakta = json[snoakta];
    noaktacerai = json[saktacerai];
    noaktakawin = json[saktakawin];
    noitas = json[snoitas];
    nopaspor = json[snopaspor];
    nowali = json[snowali];
    orgagama = json[sorgagama];
    pendidikan = json[spendidikan];
    tempatitas = json[stempatitas];
    tempatpertama = json[stempatpertama];
    tipesponsor = json[stipesponsor];
    kewarganegaraan = json[skewarganegaraan];
    tanggalcerai = (json[stanggalcerai] as Timestamp?)?.toDate();
    tanggalitas = (json[stanggalitas] as Timestamp?)?.toDate();
    tanggalkawin = (json[stanggalkawin] as Timestamp?)?.toDate();
    tanggalpaspor = (json[stanggalpaspor] as Timestamp?)?.toDate();
    tanggalpertama = (json[stanggalpertama] as Timestamp?)?.toDate();
    tanggalterbititas = (json[stanggalterbititas] as Timestamp?)?.toDate();
  }
  Map<String, dynamic> get toJson => {
        sid: id,
        skewarganegaraan: kewarganegaraan,
        snamalengkap: namalengkap,
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
        spekerjaan: pekerjaan,
      };
  Database db = Database(
      collectionReference: firestore.collection(
        kkCollection,
      ),
      storageReference: storage.ref(kkCollection));

  Future<Anggota> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (id != null) {
      db.edit(toJson);
    }
    return this;
  }

  Stream<List<Anggota>> listAnggota() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<Anggota> list = [];
      for (var doc in query.docs) {
        list.add(
          Anggota.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}

class KK {
  String? id;
  String? datakeluarga;
  String? namakepala;
  String? alamat;
  int? kodepos;
  int? telepon;
  int? jumkeluarga;
  int? rt;
  int? rw;
  DateTime? waktu;
  String? email;
  String? keperluan1;
  int? nomer;
  int? nik;
  int? kk;
  String? wni;
  String? pendidikan_pngntr;
  List<Anggota>? listAnggota;

  KK({
    this.id,
    this.datakeluarga,
    this.namakepala,
    this.alamat,
    this.kodepos,
    this.telepon,
    this.jumkeluarga,
    this.rt,
    this.rw,
    this.waktu,
    this.email,
    this.keperluan1,
    this.nomer,
    this.nik,
    this.kk,
    this.wni,
    this.pendidikan_pngntr,
    this.listAnggota,
  });

  KK.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    id = doc.id;
    datakeluarga = json[sdatakeluarga];
    namakepala = json[snamakepala];
    alamat = json[salamat];
    kodepos = json[skodepos];
    telepon = json[stelepon];
    jumkeluarga = json[sjumkeluarga];
    rt = json[srt];
    rw = json[srw];
    waktu = (json[swaktu] as Timestamp?)?.toDate();
    email = json[semail];
    keperluan1 = json[skeperluan1];
    nomer = json[snomer];
    nik = json[snik];
    kk = json[skk];
    wni = json[swni];
    pendidikan_pngntr = json[spendidikan_pngntr];
    listAnggota =
        (json[sListAnggota] as List?)?.map((e) => Anggota.fromJson(e)).toList();
  }

  Map<String, dynamic> get toJson => {
        sid: id,
        sdatakeluarga: datakeluarga,
        snamakepala: namakepala,
        salamat: alamat,
        skodepos: kodepos,
        stelepon: telepon,
        sjumkeluarga: jumkeluarga,
        srt: rt,
        srw: rw,
        swaktu: waktu,
        semail: email,
        skeperluan1: keperluan1,
        snomer: nomer,
        snik: nik,
        skk: kk,
        swni: wni,
        spendidikan_pngntr: pendidikan_pngntr,
        sListAnggota: listAnggota?.map((e) => e.toJson).toList()
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
