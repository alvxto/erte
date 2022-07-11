import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/database.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

const String lid = "id";
const String lkategori = "kategori";
const String ldeskripsi = "deskripsi";
const String luang = "uang";
const String lwaktu = "waktu";

class Kas {
  String? id;
  String? kategori;
  String? deskripsi;
  String? uang;
  DateTime? waktu;

  Kas({this.id, this.kategori, this.deskripsi, this.uang, this.waktu});

  Kas fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return Kas(
      id: doc.id,
      kategori: json[lkategori],
      deskripsi: json[ldeskripsi],
      uang: json[luang],
      waktu: (json[lwaktu] as Timestamp?)?.toDate(),
    );
  }

  Kas.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? json = doc.data() as Map<String, dynamic>?;
    id = doc.id;
    kategori = json?[lkategori];
    deskripsi = json?[ldeskripsi];
    uang = json?[luang];
    waktu = (json?[lwaktu] as Timestamp?)?.toDate();
  }

  Map<String, dynamic> get toJson => {
        lid: id,
        ldeskripsi: deskripsi,
        lkategori: kategori,
        luang: uang,
        lwaktu: waktu,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        kasCollection,
      ),
      storageReference: storage.ref(kasCollection));

  Future<Kas> save() async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (id != null) {
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
    return await db.delete(id!);
  }

  Stream<List<Kas>> streamList() async* {
    yield* db.collectionReference
        .orderBy("waktu", descending: true)
        .snapshots()
        .map((query) {
      List<Kas> list = [];
      for (var doc in query.docs) {
        list.add(
          Kas.fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
