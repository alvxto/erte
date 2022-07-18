import 'package:dropdown_search/dropdown_search.dart';
import 'package:erte/app/const/color.dart';
import 'package:erte/app/const/image.dart';
import 'package:erte/app/const/widget.dart';
import 'package:erte/app/data/models/kas.dart';
import 'package:erte/app/modules/auth/controllers/auth_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
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
      backgroundColor: background,
      appBar: AppBarRT(title: "Kas RT"),
      body: Obx(
        () => authC.user.role == "Admin"
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: form,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  "Nama",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              AppTextField(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  textFieldType: TextFieldType.NAME,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    fillColor: Color(0xFFD6D7FD),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  controller: controller.namaC),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  "Kategori",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DropdownSearch<String>(
                                items: controller.listKategori,
                                onChanged: (value) =>
                                    controller.selectedKategori = value,
                                mode: Mode.MENU,
                                dropdownSearchDecoration: InputDecoration(
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: EdgeInsets.only(left: 10),
                                ),
                                selectedItem: controller.selectedKategori,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  "Jumlah",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              AppTextField(
                                textStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                textFieldType: TextFieldType.PHONE,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  prefixText: "RP. ",
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Color(0xFFD6D7FD),
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                controller: controller.uangC,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                                title: Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              AppTextField(
                                  maxLines: 50,
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  textFieldType: TextFieldType.NAME,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    fillColor: Color(0xFFD6D7FD),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  controller: controller.deskripsiC),
                              SizedBox(
                                height: 50,
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: controller.isSaving
                                      ? null
                                      : () {
                                          if (form.currentState!.validate()) {
                                            controller.store(kas);
                                          }
                                        },
                                  child: Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          accent,
                                          dark,
                                        ],
                                      ),
                                    ),
                                    child: controller.isSaving
                                        ? Center(
                                            child: Text(
                                              "Loading...",
                                              style: TextStyle(color: white),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              "KIRIM",
                                              style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              // Obx(
                              //   () => Container(
                              //     width: Get.width,
                              //     child: FloatingActionButton.extended(
                              //       heroTag: null,
                              //       onPressed: controller.isSaving
                              //           ? null
                              //           : () {
                              //               if (form.currentState!.validate()) {
                              //                 controller.store(kas);
                              //               }
                              //             },
                              //       label: controller.isSaving
                              //           ? Text("Loading...")
                              //           : Text("Kirim"),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 120,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: dark,
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                  // gradient: LinearGradient(
                                  //   begin: Alignment.topLeft,
                                  //   end: Alignment.bottomRight,
                                  //   colors: <Color>[
                                  //     primary,
                                  //     secondary,
                                  //   ],
                                  // ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Kas RT",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primary,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Kas , yaitu sejumlah uang yang dikuasai oleh RT/RW yang dari iuran warga  dana kolektif, donatur, hibah, dan sebagainya untuk kepentingan kegiatan RT /RW, baik yang disimpan oleh bendahara atau lembaga keuangan.",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                        width: double.infinity,
                        // padding: EdgeInsets.symmetric(horizontal: 15),
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
              ),
      ),
    );
  }
}

class KasCard extends GetView<KasController> {
  KasCard({required this.kas});
  final authC = Get.find<AuthController>();
  Kas kas;
  @override
  Widget build(BuildContext context) {
    controller.modelToController(kas);
    return InkWell(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                backgroundColor: white,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Icon(Icons.close, size: 25),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "${kas.nama} (${kas.kategori})",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "${kas.deskripsi}",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            kas.kategori == "Pemasukan"
                                ? Container(
                                    child: Image(
                                      image: AssetImage("images/down.png"),
                                      height: 15,
                                      width: 15,
                                    ),
                                  )
                                : Container(),
                            kas.kategori == "Pengeluaran"
                                ? Container(
                                    child: Image(
                                      image: AssetImage("images/up.png"),
                                      height: 15,
                                      width: 15,
                                    ),
                                  )
                                : Container(),
                            SizedBox(width: 5),
                            Text(
                              "Rp. ${kas.uang}",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${DateFormat.yMMMEd("id").format(kas.waktu!)}",
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "${DateFormat.Hm("id").format(kas.waktu!)}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 250,
          height: 110,
          // margin: EdgeInsets.all(5),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/kas_user.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        "${kas.nama} (${kas.kategori})",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          kas.kategori == "Pemasukan"
                              ? Container(
                                  child: Image(
                                    image: AssetImage("images/down.png"),
                                    height: 15,
                                    width: 15,
                                  ),
                                )
                              : Container(),
                          kas.kategori == "Pengeluaran"
                              ? Container(
                                  child: Image(
                                    image: AssetImage("images/up.png"),
                                    height: 15,
                                    width: 15,
                                  ),
                                )
                              : Container(),
                          //  Container(
                          //   child: kas.
                          //   ? Icon(
                          //     Icons.keyboard_arrow_up,
                          //     color: Colors.red,
                          //   ),
                          // )
                          // : Text(''),
                          SizedBox(width: 5),
                          Text(
                            "Rp. ${kas.uang}",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${DateFormat.yMMMEd("id").format(kas.waktu!)}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "${DateFormat.Hm("id").format(kas.waktu!)}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: white,
            boxShadow: [
              BoxShadow(
                color: dark,
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(0, 4),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}

// class KasAdmin extends GetView<KasController> {
//   KasAdmin({required this.kas});
//   final authC = Get.find<AuthController>();
//   Kas kas;
//   @override
//   Widget build(BuildContext context) {
//     controller.modelToController(kas);
//     return InkWell(
//       onTap: () async {
//         await showModalBottomSheet(
//           context: context,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//           builder: (context) => Container(
//             height: 130,
//             child: Column(
//               children: [
//                 ListTile(
//                     title: Text(
//                       "Edit",
//                       style: TextStyle(color: primary),
//                     ),
//                     leading: Icon(
//                       Icons.edit,
//                       color: primary,
//                     ),
//                     onTap: () => Get.toNamed(Routes.KAS, arguments: kas)),
//                 ListTile(
//                     title: Text(
//                       "Delete",
//                       style: TextStyle(color: primary),
//                     ),
//                     leading: Icon(
//                       Icons.delete,
//                       color: primary,
//                     ),
//                     onTap: () => controller.delete(kas)),
//               ],
//             ),
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(10),
//         width: 250,
//         height: 110,
//         margin: EdgeInsets.all(10),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 80,
//               width: 100,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                       image: AssetImage("images/kas.png"),
//                       fit: BoxFit.fitHeight)),
//             ),
//             SizedBox(
//               width: 15,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       "${kas.deskripsi} (${kas.kategori})",
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       "${kas.uang}",
//                       style: TextStyle(fontSize: 10),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "${DateFormat.yMMMEd('id').format(kas.waktu!)}",
//                     style: TextStyle(fontSize: 15),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         decoration: BoxDecoration(
//           color: white,
//           boxShadow: [
//             BoxShadow(
//               color: dark,
//               spreadRadius: 0,
//               blurRadius: 4,
//               offset: Offset(0, 4),
//             )
//           ],
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }
