// import 'package:erte/app/data/models/s_pernyataan.dart';
// import 'package:erte/app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:nb_utils/nb_utils.dart';
// import '../controllers/s_pernyataan_controller.dart';

// class SPernyataanView extends GetView<SPernyataanController> {
//   final GlobalKey<FormState> form = GlobalKey<FormState>();
//   Pernyataan pernyataan = Pernyataan();
//   @override
//   Widget build(BuildContext context) {
//     // controller.modelToController(pernyataan);
//     return Scaffold(
//       appBar: AppBar(
//           title: Text('Surat Pernyataan'),
//           leading: InkWell(
//           onTap: ()=> Get.back(),  
//           child: Icon(Icons.arrow_back, color: white,)),
//           // centerTitle: true,
//           // actions: [
//           //   IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.home))
//           // ],
//         ),
//         // endDrawer: Drawer(
//         //   backgroundColor: white,
//         //   child:
//         //       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         //     Expanded(
//         //       child: ListView(
//         //         padding: EdgeInsets.zero,
//         //         children: [
//         //           ListTile(
//         //             onTap: () => Get.toNamed(Routes.HOME),
//         //             title: Text(
//         //               "Home",
//         //             ),
//         //           ),
//         //           ListTile(
//         //             onTap: () => Get.toNamed(Routes.S_PENGANTAR),
//         //             title: Text(
//         //               "Surat Pengantar",
//         //             ),
//         //           ),
//         //           ListTile(
//         //             onTap: () => Get.toNamed(Routes.FORM_KTP),
//         //             title: Text(
//         //               "Surat KTP",
//         //             ),
//         //           ),
//         //           ListTile(
//         //             onTap: () => Get.toNamed(Routes.S_PERNYATAAN),
//         //             title: Text(
//         //               "Surat Pernyataan",
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     )
//         //   ]),
//         // ),
//       body: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Form(
//             key: form,
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 AppTextField(
//                   textFieldType: TextFieldType.NAME,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text("Nama")),
//                   controller: controller.namaC,
//                 ),
//                 SizedBox(height: 15,),
//                 FormField<String>(
//                   validator: (value) => controller.selectedKelamin.isNotEmpty
//                       ? null
//                       : "This field is required",
//                   builder: (kelamin) => Obx(
//                     () => ListTile(
//                       visualDensity: VisualDensity.compact,
//                       title: Text("Jenis Kelamin"),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       subtitle: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: RadioListTile<String>(
//                                   value: "Laki-Laki",
//                                   groupValue: controller.selectedKelamin,
//                                   onChanged: (value) =>
//                                       controller.selectedKelamin = value ?? '',
//                                   title: Text("Laki-Laki"),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: RadioListTile<String>(
//                                   value: "Perempuan",
//                                   groupValue: controller.selectedKelamin,
//                                   onChanged: (value) =>
//                                       controller.selectedKelamin = value ?? '',
//                                   title: Text(
//                                     "Perempuan",
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           if (kelamin.hasError)
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 kelamin.errorText!,
//                                 style:
//                                     TextStyle(color: Colors.red, fontSize: 12),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15,),
//                 AppTextField(
//                   textFieldType: TextFieldType.NAME,
//                   textInputAction: TextInputAction.next,
//                   controller: controller.tempatC,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text("Tempat Lahir")),
//                 ),
//                 SizedBox(height: 15,),
//                 ListTile(
//                   leading: Container(
//                       width: 24,
//                       alignment: Alignment.centerLeft,
//                       child: Icon(
//                         Icons.calendar_today,
//                       )),
//                   onTap: () async => await controller.tanggalLahir(context),
//                   title: Text(
//                     "Tanggal Lahir",
//                     style: TextStyle(fontSize: 12),
//                   ),
//                   subtitle: Obx(() => Text(controller.selectedTanggal is DateTime
//                                         ? DateFormat("EEE, dd MMM y")
//                                             .format(controller.selectedTanggal!)
//                                         : '--')),
//                 ),
//                 Divider(
//                   color: white,
//                   height: 0,
//                   thickness: 1,
//                 ),
//                 SizedBox(height: 15,),
//                 AppTextField(
//                   textFieldType: TextFieldType.PHONE,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text("NIK")),
//                   controller: controller.ktpC,
//                 ),
//                 SizedBox(height: 15,),
//                 AppTextField(
//                   textFieldType: TextFieldType.NAME,
//                   textInputAction: TextInputAction.next,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     label: Text("Alamat")),
//                   controller: controller.alamatC,
//                 ),
//                 SizedBox(height: 15,),
//                 AppTextField(
//                     textFieldType: TextFieldType.NAME,
//                     textInputAction: TextInputAction.done,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       label: Text("Keperluan")),
//                     controller: controller.keperluanC),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Obx(
//                   () => Container(
//                     width: Get.width,
//                     child: FloatingActionButton.extended(
//                         onPressed: controller.isSaving
//                             ? null
//                             : () {
//                                 if (form.currentState!.validate()) {
//                                   controller.store(pernyataan);
//                                 }
//                               },
//                         label: controller.isSaving
//                             ? Text("Loading...")
//                             : Text("Kirim")),
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         )
//     );
//   }
// }
