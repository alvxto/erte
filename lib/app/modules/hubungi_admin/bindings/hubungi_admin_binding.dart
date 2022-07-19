import 'package:get/get.dart';

import '../controllers/hubungi_admin_controller.dart';

class HubungiAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HubungiAdminController>(
      () => HubungiAdminController(),
    );
  }
}
