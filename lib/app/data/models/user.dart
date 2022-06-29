import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/data/database.dart';

const String uid = "id";
const String unama = "nama";
const String uemail = "email";
const String upassword = "password";
const String ukelamin = "kelamin";
const String utempatlahir = "tempatlahir";
const String utanggallahir = "tanggallahir";
const String uagama = "agama";
const String ustatus = "status";
const String uwni = "wni";
const String uimage = "image";
const String ualamat = "alamat";
const String uwaktu = "waktu";
const String upendidikan = "pendidikan";
const String upekerjaan = "pekerjaan";
const String unik = "nik";
const String ukk = "kk";
const String ugoldarah = "goldarah";
const String urt = "rt";
const String urw = "rw";
const String ukelurahan = "kelurahan";
const String ukecamatan = "kecamatan";
const String urole = "role";

class UserModel {
  String? id;
  String? nama;
  String? email;
  String? password;
  String? image;
  String? kelamin;
  String? tempatlahir;
  DateTime? tanggallahir;
  String? agama;
  String? status;
  String? wni;
  String? alamat;
  String? pendidikan;
  String? pekerjaan;
  int? nik;
  int? kk;
  String? goldarah;
  String? rt;
  String? rw;
  String? kecamatan;
  String? kelurahan;
  String? role;
  DateTime? waktu;

  UserModel(
      {this.id,
      this.nama,
      this.email,
      this.password,
      this.image,
      this.kelamin,
      this.tanggallahir,
      this.tempatlahir,
      this.agama,
      this.alamat,
      this.status,
      this.wni,
      this.kk,
      this.nik,
      this.pekerjaan,
      this.pendidikan,
      this.goldarah,
      this.kecamatan,
      this.kelurahan,
      this.rt,
      this.rw,
      this.role,
      this.waktu});

  UserModel fromJson(DocumentSnapshot doc) {
    print("doc data = ${doc.data()}");
    Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      nama: json[unama],
      email: json[uemail],
      kelamin: json[ukelamin],
      tempatlahir: json[utempatlahir],
      tanggallahir: (json[utanggallahir] as Timestamp?)?.toDate(),
      agama: json[uagama],
      status: json[ustatus],
      wni: json[uwni],
      pendidikan: json[upendidikan],
      pekerjaan: json[upekerjaan],
      nik: json[unik],
      kk: json[ukk],
      alamat: json[ualamat],
      password: json[upassword],
      rt: json[urt],
      rw: json[urw],
      kecamatan: json[ukecamatan],
      kelurahan: json[ukelurahan],
      goldarah: json[ugoldarah],
      role: json[urole],
      image: json[uimage],
      waktu: (json[uwaktu] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> get toJson => {
        uid: id,
        unama: nama,
        uemail: email,
        upassword: password,
        uimage: image,
        ukelamin: kelamin,
        utempatlahir: tempatlahir,
        utanggallahir: tanggallahir,
        upendidikan: pendidikan,
        upekerjaan: pekerjaan,
        unik: nik,
        ukk: kk,
        uagama: agama,
        ustatus: status,
        uwni: wni,
        ualamat: alamat,
        ugoldarah: goldarah,
        urt: rt,
        urw: rw,
        ukecamatan: kecamatan,
        ukelurahan: kelurahan,
        urole: role,
        uwaktu: waktu,
      };

  Database db = Database(
      collectionReference: firestore.collection(
        userCollection,
      ),
      storageReference: storage.ref(userCollection));

  Future<UserModel> save({File? file}) async {
    id == null ? id = await db.add(toJson) : await db.edit(toJson);
    if (file != null && id != null) {
      image = await db.upload(id: id!, file: file);
      db.edit(toJson);
    }
    return this;
  }

  Stream<UserModel> streamList(String id) async* {
    print("getStream");
    yield* db.collectionReference.doc(id).snapshots().map((event) {
      print("event id = ${event.id}");
      return fromJson(event);
    });
  }

  Stream<List<UserModel>> allstreamList() async* {
    yield* db.collectionReference
        .orderBy("time", descending: true)
        .snapshots()
        .map((query) {
      List<UserModel> list = [];
      for (var doc in query.docs) {
        list.add(
          UserModel().fromJson(
            doc,
          ),
        );
      }
      return list;
    });
  }
}
