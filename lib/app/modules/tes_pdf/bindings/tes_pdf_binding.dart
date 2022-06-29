import 'package:get/get.dart';

import '../controllers/tes_pdf_controller.dart';

class TesPdfBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TesPdfController>(
      () => TesPdfController(),
    );
  }
}
