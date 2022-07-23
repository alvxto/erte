import 'package:get/get.dart';

import '../controllers/admin_surat_controller3.dart';
import '../controllers/admin_surat_controller.dart';
import '../controllers/admin_surat_controller2.dart';
import '../controllers/admin_surat_controller4.dart';

class AdminSuratBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminSuratController>(
      () => AdminSuratController(),
    );
    Get.lazyPut<AdminSuratController2>(
      () => AdminSuratController2(),
    );
    Get.lazyPut<AdminSuratController3>(
      () => AdminSuratController3(),
    );
    Get.lazyPut<AdminSuratController4>(
      () => AdminSuratController4(),
    );
  }
}
