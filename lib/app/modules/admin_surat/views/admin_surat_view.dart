import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_surat_controller.dart';

class AdminSuratView extends GetView<AdminSuratController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdminSuratView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'AdminSuratView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
