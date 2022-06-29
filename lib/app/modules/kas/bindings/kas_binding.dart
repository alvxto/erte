import 'package:get/get.dart';

import '../controllers/kas_controller.dart';

class KasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KasController>(
      () => KasController(),
    );
  }
}
