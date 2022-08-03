import 'package:erte/app/const/color.dart';
import 'package:erte/app/modules/form_kk/controllers/form_anggota_controller.dart';
import 'package:erte/app/modules/form_kk/views/form_isiAnggota.dart';
import 'package:erte/app/modules/form_kk/views/form_pengisian.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../data/models/form_kk.dart';
import '../../../data/models/s_pengantar.dart';
import '../controllers/form_kk_controller.dart';

class FormKkView extends GetView<FormKkController> {
  // FormKkController controller = Get.find<FormKkController>();

  // KK kk = KK(listAnggota: [Anggota()]);
  // Absen absen = Absen();
  // Pengantar pengantar = Pengantar();
  int currentStep = 0;
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
              Color(0xFF696EFF),
              Color(0xFF000DFF),
            ]))),
        title: Text('Form KK'),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 25),
              visualDensity: VisualDensity.compact,
              title: Text(
                "Kepala Keluarga",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormPengisianKK(),
                ),
              ),
              child: Container(
                height: 110,
                width: 300,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: dark,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    "Data Kepala Keluarga",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            ListTile(
              contentPadding: EdgeInsets.only(left: 25),
              visualDensity: VisualDensity.compact,
              title: Text(
                "Anggota Keluarga",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Obx(
              () => controller.anggota.length < 1
                  ? Center(
                      child: Text(
                        "Kosong",
                        style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: controller.anggota.length,
                      itemBuilder: (context, index) => DataCard(
                        anggota: controller.anggota[index],
                      ),
                    ),
            ),
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormIsiAnggota(),
                ),
              ),
              child: Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: dark,
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30),
                    Text(
                      "Tambah Anggota",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataCard extends GetView<FormKkController> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  DataCard({required this.anggota});
  Anggota anggota;

  @override
  Widget build(BuildContext context) {
    // controller.modelcontroller(anggota);
    return InkWell(
      onTap: () => Get.toNamed(Routes.FORM_KK, arguments: anggota),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 110,
          width: 300,
          decoration: BoxDecoration(
            color: grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
