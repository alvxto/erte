import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pengaturan_controller.dart';

class PengaturanView extends GetView<PengaturanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PengaturanView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PengaturanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
