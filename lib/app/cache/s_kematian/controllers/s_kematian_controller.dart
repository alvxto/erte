// import 'package:erte/app/data/models/s_kematian.dart';
// import 'package:erte/app/data/models/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SKematianController extends GetxController {
//   late TextEditingController namaC;
//   late TextEditingController tempatC;
//   late TextEditingController pekerjaanC;
//   late TextEditingController nikC;
//   late TextEditingController kkC;
//   late TextEditingController alamatC;
//   late TextEditingController keperluanC;
//   UserModel? selectedUser;

//   RxList<UserModel> rxUser = RxList<UserModel>();
//   List<UserModel> get users => rxUser.value;
//   set users(List<UserModel> value) => rxUser.value = value;

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

//   var _selectedWNI = ''.obs;
//   String get selectedWNI => _selectedWNI.value;
//   set selectedWNI(String value) => _selectedWNI.value = value;

//   List<String> listAgama = [
//     "Islam",
//     "Katholik",
//     "Kristen",
//     "Hindu",
//     "Budha",
//     "Konghucu"
//   ];
//   String? selectedAgama;

//   List<String> listStatus = [
//     "Belum Kawin",
//     "Kawin",
//     "Cerai Hidup",
//     "Cerai Mati",
//   ];
//   String? selectedStatus;

//   List<String> listPendidikan = [
//     "SD",
//     "SLTP",
//     "SLTA",
//     "SMK",
//     "SI",
//     "SII",
//     "Sederajat"
//   ];
//   String? selectedPendidikan;

//   var _isSaving = false.obs;
//   bool get isSaving => _isSaving.value;
//   set isSaving(bool value) => _isSaving.value = value;

//   // modelToController(kematian kematian) {
//   //   namaC.text = kematian.nama ?? '';
//   //   tempatC.text = kematian.tempatlahir ?? '';
//   //   pekerjaanC.text = kematian.pekerjaan ?? '';
//   //   alamatC.text = kematian.alamat ?? '';
//   //   keperluanC.text = kematian.keperluan ?? '';
//   //   nikC.text = kematian.nik?.toString() ?? '';
//   //   kkC.text = kematian.kk?.toString() ?? '';
//   //   selectedAgama = kematian.agama;
//   //   selectedKelamin = kematian.kelamin ?? '';
//   //   selectedTanggal = kematian.tanggallahir ?? DateTime.now();
//   //   selectedPendidikan = kematian.pekerjaan;
//   //   selectedStatus = kematian.status;
//   //   selectedWNI = kematian.wni ?? '';
//   // }

//   Future store(Kematian kematian) async {
//     isSaving = true;
//     kematian.nama = namaC.text;
//     kematian.pekerjaan = pekerjaanC.text;
//     kematian.agama = selectedAgama;
//     kematian.pendidikan = selectedPendidikan;
//     kematian.status = selectedStatus;
//     kematian.alamat = alamatC.text;
//     kematian.keperluan = keperluanC.text;
//     kematian.wni = selectedWNI;
//     kematian.kelamin = selectedKelamin;
//     kematian.nik = int.tryParse(nikC.text);
//     kematian.kk = int.tryParse(kkC.text);
//     kematian.tanggallahir = selectedTanggal;
//     kematian.tempatlahir = tempatC.text;
//     if (kematian.id == null) {
//       kematian.waktu = DateTime.now();
//     }
//     try {
//       await kematian.save();
//       Get.defaultDialog(
//           title: "Berhasil",
//           textConfirm: "Okay",
//           onConfirm: () {
//             namaC.clear();
//             pekerjaanC.clear();
//             tempatC.clear();
//             nikC.clear();
//             kkC.clear();
//             alamatC.clear();
//             keperluanC.clear();
//             selectedAgama = '';
//             selectedKelamin = '';
//             selectedPendidikan = '';
//             selectedStatus = '';
//             selectedWNI = '';
//             selectedTanggal = DateTime.now();
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
//     pekerjaanC = TextEditingController();
//     nikC = TextEditingController();
//     kkC = TextEditingController();
//     alamatC = TextEditingController();
//     keperluanC = TextEditingController();
//     rxUser.bindStream(UserModel().allstreamList());
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     namaC.clear();
//     pekerjaanC.clear();
//     tempatC.clear();
//     nikC.clear();
//     kkC.clear();
//     alamatC.clear();
//     keperluanC.clear();
//     selectedAgama = '';
//     selectedKelamin = '';
//     selectedPendidikan = '';
//     selectedStatus = '';
//     selectedWNI = '';
//     selectedTanggal = DateTime.now();
//   }
// }
