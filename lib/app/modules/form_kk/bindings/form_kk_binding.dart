import 'package:erte/app/modules/form_kk/controllers/form_anggota_controller.dart';
import 'package:get/get.dart';

import '../controllers/form_kk_controller.dart';

class FormKkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormKkController>(
      () => FormKkController(),
    );
    Get.lazyPut<FormAnggotaController>(
      () => FormAnggotaController(),
    );
  }
}
