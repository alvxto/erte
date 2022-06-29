import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tes_pdf_controller.dart';

class TesPdfView extends GetView<TesPdfController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TesPdfView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: controller.produk.length,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            child: Text("${controller.produk[index]["id"]}"),
          ),
          title: Text("${controller.produk[index]["nama"]}"),
          subtitle: Text("${controller.produk[index]["desc"]}"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          controller.getPDF();
        },
        child: Icon(Icons.note),
      ),
    );
  }
}
