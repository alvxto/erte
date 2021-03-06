import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/lapor.dart';
import 'package:erte/app/modules/lapor/controllers/lapor_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRT(title: "RiwayatView"),
      body: Center(
        child: Text(
          'RiwayatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
