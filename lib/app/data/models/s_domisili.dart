import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';
import 'package:get/get.dart';

const String sid = "id";
const String snama = "nama";
const String skelamin = "kelamin";
const String stempatlahir = "tempatlahir";
const String stanggallahir = "tanggallahir";
const String snktp = "nktp";
const String salamat = "alamat";
const String skeperluan = "keperluan";
const String swaktu = "waktu";
const String semail = "email";
const String snomer = "nomer";

class Domisili {
  String? id;
  String? nama;
  int? nomer;
  String? kelamin;
  String? tempatlahir;
  DateTime? tanggallahir;
  int? nktp;
  String? alamat;
  String? keperluan;
  DateTime? waktu;
  String? email;

  Domisili(
      {this.id,
      this.nama,
      this.kelamin,
      this.tempatlahir,
      this.tanggallahir,
      this.nktp,
      this.alamat,
      this.keperluan,
      this.waktu,
      this.email,
      this.nomer});

  Domisili fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Domisili(
      id: doc.id,
      nama: json[snama],
      kelamin: json[skelamin],
      tempatlahir: json[stempatlahir],
      tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
      nktp: json[snktp],
      alamat: json[salamat],
      keperluan: json[skeperluan],
      waktu: (json[swaktu] as Timestamp?)?.toDate(),
      email: json[semail],
      nomer: json[snomer],
    );
  }

  Map<String, dynamic> get toJson => {
        sid: id,
        snama: nama,
        skelamin: kelamin,
        stempatlahir: tempatlahir,
        stanggallahir: tanggallahir,
        snktp: nktp,
        salamat: alamat,
        skeperluan: keperluan,
        swaktu: waktu,
        semail: email,
        snomer: nomer,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        domisiliCollection,
      ),
      storageReference: storage.ref(domisiliCollection));

  Future<Domisili> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (id != null) {
      db.edit(toJson);
    }
    return this;
  }

  Future<Domisili> streamList() async {
    print("getStream");
    return await db.collectionReference
        .orderBy("waktu", descending: true)
        .get()
        .then((event) {
      return fromJson(event.docs.first);
    });
  }
}
