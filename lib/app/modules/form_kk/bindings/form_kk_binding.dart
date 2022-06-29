import 'package:get/get.dart';

import '../controllers/form_kk_controller.dart';

class FormKkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormKkController>(
      () => FormKkController(),
    );
  }
}
