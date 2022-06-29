// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:erte/app/data/database.dart';

// const String sid = "id";
// const String snama = "nama";
// const String skelamin = "kelamin";
// const String stempatlahir = "tempatlahir";
// const String stanggallahir = "tanggallahir";
// const String sktp = "ktp";
// const String salamat = "alamat";
// const String skeperluan = "keperluan";
// const String swaktu = "waktu";

// class Pernyataan {
//   String? id;
//   String? nama;
//   String? kelamin;
//   String? tempatlahir;
//   DateTime? tanggallahir;
//   int? ktp;
//   String? alamat;
//   String? keperluan;
//   DateTime? waktu;

//   Pernyataan({this.id, this.nama, this.kelamin, this.tempatlahir, this.tanggallahir, this.ktp,this.alamat, this.keperluan, this.waktu});

//   Pernyataan fromJson(DocumentSnapshot doc) {
//     Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
//     return Pernyataan(
//       id: doc.id,
//       nama: json[snama],
//       kelamin: json[skelamin],
//       tempatlahir: json[stempatlahir],
//       tanggallahir: (json[stanggallahir] as Timestamp?)?.toDate(),
//       ktp: json[sktp],
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
//         sktp: ktp,
//         salamat: alamat,
//         skeperluan: keperluan,
//         swaktu: waktu,
//       };

//   Database db = Database(
//       collectionReference: firestore.collection(
//         pernyataanCollection,
//       ),
//       storageReference: storage.ref(pernyataanCollection));

//   Future<Pernyataan> save() async {
//     id == null ? id = await db.add(toJson) : await db.edit(toJson);
//     if (id != null) {
//       db.edit(toJson);
//     }
//     return this;
//   }

// }
