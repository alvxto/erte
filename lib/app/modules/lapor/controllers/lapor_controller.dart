import 'dart:io';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/lapor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class LaporController extends GetxController {
  late File image;
  var imagePath = ''.obs;
  late TextEditingController judulC;
  late TextEditingController deskripsiC;
  late TextEditingController namaC;
  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  RxList<Lapor> rxLapors = RxList<Lapor>();
  List<Lapor> get lapors => rxLapors.value;
  set lapors(List<Lapor> value) => rxLapors.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(Lapor lapor) async {
    isSaving = true;
    lapor.nama = namaC.text;
    lapor.judul = judulC.text;
    lapor.deskripsi = deskripsiC.text;
    if (lapor.id == null) {
      lapor.waktu = DateTime.now();
    }
    try {
      await lapor.save(
          file: imagePath.value == '' ? null : File(imagePath.value));
      Get.defaultDialog(
          title: "Berhasil",
          textConfirm: "Oke",
          onConfirm: () {
            namaC.clear();
            deskripsiC.clear();
            judulC.clear();
            Get.back();
            Get.back();
            imagePath.value = '';
          },
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  modelToController(Lapor lapor) {
    namaC.text = lapor.nama ?? '';
    judulC.text = lapor.judul ?? '';
    deskripsiC.text = lapor.deskripsi ?? '';
  }

  @override
  void onInit() {
    namaC = TextEditingController();
    judulC = TextEditingController();
    deskripsiC = TextEditingController();
    rxLapors.bindStream(Lapor().streamList());
    super.onInit();
  }

  @override
  void onClose() {
    namaC.clear();
    deskripsiC.clear();
    judulC.clear();
    super.onClose();
    imagePath.value = '';
  }
}
