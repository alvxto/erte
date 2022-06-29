import 'package:get/get.dart';

import '../controllers/informasi_controller.dart';

class InformasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformasiController>(
      () => InformasiController(),
    );
  }
}
