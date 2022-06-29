import 'package:get/get.dart';

import '../controllers/info_lengkap_controller.dart';

class InfoLengkapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoLengkapController>(
      () => InfoLengkapController(),
    );
  }
}
