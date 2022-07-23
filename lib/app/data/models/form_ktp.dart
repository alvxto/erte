import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String sid = "id";
const String snama = "nama";
const String skelamin = "kelamin";
const String stempatlahir = "tempatlahir";
const String stanggallahir = "tanggallahir";
const String sagama = "agama";
const String sstatus = "status";
const String swni = "wni";
const String spendidikan = "pendidikan";
const String spekerjaan = "pekerjaan";
const String snik = "nik";
const String skk = "kk";
const String salamat = "alamat";
const String skeperluan1 = "keperluan1";
const String swaktu = "waktu";
const String sgoldarah = "goldarah";
const String simage = "image";
const String srt = "rt";
const String srw = "rw";
const String skelurahan = "kelurahan";
const String skecamatan = "kecamatan";
const String snomer = "nomer";
const String semail = "email";

class KTP {
  String? id;
  String? nama;
  String? kelamin;
  String? tempatlahir;
  DateTime? tanggallahir;
  String? agama;
  String? status;
  String? wni;
  String? pekerjaan;
  String? pendidikan;
  int? nomer;
  int? nik;
  int? kk;
  String? alamat;
  String? keperluan1;
  DateTime? waktu;
  String? goldarah;
  String? rt;
  String? rw;
  String? kecamatan;
  String? kelurahan;
  String? image;
  String? email;

  KTP({
    this.id,
    this.nama,
    this.kelamin,
    this.tempatlahir,
    this.tanggallahir,
    this.agama,
    this.status,
    this.wni,
    this.pendidikan,
    this.pekerjaan,
    this.nik,
    this.kk,
    this.alamat,
    this.keperluan1,
    this.waktu,
    this.image,
    this.goldarah,
    this.kecamatan,
    this.kelurahan,
    this.rt,
    this.rw,
    this.email,
    this.nomer,
  });

  KTP fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return KTP(
      id: doc.id,
      nama: json[snama],
      kelamin: json[skelamin],
      tempatlahir: json[stempatlahir],
      tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
      agama: json[sagama],
      status: json[sstatus],
      wni: json[swni],
      pendidikan: json[spendidikan],
      pekerjaan: json[spekerjaan],
      nik: json[snik],
      kk: json[skk],
      goldarah: json[sgoldarah],
      image: json[simage],
      rt: json[srt],
      rw: json[srw],
      kecamatan: json[skecamatan],
      kelurahan: json[skelurahan],
      alamat: json[salamat],
      keperluan1: json[skeperluan1],
      waktu: (json[swaktu] as Timestamp?)?.toDate(),
      email: json[semail],
      nomer: json[snomer],
    );
  }

  KTP.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;

    id = doc.id;
    nama = json[snama];
    kelamin = json[skelamin];
    tempatlahir = json[stempatlahir];
    tanggallahir = (json[stanggallahir] as Timestamp?)?.toDate();
    agama = json[sagama];
    status = json[sstatus];
    wni = json[swni];
    pendidikan = json[spendidikan];
    pekerjaan = json[spekerjaan];
    nik = json[snik];
    kk = json[skk];
    goldarah = json[sgoldarah];
    image = json[simage];
    rt = json[srt];
    rw = json[srw];
    kecamatan = json[skecamatan];
    kelurahan = json[skelurahan];
    alamat = json[salamat];
    keperluan1 = json[skeperluan1];
    waktu = (json[swaktu] as Timestamp?)?.toDate();
    email = json[semail];
    nomer = json[snomer];
  }

  Map<String, dynamic> get toJson => {
        sid: id,
        snama: nama,
        skelamin: kelamin,
        stempatlahir: tempatlahir,
        stanggallahir: tanggallahir,
        sagama: agama,
        sstatus: status,
        swni: wni,
        spendidikan: pendidikan,
        spekerjaan: pekerjaan,
        snik: nik,
        skk: kk,
        salamat: alamat,
        skeperluan1: keperluan1,
        swaktu: waktu,
        simage: image,
        sgoldarah: goldarah,
        srt: rt,
        srw: rw,
        skecamatan: kecamatan,
        skelurahan: kelurahan,
        semail: email,
        snomer: nomer,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        ktpCollection,
      ),
      storageReference: storage.ref(ktpCollection));

  Future<KTP> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Future<KTP> streamList() async {
    print("getStream");
    return await db.collectionReference
        .orderBy("waktu", descending: true)
        .get()
        .then((event) {
      if (event.docs.length > 0) {
        return fromJson(event.docs.first);
      } else {
        return KTP();
      }
    });
  }

  Stream<List<KTP>> listKTP() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<KTP> list = [];
      for (var doc in query.docs) {
        list.add(
          KTP.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
