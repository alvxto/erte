import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/kas.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/kas_controller.dart';

class KasView extends GetView<KasController> {
  final authC = Get.find<AuthController>();
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  Kas kas = Get.arguments ?? Kas();

  @override
  Widget build(BuildContext context) {
    controller.modelToController(kas);
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () => authC.user.role == "Admin"
                  ? Get.offAndToNamed(Routes.ADMIN)
                  : Get.offAndToNamed(Routes.HOME),
              child: Icon(
                Icons.arrow_back,
                color: white,
              )),
          title: Text('Kas RT'),
          // centerTitle: true,
        ),
        body: Obx(() => authC.user.role == "Admin"
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Form(
                        key: form,
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            DropdownSearch<String>(
                              items: controller.listKategori,
                              onChanged: (value) =>
                                  controller.selectedKategori = value,
                              mode: Mode.MENU,
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Kategori",
                                contentPadding: EdgeInsets.zero,
                              ),
                              selectedItem: controller.selectedKategori,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AppTextField(
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Jumlah Rp.")),
                                controller: controller.uangC),
                            SizedBox(
                              height: 15,
                            ),
                            AppTextField(
                                textFieldType: TextFieldType.NAME,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Deskripsi")),
                                controller: controller.deskripsiC),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(
                              () => Container(
                                width: Get.width,
                                child: FloatingActionButton.extended(
                                    heroTag: null,
                                    onPressed: controller.isSaving
                                        ? null
                                        : () {
                                            if (form.currentState!.validate()) {
                                              controller.store(kas);
                                            }
                                          },
                                    label: controller.isSaving
                                        ? Text("Loading...")
                                        : Text("Kirim")),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      // Text(
                      //   "Kas RT",
                      //   style: TextStyle(fontSize: 30),
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Obx(
                      //   () => controller.kass.length < 1
                      //       ? Center(
                      //           child: Text(
                      //             "Kosong",
                      //             style: TextStyle(
                      //                 color: primary,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 30),
                      //           ),
                      //         )
                      //       : Container(
                      //           height: Get.height,
                      //           width: Get.width,
                      //           padding: EdgeInsets.symmetric(horizontal: 15),
                      //           child: SingleChildScrollView(
                      //             scrollDirection: Axis.vertical,
                      //             child: ListView.builder(
                      //                 scrollDirection: Axis.vertical,
                      //                 shrinkWrap: true,
                      //                 physics: ScrollPhysics(),
                      //                 itemCount: controller.kass.length,
                      //                 itemBuilder: (context, index) => KasAdmin(
                      //                     kas: controller.kass[index])),
                      //           ),
                      //         ),
                      // )
                    ],
                  ),
                ),
              )
            : Obx(
                () => controller.kass.length < 1
                    ? Center(
                        child: Text(
                          "Kosong",
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      )
                    : Container(
                        height: Get.height,
                        width: Get.width,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: controller.kass.length,
                              itemBuilder: (context, index) =>
                                  KasCard(kas: controller.kass[index])),
                        ),
                      ),
              )));
  }
}

class KasCard extends GetView<KasController> {
  KasCard({required this.kas});
  final authC = Get.find<AuthController>();
  Kas kas;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(kas);
    return Container(
      padding: EdgeInsets.all(10),
      width: 250,
      height: 110,
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage("images/kas.png"),
                      fit: BoxFit.fitHeight)),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "${kas.deskripsi} (${kas.kategori})",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    "Rp. ${kas.uang}",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${DateFormat.yMMMEd().format(kas.waktu!)}",
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            color: dark,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class KasAdmin extends GetView<KasController> {
  KasAdmin({required this.kas});
  final authC = Get.find<AuthController>();
  Kas kas;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(kas);
    return InkWell(
      onTap: () async {
        await showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            builder: (context) => Container(
                height: 130,
                child: Column(
                  children: [
                    ListTile(
                        title: Text(
                          "Edit",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.edit,
                          color: primary,
                        ),
                        onTap: () => Get.toNamed(Routes.KAS, arguments: kas)),
                    ListTile(
                        title: Text(
                          "Delete",
                          style: TextStyle(color: primary),
                        ),
                        leading: Icon(
                          Icons.delete,
                          color: primary,
                        ),
                        onTap: () => controller.delete(kas)),
                  ],
                )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 250,
        height: 110,
        margin: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("images/kas.png"),
                        fit: BoxFit.fitHeight)),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${kas.deskripsi} (${kas.kategori})",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      "${kas.uang}",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${DateFormat.yMMMEd().format(kas.waktu!)}",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: white,
          boxShadow: [
            BoxShadow(
              color: dark,
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
