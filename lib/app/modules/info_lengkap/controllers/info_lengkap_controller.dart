import 'package:erte/app/data/models/informasi.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InfoLengkapController extends GetxController {
  RxList<Informasi> rxInfos = RxList<Informasi>();
  List<Informasi> get infos => rxInfos.value;
  set infos(List<Informasi> value) => rxInfos.value = value;
  var imagePath = ''.obs;
  late TextEditingController judulC;
  late TextEditingController deskripsiC;

  modelToController(Informasi info) {
    judulC.text = info.judul ?? '';
    deskripsiC.text = info.deskripsi ?? '';
  }

  @override
  void onInit() {
    rxInfos.bindStream(Informasi().streamList());
    judulC = TextEditingController();
    deskripsiC = TextEditingController();
    super.onInit();
  }
}
