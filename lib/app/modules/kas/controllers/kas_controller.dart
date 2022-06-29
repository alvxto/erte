import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/kas.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class KasController extends GetxController {
  late TextEditingController deskripsiC;
  late TextEditingController uangC;

  RxList<Kas> rxKas = RxList<Kas>();
  List<Kas> get kass => rxKas.value;
  set kass(List<Kas> value) => rxKas.value = value;

  modelToController(Kas kas) {
    uangC.text = kas.uang ?? '';
    deskripsiC.text = kas.deskripsi ?? '';
    selectedKategori = kas.kategori;
  }

  Future delete(Kas kas) async {
    if (kas.id == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Gagal Menghapus",
        onConfirm: () => Get.back(),
        textConfirm: "Oke",
        buttonColor: primary,
        confirmTextColor: white,
        cancelTextColor: primary,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
      return Future.value(null);
    }
    try {
      Get.defaultDialog(
        onConfirm: () async {
          try {
            await kas.delete();
            Get.back();
            Get.back();
          } catch (e) {
            print(e);
          }
        },
        onCancel: () {
          Get.back();
          Get.back();
        },
        textConfirm: "Iya",
        textCancel: "Tidak",
        title: "Hapus",
        middleText: "Anda Yakin Ingin Menghapus?",
        buttonColor: primary,
        confirmTextColor: white,
        cancelTextColor: primary,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    } on Exception catch (e) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Gagal Menghapus",
        onConfirm: () => Get.back(),
        textConfirm: "Oke",
        buttonColor: primary,
        confirmTextColor: white,
        cancelTextColor: primary,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary),
      );
    }
  }

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  List<String> listKategori = [
    "Pemasukan",
    "Pengeluaran",
  ];
  String? selectedKategori;

  Future store(Kas kas) async {
    isSaving = true;
    kas.kategori = selectedKategori;
    kas.uang = uangC.text;
    kas.deskripsi = deskripsiC.text;
    if (kas.id == null) {
      kas.waktu = DateTime.now();
    }
    try {
      await kas.save();
      Get.defaultDialog(
          title: "Berhasil",
          textConfirm: "Oke",
          onConfirm: () {
            deskripsiC.clear();
            uangC.clear();
            Get.back();
            Get.back();
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


  @override
  void onInit() {
    rxKas.bindStream(Kas().streamList());
    deskripsiC = TextEditingController();
    uangC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    deskripsiC.clear();
    selectedKategori = '';
    uangC.clear();
    super.onClose();
  }
}
