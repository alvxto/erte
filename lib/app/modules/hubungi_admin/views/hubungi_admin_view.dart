import 'package:flutter/material.dart';
import 'package:erte/app/const/widget.dart';
import 'package:get/get.dart';
import '../controllers/hubungi_admin_controller.dart';

class HubungiAdminView extends GetView<HubungiAdminController> {
  const HubungiAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRT(title: "HubungiAdminView"),
      body: Center(
        child: Text(
          'HubungiAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
