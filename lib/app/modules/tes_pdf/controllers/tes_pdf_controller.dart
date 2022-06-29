import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TesPdfController extends GetxController {
  var produk = List.generate(
      5,
      (index) => {
            "id": index + 1,
            "nama": "Produk ke- ${index + 1}",
            "desc": DateTime.now(),
          });

  void getPDF() async {
    //dokumen
    final pdf = pw.Document();

    //page
    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.letter,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text("Hello World"),
            ); // Center
          }),
    );

    //save
    Uint8List bytes = await pdf.save();

    //file kosong
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydoc.pdf');

    //timpa file kosong dengan pdf
    await file.writeAsBytes(bytes);

    //open file
    await OpenFile.open(file.path);
  }
}
