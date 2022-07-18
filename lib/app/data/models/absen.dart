import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String uid = "id";
const String unama = "nama";
const String uemail = "email";
const String ualamat = "alamat";
const String uwaktu = "waktu";

class Absen {
  String? id;
  String? nama;
  String? email;
  String? alamat;
  DateTime? waktu;

  Absen({this.id, this.nama, this.email, this.alamat, this.waktu});

  Absen fromJson(DocumentSnapshot doc) {
    print("doc data = ${doc.data()}");
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Absen(
      id: doc.id,
      nama: json[unama],
      email: json[uemail],
      alamat: json[ualamat],
      waktu: (json[uwaktu] as Timestamp?)?.toDate(),
    );
  }

  Absen.fromJson(DocumentSnapshot doc) {
    print("doc data = ${doc.data()}");
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
    id = doc.id;
    nama = json?[unama];
    email = json?[uemail];
    alamat = json?[ualamat];
    waktu = (json?[uwaktu] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> get toJson => {
        uid: id,
        unama: nama,
        uemail: email,
        ualamat: alamat,
        uwaktu: waktu,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        absenCollection,
      ),
      storageReference: storage.ref(absenCollection));

  Future<Absen> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (id != null) {
      db.edit(toJson);
    }
    return this;
  }

  Stream<List<Absen>> streamList() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<Absen> list = [];
      for (var doc in query.docs) {
        list.add(
          Absen.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
