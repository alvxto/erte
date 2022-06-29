// import 'package:erte/app/data/models/s_usaha.dart';
// import 'package:erte/app/data/models/user.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class SUsahaController extends GetxController {
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

//   // modelToController(usaha usaha) {
//   //   namaC.text = usaha.nama ?? '';
//   //   tempatC.text = usaha.tempatlahir ?? '';
//   //   pekerjaanC.text = usaha.pekerjaan ?? '';
//   //   alamatC.text = usaha.alamat ?? '';
//   //   keperluanC.text = usaha.keperluan ?? '';
//   //   nikC.text = usaha.nik?.toString() ?? '';
//   //   kkC.text = usaha.kk?.toString() ?? '';
//   //   selectedAgama = usaha.agama;
//   //   selectedKelamin = usaha.kelamin ?? '';
//   //   selectedTanggal = usaha.tanggallahir ?? DateTime.now();
//   //   selectedPendidikan = usaha.pekerjaan;
//   //   selectedStatus = usaha.status;
//   //   selectedWNI = usaha.wni ?? '';
//   // }

//   Future store(Usaha usaha) async {
//     isSaving = true;
//     usaha.nama = namaC.text;
//     usaha.pekerjaan = pekerjaanC.text;
//     usaha.agama = selectedAgama;
//     usaha.pendidikan = selectedPendidikan;
//     usaha.status = selectedStatus;
//     usaha.alamat = alamatC.text;
//     usaha.keperluan = keperluanC.text;
//     usaha.wni = selectedWNI;
//     usaha.kelamin = selectedKelamin;
//     usaha.nik = int.tryParse(nikC.text);
//     usaha.kk = int.tryParse(kkC.text);
//     usaha.tanggallahir = selectedTanggal;
//     usaha.tempatlahir = tempatC.text;
//     if (usaha.id == null) {
//       usaha.waktu = DateTime.now();
//     }
//     try {
//       await usaha.save();
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
