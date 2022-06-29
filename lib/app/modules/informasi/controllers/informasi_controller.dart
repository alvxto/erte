import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/informasi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class InformasiController extends GetxController {
  late File image;
  var imagePath = ''.obs;
  late TextEditingController judulC;
  late TextEditingController deskripsiC;
  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future store(Informasi info) async {
    isSaving = true;
    info.judul = judulC.text;
    info.deskripsi = deskripsiC.text;
    if (info.id == null) {
      info.waktu = DateTime.now();
    }
    try {
      await info.save(
          file: imagePath.value == '' ? null : File(imagePath.value));
      Get.defaultDialog(
          title: "Berhasil",
          textConfirm: "Oke",
          onConfirm: () {
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
          middleTextStyle: TextStyle(color: primary)
          );
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  modelToController(Informasi info) {
    judulC.text = info.judul ?? '';
    deskripsiC.text = info.deskripsi ?? '';
  }

  @override
  void onInit() {
    judulC = TextEditingController();
    deskripsiC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    deskripsiC.clear();
    judulC.clear();
    super.onClose();
    imagePath.value = '';
  }
}
