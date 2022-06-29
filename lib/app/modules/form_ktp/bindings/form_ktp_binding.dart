import 'package:get/get.dart';

import '../controllers/form_ktp_controller.dart';

class FormKtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormKtpController>(
      () => FormKtpController(),
    );
  }
}
