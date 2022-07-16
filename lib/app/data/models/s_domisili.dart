import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String sid = "id";
const String snama = "nama";
const String skelamin = "kelamin";
const String stempatlahir = "tempatlahir";
const String stanggallahir = "tanggallahir";
const String snktp = "nktp";
const String salamat = "alamat";
const String skeperluan1 = "keperluan1";
const String swaktu = "waktu";
const String semail = "email";

class Domisili {
  String? id;
  String? nama;
  String? kelamin;
  String? tempatlahir;
  DateTime? tanggallahir;
  int? nktp;
  String? alamat;
  String? keperluan1;
  DateTime? waktu;
  String? email;

  Domisili({
    this.id,
    this.nama,
    this.kelamin,
    this.tempatlahir,
    this.tanggallahir,
    this.nktp,
    this.alamat,
    this.keperluan1,
    this.waktu,
    this.email,
  });

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
      keperluan1: json[skeperluan1],
      waktu: (json[swaktu] as Timestamp?)?.toDate(),
      email: json[semail],
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
        skeperluan1: keperluan1,
        swaktu: waktu,
        semail: email,
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
}
