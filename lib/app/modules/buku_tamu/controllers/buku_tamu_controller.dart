import 'package:erte/app/data/models/absen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BukuTamuController extends GetxController {
  late TextEditingController namaC;
  late TextEditingController emailC;
  late TextEditingController alamatC;
  
  RxList<Absen> rxAbsens = RxList<Absen>();
  List<Absen> get absens => rxAbsens.value;
  set absens(List<Absen> value) => rxAbsens.value = value;

  modelToController(Absen absen) {
    namaC.text = absen.nama ?? '';
    emailC.text = absen.email ?? '';
    alamatC.text = absen.alamat ?? '';
  }

  @override
  void onInit() {
    namaC = TextEditingController();
    emailC = TextEditingController();
    alamatC = TextEditingController();
    rxAbsens.bindStream(Absen().streamList());
    super.onInit();
  }
}
