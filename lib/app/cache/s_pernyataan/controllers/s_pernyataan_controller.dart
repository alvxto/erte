// import 'package:erte/app/data/models/s_pernyataan.dart';
// import 'package:erte/app/data/models/s_pernyataan.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SPernyataanController extends GetxController {
//   late TextEditingController namaC;
//   late TextEditingController tempatC;
//   late TextEditingController ktpC;
//   late TextEditingController alamatC;
//   late TextEditingController keperluanC;

//   Rx<DateTime?> _selectedTanggal = DateTime.now().obs;
//   DateTime? get selectedTanggal => _selectedTanggal.value;
//   set selectedTanggal(DateTime? value) => _selectedTanggal.value = value;

//   tanggalLahir(dynamic context) async {
//     selectedTanggal = await showDatePicker(
//             context: context,
//             initialDate: selectedTanggal ?? DateTime.now(),
//             // initialDatePickerMode: DatePickerMode.year,
//             firstDate:
//                 DateTime(1900),
//             lastDate: DateTime(2050)) ??
//         selectedTanggal;
//   }

//   var _selectedKelamin = ''.obs;
//   String get selectedKelamin => _selectedKelamin.value;
//   set selectedKelamin(String value) => _selectedKelamin.value = value;

//   var _isSaving = false.obs;
//   bool get isSaving => _isSaving.value;
//   set isSaving(bool value) => _isSaving.value = value;

//   // modelToController(Pernyataan pernyataan) {
//   //   namaC.text = pernyataan.nama ?? '';
//   //   tempatC.text = pernyataan.tempatlahir ?? '';
//   //   alamatC.text = pernyataan.alamat ?? '';
//   //   keperluanC.text = pernyataan.keperluan ?? '';
//   //   selectedKelamin = pernyataan.kelamin ?? '';
//   //   selectedTanggal = pernyataan.tanggallahir ?? DateTime.now();
//   //   ktpC.text = pernyataan.ktp?.toString() ?? '';
//   // }

//   Future store(Pernyataan pernyataan) async {
//     isSaving = true;
//     pernyataan.nama = namaC.text;
//     pernyataan.alamat = alamatC.text;
//     pernyataan.keperluan = keperluanC.text;
//     pernyataan.kelamin = selectedKelamin;
//     pernyataan.tanggallahir = selectedTanggal;
//     pernyataan.tempatlahir = tempatC.text;
//     pernyataan.ktp = int.tryParse(ktpC.text);
//     if (pernyataan.id == null) {
//       pernyataan.waktu = DateTime.now();
//     }
//     try {
//       await pernyataan.save();
//       Get.defaultDialog(
//           title: "Berhasil",
//           textConfirm: "Okay",
//           onConfirm: () {
//             namaC.clear();
//             tempatC.clear();
//             alamatC.clear();
//             keperluanC.clear();
//             selectedKelamin = '';
//             selectedTanggal = DateTime.now();
//             ktpC.clear();
//             Get.back();
//           });
//     } catch (e) {
//       print(e);
//     } finally {
//       isSaving = false;
//     }
//   }

//   @override
//   void onInit() {
//     super.onInit();
//     namaC = TextEditingController();
//     tempatC = TextEditingController();
//     alamatC = TextEditingController();
//     keperluanC = TextEditingController();
//     ktpC = TextEditingController();
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     namaC.clear();
//     tempatC.clear();
//     alamatC.clear();
//     keperluanC.clear();
//     ktpC.clear();
//     selectedKelamin = '';
//     selectedTanggal = DateTime.now();
//   }
// }
