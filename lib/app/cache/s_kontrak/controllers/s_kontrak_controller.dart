// import 'package:erte/app/data/models/s_kontrak.dart';
// import 'package:erte/app/data/models/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SKontrakController extends GetxController {
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

//   // modelToController(kontrak kontrak) {
//   //   namaC.text = kontrak.nama ?? '';
//   //   tempatC.text = kontrak.tempatlahir ?? '';
//   //   pekerjaanC.text = kontrak.pekerjaan ?? '';
//   //   alamatC.text = kontrak.alamat ?? '';
//   //   keperluanC.text = kontrak.keperluan ?? '';
//   //   nikC.text = kontrak.nik?.toString() ?? '';
//   //   kkC.text = kontrak.kk?.toString() ?? '';
//   //   selectedAgama = kontrak.agama;
//   //   selectedKelamin = kontrak.kelamin ?? '';
//   //   selectedTanggal = kontrak.tanggallahir ?? DateTime.now();
//   //   selectedPendidikan = kontrak.pekerjaan;
//   //   selectedStatus = kontrak.status;
//   //   selectedWNI = kontrak.wni ?? '';
//   // }

//   Future store(Kontrak kontrak) async {
//     isSaving = true;
//     kontrak.nama = namaC.text;
//     kontrak.pekerjaan = pekerjaanC.text;
//     kontrak.agama = selectedAgama;
//     kontrak.pendidikan = selectedPendidikan;
//     kontrak.status = selectedStatus;
//     kontrak.alamat = alamatC.text;
//     kontrak.keperluan = keperluanC.text;
//     kontrak.wni = selectedWNI;
//     kontrak.kelamin = selectedKelamin;
//     kontrak.nik = int.tryParse(nikC.text);
//     kontrak.kk = int.tryParse(kkC.text);
//     kontrak.tanggallahir = selectedTanggal;
//     kontrak.tempatlahir = tempatC.text;
//     if (kontrak.id == null) {
//       kontrak.waktu = DateTime.now();
//     }
//     try {
//       await kontrak.save();
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
