import 'package:get/get.dart';

import '../controllers/info_apk_controller.dart';

class InfoApkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoApkController>(
      () => InfoApkController(),
    );
  }
}
