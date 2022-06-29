import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/database.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

const String lid = "id";
const String ljudul = "judul";
const String ldeskripsi = "deskripsi";
const String limage = "image";
const String lwaktu = "waktu";

class Informasi {
  String? id;
  String? judul;
  String? deskripsi;
  String? image;
  DateTime? waktu;

  Informasi({this.id, this.judul, this.deskripsi, this.image, this.waktu});

  Informasi fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Informasi(
      id: doc.id,
      judul: json[ljudul],
      deskripsi: json[ldeskripsi],
      image: json[limage],
      waktu: (json[lwaktu] as Timestamp?)?.toDate(),
    );
  }

  Informasi.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
    id =
    doc.id;
    judul = 
    json?[ljudul];
    deskripsi = 
    json?[ldeskripsi];
    image = 
    json?[limage];
    waktu =
    (json?[lwaktu] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> get toJson => {
        lid: id,
        ldeskripsi: deskripsi,
        ljudul: judul,
        limage: image,
        lwaktu: waktu,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        informasiCollection,
      ),
      storageReference: storage.ref(informasiCollection));

  Future<Informasi> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Future delete() async {
    if (id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "ID Tidak Valid",
        onConfirm: () => Get.back(),
        textConfirm: "Oke",
        buttonColor: primary,
        confirmTextColor: white,
        cancelTextColor: primary,
      );
      return;
    }
    return await db.delete(id!, url: image);
  }

  Stream<List<Informasi>> streamList() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<Informasi> list = [];
      for (var doc in query.docs) {
        list.add(
          Informasi.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
