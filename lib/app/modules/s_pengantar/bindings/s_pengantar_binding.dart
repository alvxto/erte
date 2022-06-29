import 'package:get/get.dart';

import '../controllers/s_pengantar_controller.dart';

class SPengantarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SPengantarController>(
      () => SPengantarController(),
    );
  }
}
