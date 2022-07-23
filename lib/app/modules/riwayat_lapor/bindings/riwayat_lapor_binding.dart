import 'package:get/get.dart';

import '../controllers/riwayat_lapor_controller.dart';

class RiwayatLaporBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatLaporController>(
      () => RiwayatLaporController(),
    );
  }
}
