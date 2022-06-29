import 'package:get/get.dart';

import '../controllers/admin_surat_controller.dart';

class AdminSuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSuratController>(
      () => AdminSuratController(),
    );
  }
}
