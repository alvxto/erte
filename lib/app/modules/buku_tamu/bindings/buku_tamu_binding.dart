import 'package:get/get.dart';

import '../controllers/buku_tamu_controller.dart';

class BukuTamuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BukuTamuController>(
      () => BukuTamuController(),
    );
  }
}
