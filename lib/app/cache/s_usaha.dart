// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:erte/app/data/database.dart';
// import 'package:get/get.dart';

// const String sid = "id";
// const String snama = "nama";
// const String skelamin = "kelamin";
// const String stempatlahir = "tempatlahir";
// const String stanggallahir = "tanggallahir";
// const String sagama = "agama";
// const String sstatus = "status";
// const String swni = "wni";
// const String spendidikan = "pendidikan";
// const String spekerjaan = "pekerjaan";
// const String snik = "nik";
// const String skk = "kk";
// const String salamat = "alamat";
// const String skeperluan = "keperluan";
// const String swaktu = "waktu";

// class Usaha {
//   String? id;
//   String? nama;
//   String? kelamin;
//   String? tempatlahir;
//   DateTime? tanggallahir;
//   String? agama;
//   String? status;
//   String? wni;
//   String? pendidikan;
//   String? pekerjaan;
//   int? nik;
//   int? kk;
//   String? alamat;
//   String? keperluan;
//   DateTime? waktu;

//   Usaha({this.id, this.nama, this.kelamin, this.tempatlahir, this.tanggallahir, this.agama, this.status, this.wni, this.pendidikan, this.pekerjaan, this.nik, this.kk, this.alamat, this.keperluan, this.waktu});

//   Usaha fromJson(DocumentSnapshot doc) {
//     Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
//     return Usaha(
//       id: doc.id,
//       nama: json[snama],
//       kelamin: json[skelamin],
//       tempatlahir: json[stempatlahir],
//       tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
//       agama: json[sagama],
//       status: json[sstatus],
//       wni: json[swni],
//       pendidikan: json[spendidikan],
//       pekerjaan: json[spekerjaan],
//       nik: json[snik],
//       kk: json[skk],
//       alamat: json[salamat],
//       keperluan: json[skeperluan],
//       waktu: (json[swaktu] as Timestamp?)?.toDate(),
//     );
//   }

//   Map<String, dynamic> get toJson => {
//         sid: id,
//         snama: nama,
//         skelamin: kelamin,
//         stempatlahir: tempatlahir,
//         stanggallahir: tanggallahir,
//         sagama: agama,
//         sstatus: status,
//         swni: wni,
//         spendidikan: pendidikan,
//         spekerjaan: pekerjaan,
//         snik: nik,
//         skk: kk,
//         salamat: alamat,
//         skeperluan: keperluan,
//         swaktu: waktu,
//       };

//   Database db = Database(
//       collectionReference: firestore.collection(
//         usahaCollection,
//       ),
//       storageReference: storage.ref(usahaCollection));

//   Future<Usaha> save() async {
//     id == null ? id = await db.add(toJson) : await db.edit(toJson);
//     if (id != null) {
//       db.edit(toJson);
//     }
//     return this;
//   }

// }
