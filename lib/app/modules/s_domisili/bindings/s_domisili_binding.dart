import 'package:get/get.dart';

import '../controllers/s_domisili_controller.dart';

class SDomisiliBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SDomisiliController>(
      () => SDomisiliController(),
    );
  }
}
