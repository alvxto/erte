import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_kk.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class FormKkController extends GetxController {
  late TextEditingController namalengkapC;
  late TextEditingController namalengkap2C;
  late TextEditingController namalengkap3C;
  late TextEditingController namalengkap4C;
  late TextEditingController namalengkap5C;
  late TextEditingController namalengkap6C;
  late TextEditingController namalengkap7C;
  late TextEditingController namakepalaC;
  late TextEditingController namasponsorC;
  late TextEditingController namasponsor2C;
  late TextEditingController namasponsor3C;
  late TextEditingController namasponsor4C;
  late TextEditingController namasponsor5C;
  late TextEditingController namasponsor6C;
  late TextEditingController namasponsor7C;
  late TextEditingController namaayahC;
  late TextEditingController namaayah2C;
  late TextEditingController namaayah3C;
  late TextEditingController namaayah4C;
  late TextEditingController namaayah5C;
  late TextEditingController namaayah6C;
  late TextEditingController namaayah7C;
  late TextEditingController namaibuC;
  late TextEditingController namaibu2C;
  late TextEditingController namaibu3C;
  late TextEditingController namaibu4C;
  late TextEditingController namaibu5C;
  late TextEditingController namaibu6C;
  late TextEditingController namaibu7C;
  late TextEditingController kodeposC;
  late TextEditingController jumkeluargaC;
  late TextEditingController teleponC;
  late TextEditingController gelardepanC;
  late TextEditingController gelardepan2C;
  late TextEditingController gelardepan3C;
  late TextEditingController gelardepan4C;
  late TextEditingController gelardepan5C;
  late TextEditingController gelardepan6C;
  late TextEditingController gelardepan7C;
  late TextEditingController gelarbelakangC;
  late TextEditingController gelarbelakang2C;
  late TextEditingController gelarbelakang3C;
  late TextEditingController gelarbelakang4C;
  late TextEditingController gelarbelakang5C;
  late TextEditingController gelarbelakang6C;
  late TextEditingController gelarbelakang7C;
  late TextEditingController nopasporC;
  late TextEditingController nopaspor2C;
  late TextEditingController nopaspor3C;
  late TextEditingController nopaspor4C;
  late TextEditingController nopaspor5C;
  late TextEditingController nopaspor6C;
  late TextEditingController nopaspor7C;
  late TextEditingController tempatC;
  late TextEditingController tempat2C;
  late TextEditingController tempat3C;
  late TextEditingController tempat4C;
  late TextEditingController tempat5C;
  late TextEditingController tempat6C;
  late TextEditingController tempat7C;
  late TextEditingController pekerjaanC;
  late TextEditingController pekerjaan2C;
  late TextEditingController pekerjaan3C;
  late TextEditingController pekerjaan4C;
  late TextEditingController pekerjaan5C;
  late TextEditingController pekerjaan6C;
  late TextEditingController pekerjaan7C;
  late TextEditingController nikibuC;
  late TextEditingController nikibu2C;
  late TextEditingController nikibu3C;
  late TextEditingController nikibu4C;
  late TextEditingController nikibu5C;
  late TextEditingController nikibu6C;
  late TextEditingController nikibu7C;
  late TextEditingController nikayahC;
  late TextEditingController nikayah2C;
  late TextEditingController nikayah3C;
  late TextEditingController nikayah4C;
  late TextEditingController nikayah5C;
  late TextEditingController nikayah6C;
  late TextEditingController nikayah7C;
  late TextEditingController noitasC;
  late TextEditingController noitas2C;
  late TextEditingController noitas3C;
  late TextEditingController noitas4C;
  late TextEditingController noitas5C;
  late TextEditingController noitas6C;
  late TextEditingController noitas7C;
  late TextEditingController tempatItasC;
  late TextEditingController tempatItas2C;
  late TextEditingController tempatItas3C;
  late TextEditingController tempatItas4C;
  late TextEditingController tempatItas5C;
  late TextEditingController tempatItas6C;
  late TextEditingController tempatItas7C;
  late TextEditingController tempatPertamaC;
  late TextEditingController tempatPertama2C;
  late TextEditingController tempatPertama3C;
  late TextEditingController tempatPertama4C;
  late TextEditingController tempatPertama5C;
  late TextEditingController tempatPertama6C;
  late TextEditingController tempatPertama7C;
  late TextEditingController alamatC;
  late TextEditingController alamatsponsorC;
  late TextEditingController alamatsponsor2C;
  late TextEditingController alamatsponsor3C;
  late TextEditingController alamatsponsor4C;
  late TextEditingController alamatsponsor5C;
  late TextEditingController alamatsponsor6C;
  late TextEditingController alamatsponsor7C;
  late TextEditingController rtC;
  late TextEditingController rwC;
  late TextEditingController nowaliC;
  late TextEditingController nowali2C;
  late TextEditingController nowali3C;
  late TextEditingController nowali4C;
  late TextEditingController nowali5C;
  late TextEditingController nowali6C;
  late TextEditingController nowali7C;
  late TextEditingController noaktalahirC;
  late TextEditingController noaktalahir2C;
  late TextEditingController noaktalahir3C;
  late TextEditingController noaktalahir4C;
  late TextEditingController noaktalahir5C;
  late TextEditingController noaktalahir6C;
  late TextEditingController noaktalahir7C;
  late TextEditingController noaktakawinC;
  late TextEditingController noaktakawin2C;
  late TextEditingController noaktakawin3C;
  late TextEditingController noaktakawin4C;
  late TextEditingController noaktakawin5C;
  late TextEditingController noaktakawin6C;
  late TextEditingController noaktakawin7C;
  late TextEditingController noaktaceraiC;
  late TextEditingController noaktacerai2C;
  late TextEditingController noaktacerai3C;
  late TextEditingController noaktacerai4C;
  late TextEditingController noaktacerai5C;
  late TextEditingController noaktacerai6C;
  late TextEditingController noaktacerai7C;
  late TextEditingController orgagamaC;
  late TextEditingController orgagama2C;
  late TextEditingController orgagama3C;
  late TextEditingController orgagama4C;
  late TextEditingController orgagama5C;
  late TextEditingController orgagama6C;
  late TextEditingController orgagama7C;
  late TextEditingController kewarganegaraanC;
  late TextEditingController kewarganegaraan2C;
  late TextEditingController kewarganegaraan3C;
  late TextEditingController kewarganegaraan4C;
  late TextEditingController kewarganegaraan5C;
  late TextEditingController kewarganegaraan6C;
  late TextEditingController kewarganegaraan7C;
  late TextEditingController emailC;
  late TextEditingController nikC;
  late TextEditingController kkC;

  //Tanggal Lahir
  Rx<DateTime?> _selectedTanggallahir = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir => _selectedTanggallahir.value;
  set selectedTanggallahir(DateTime? value) =>
      _selectedTanggallahir.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggallahir = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir;
  }

  Rx<DateTime?> _selectedTanggallahir2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir2 => _selectedTanggallahir2.value;
  set selectedTanggallahir2(DateTime? value) =>
      _selectedTanggallahir2.value = value;

  tanggalLahir2(dynamic context) async {
    selectedTanggallahir2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir2;
  }

  Rx<DateTime?> _selectedTanggallahir3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir3 => _selectedTanggallahir3.value;
  set selectedTanggallahir3(DateTime? value) =>
      _selectedTanggallahir3.value = value;

  tanggalLahir3(dynamic context) async {
    selectedTanggallahir3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir3;
  }

  Rx<DateTime?> _selectedTanggallahir4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir4 => _selectedTanggallahir4.value;
  set selectedTanggallahir4(DateTime? value) =>
      _selectedTanggallahir4.value = value;

  tanggalLahir4(dynamic context) async {
    selectedTanggallahir4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir4;
  }

  Rx<DateTime?> _selectedTanggallahir5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir5 => _selectedTanggallahir5.value;
  set selectedTanggallahir5(DateTime? value) =>
      _selectedTanggallahir5.value = value;

  tanggalLahir5(dynamic context) async {
    selectedTanggallahir5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir5;
  }

  Rx<DateTime?> _selectedTanggallahir6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir6 => _selectedTanggallahir6.value;
  set selectedTanggallahir6(DateTime? value) =>
      _selectedTanggallahir6.value = value;

  tanggalLahir6(dynamic context) async {
    selectedTanggallahir6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir6;
  }

  Rx<DateTime?> _selectedTanggallahir7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggallahir7 => _selectedTanggallahir7.value;
  set selectedTanggallahir7(DateTime? value) =>
      _selectedTanggallahir7.value = value;

  tanggalLahir7(dynamic context) async {
    selectedTanggallahir7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggallahir7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggallahir7;
  }

  //Tanggal Itas
  Rx<DateTime?> _selectedTanggalItas = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas => _selectedTanggalItas.value;
  set selectedTanggalItas(DateTime? value) =>
      _selectedTanggalItas.value = value;

  tanggalItas(dynamic context) async {
    selectedTanggalItas = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas;
  }

  Rx<DateTime?> _selectedTanggalItas2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas2 => _selectedTanggalItas2.value;
  set selectedTanggalItas2(DateTime? value) =>
      _selectedTanggalItas2.value = value;

  tanggalItas2(dynamic context) async {
    selectedTanggalItas2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas2;
  }

  Rx<DateTime?> _selectedTanggalItas3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas3 => _selectedTanggalItas3.value;
  set selectedTanggalItas3(DateTime? value) =>
      _selectedTanggalItas3.value = value;

  tanggalItas3(dynamic context) async {
    selectedTanggalItas3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas3;
  }

  Rx<DateTime?> _selectedTanggalItas4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas4 => _selectedTanggalItas4.value;
  set selectedTanggalItas4(DateTime? value) =>
      _selectedTanggalItas4.value = value;

  tanggalItas4(dynamic context) async {
    selectedTanggalItas4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas4;
  }

  Rx<DateTime?> _selectedTanggalItas5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas5 => _selectedTanggalItas5.value;
  set selectedTanggalItas5(DateTime? value) =>
      _selectedTanggalItas5.value = value;

  tanggalItas5(dynamic context) async {
    selectedTanggalItas5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas5;
  }

  Rx<DateTime?> _selectedTanggalItas6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas6 => _selectedTanggalItas6.value;
  set selectedTanggalItas6(DateTime? value) =>
      _selectedTanggalItas6.value = value;

  tanggalItas6(dynamic context) async {
    selectedTanggalItas6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas6;
  }

  Rx<DateTime?> _selectedTanggalItas7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalItas7 => _selectedTanggalItas7.value;
  set selectedTanggalItas7(DateTime? value) =>
      _selectedTanggalItas7.value = value;

  tanggalItas7(dynamic context) async {
    selectedTanggalItas7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalItas7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalItas7;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas => _selectedTanggalTerbitItas.value;
  set selectedTanggalTerbitItas(DateTime? value) =>
      _selectedTanggalTerbitItas.value = value;

  tanggalTerbitItas(dynamic context) async {
    selectedTanggalTerbitItas = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas2 => _selectedTanggalTerbitItas2.value;
  set selectedTanggalTerbitItas2(DateTime? value) =>
      _selectedTanggalTerbitItas2.value = value;

  tanggalTerbitItas2(dynamic context) async {
    selectedTanggalTerbitItas2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas2;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas3 => _selectedTanggalTerbitItas3.value;
  set selectedTanggalTerbitItas3(DateTime? value) =>
      _selectedTanggalTerbitItas3.value = value;

  tanggalTerbitItas3(dynamic context) async {
    selectedTanggalTerbitItas3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas3;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas4 => _selectedTanggalTerbitItas4.value;
  set selectedTanggalTerbitItas4(DateTime? value) =>
      _selectedTanggalTerbitItas4.value = value;

  tanggalTerbitItas4(dynamic context) async {
    selectedTanggalTerbitItas4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas4;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas5 => _selectedTanggalTerbitItas5.value;
  set selectedTanggalTerbitItas5(DateTime? value) =>
      _selectedTanggalTerbitItas5.value = value;

  tanggalTerbitItas5(dynamic context) async {
    selectedTanggalTerbitItas5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas5;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas6 => _selectedTanggalTerbitItas6.value;
  set selectedTanggalTerbitItas6(DateTime? value) =>
      _selectedTanggalTerbitItas6.value = value;

  tanggalTerbitItas6(dynamic context) async {
    selectedTanggalTerbitItas6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas6;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalTerbitItas7 => _selectedTanggalTerbitItas7.value;
  set selectedTanggalTerbitItas7(DateTime? value) =>
      _selectedTanggalTerbitItas7.value = value;

  tanggalTerbitItas7(dynamic context) async {
    selectedTanggalTerbitItas7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalTerbitItas7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalTerbitItas7;
  }

  Rx<DateTime?> _selectedTanggalkawin = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin => _selectedTanggalkawin.value;
  set selectedTanggalkawin(DateTime? value) =>
      _selectedTanggalkawin.value = value;

  // Tanggal Kawin
  tanggalkawin(dynamic context) async {
    selectedTanggalkawin = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin;
  }

  Rx<DateTime?> _selectedTanggalkawin2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin2 => _selectedTanggalkawin2.value;
  set selectedTanggalkawin2(DateTime? value) =>
      _selectedTanggalkawin2.value = value;

  tanggalkawin2(dynamic context) async {
    selectedTanggalkawin2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin2;
  }

  Rx<DateTime?> _selectedTanggalkawin3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin3 => _selectedTanggalkawin3.value;
  set selectedTanggalkawin3(DateTime? value) =>
      _selectedTanggalkawin3.value = value;

  tanggalkawin3(dynamic context) async {
    selectedTanggalkawin3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin3;
  }

  Rx<DateTime?> _selectedTanggalkawin4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin4 => _selectedTanggalkawin4.value;
  set selectedTanggalkawin4(DateTime? value) =>
      _selectedTanggalkawin4.value = value;

  tanggalkawin4(dynamic context) async {
    selectedTanggalkawin4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin4;
  }

  Rx<DateTime?> _selectedTanggalkawin5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin5 => _selectedTanggalkawin5.value;
  set selectedTanggalkawin5(DateTime? value) =>
      _selectedTanggalkawin5.value = value;

  tanggalkawin5(dynamic context) async {
    selectedTanggalkawin5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin5;
  }

  Rx<DateTime?> _selectedTanggalkawin6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin6 => _selectedTanggalkawin6.value;
  set selectedTanggalkawin6(DateTime? value) =>
      _selectedTanggalkawin6.value = value;

  tanggalkawin6(dynamic context) async {
    selectedTanggalkawin6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin6;
  }

  Rx<DateTime?> _selectedTanggalkawin7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin7 => _selectedTanggalkawin7.value;
  set selectedTanggalkawin7(DateTime? value) =>
      _selectedTanggalkawin7.value = value;

  tanggalkawin7(dynamic context) async {
    selectedTanggalkawin7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalkawin7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalkawin7;
  }

  Rx<DateTime?> _selectedTanggalcerai = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai => _selectedTanggalcerai.value;
  set selectedTanggalcerai(DateTime? value) =>
      _selectedTanggalcerai.value = value;

  tanggalcerai(dynamic context) async {
    selectedTanggalcerai = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai;
  }

  Rx<DateTime?> _selectedTanggalcerai2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai2 => _selectedTanggalcerai2.value;
  set selectedTanggalcerai2(DateTime? value) =>
      _selectedTanggalcerai2.value = value;

  tanggalcerai2(dynamic context) async {
    selectedTanggalcerai2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai2;
  }

  Rx<DateTime?> _selectedTanggalcerai3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai3 => _selectedTanggalcerai3.value;
  set selectedTanggalcerai3(DateTime? value) =>
      _selectedTanggalcerai3.value = value;

  tanggalcerai3(dynamic context) async {
    selectedTanggalcerai3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai3;
  }

  Rx<DateTime?> _selectedTanggalcerai4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai4 => _selectedTanggalcerai4.value;
  set selectedTanggalcerai4(DateTime? value) =>
      _selectedTanggalcerai4.value = value;

  tanggalcerai4(dynamic context) async {
    selectedTanggalcerai4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai4;
  }

  Rx<DateTime?> _selectedTanggalcerai5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai5 => _selectedTanggalcerai5.value;
  set selectedTanggalcerai5(DateTime? value) =>
      _selectedTanggalcerai5.value = value;

  tanggalcerai5(dynamic context) async {
    selectedTanggalcerai5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai5;
  }

  Rx<DateTime?> _selectedTanggalcerai6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai6 => _selectedTanggalcerai6.value;
  set selectedTanggalcerai6(DateTime? value) =>
      _selectedTanggalcerai6.value = value;

  tanggalcerai6(dynamic context) async {
    selectedTanggalcerai6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai6;
  }

  Rx<DateTime?> _selectedTanggalcerai7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalcerai7 => _selectedTanggalcerai7.value;
  set selectedTanggalcerai7(DateTime? value) =>
      _selectedTanggalcerai7.value = value;

  tanggalcerai7(dynamic context) async {
    selectedTanggalcerai7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalcerai7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalcerai7;
  }

  Rx<DateTime?> _selectedTanggalpaspor = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor => _selectedTanggalpaspor.value;
  set selectedTanggalpaspor(DateTime? value) =>
      _selectedTanggalpaspor.value = value;

  tanggalPaspor(dynamic context) async {
    selectedTanggalpaspor = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor;
  }

  Rx<DateTime?> _selectedTanggalpaspor2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor2 => _selectedTanggalpaspor2.value;
  set selectedTanggalpaspor2(DateTime? value) =>
      _selectedTanggalpaspor2.value = value;

  tanggalPaspor2(dynamic context) async {
    selectedTanggalpaspor2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor2;
  }

  Rx<DateTime?> _selectedTanggalpaspor3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor3 => _selectedTanggalpaspor3.value;
  set selectedTanggalpaspor3(DateTime? value) =>
      _selectedTanggalpaspor3.value = value;

  tanggalPaspor3(dynamic context) async {
    selectedTanggalpaspor3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor3;
  }

  Rx<DateTime?> _selectedTanggalpaspor4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor4 => _selectedTanggalpaspor4.value;
  set selectedTanggalpaspor4(DateTime? value) =>
      _selectedTanggalpaspor4.value = value;

  tanggalPaspor4(dynamic context) async {
    selectedTanggalpaspor4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor4;
  }

  Rx<DateTime?> _selectedTanggalpaspor5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor5 => _selectedTanggalpaspor5.value;
  set selectedTanggalpaspor5(DateTime? value) =>
      _selectedTanggalpaspor5.value = value;

  tanggalPaspor5(dynamic context) async {
    selectedTanggalpaspor5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor5;
  }

  Rx<DateTime?> _selectedTanggalpaspor6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor6 => _selectedTanggalpaspor6.value;
  set selectedTanggalpaspor6(DateTime? value) =>
      _selectedTanggalpaspor6.value = value;

  tanggalPaspor6(dynamic context) async {
    selectedTanggalpaspor6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor6;
  }

  Rx<DateTime?> _selectedTanggalpaspor7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpaspor7 => _selectedTanggalpaspor7.value;
  set selectedTanggalpaspor7(DateTime? value) =>
      _selectedTanggalpaspor7.value = value;

  tanggalPaspor7(dynamic context) async {
    selectedTanggalpaspor7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpaspor7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpaspor7;
  }

  Rx<DateTime?> _selectedTanggalpertama = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama => _selectedTanggalpertama.value;
  set selectedTanggalpertama(DateTime? value) =>
      _selectedTanggalpertama.value = value;

  tanggalPertama(dynamic context) async {
    selectedTanggalpertama = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama;
  }

  Rx<DateTime?> _selectedTanggalpertama2 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama2 => _selectedTanggalpertama2.value;
  set selectedTanggalpertama2(DateTime? value) =>
      _selectedTanggalpertama2.value = value;

  tanggalPertama2(dynamic context) async {
    selectedTanggalpertama2 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama2 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama2;
  }

  Rx<DateTime?> _selectedTanggalpertama3 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama3 => _selectedTanggalpertama3.value;
  set selectedTanggalpertama3(DateTime? value) =>
      _selectedTanggalpertama3.value = value;

  tanggalPertama3(dynamic context) async {
    selectedTanggalpertama3 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama3 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama3;
  }

  Rx<DateTime?> _selectedTanggalpertama4 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama4 => _selectedTanggalpertama4.value;
  set selectedTanggalpertama4(DateTime? value) =>
      _selectedTanggalpertama4.value = value;

  tanggalPertama4(dynamic context) async {
    selectedTanggalpertama4 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama4 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama4;
  }

  Rx<DateTime?> _selectedTanggalpertama5 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama5 => _selectedTanggalpertama5.value;
  set selectedTanggalpertama5(DateTime? value) =>
      _selectedTanggalpertama5.value = value;

  tanggalPertama5(dynamic context) async {
    selectedTanggalpertama5 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama5 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama5;
  }

  Rx<DateTime?> _selectedTanggalpertama6 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama6 => _selectedTanggalpertama6.value;
  set selectedTanggalpertama6(DateTime? value) =>
      _selectedTanggalpertama6.value = value;

  tanggalPertama6(dynamic context) async {
    selectedTanggalpertama6 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama6 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama6;
  }

  Rx<DateTime?> _selectedTanggalpertama7 = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalpertama7 => _selectedTanggalpertama7.value;
  set selectedTanggalpertama7(DateTime? value) =>
      _selectedTanggalpertama7.value = value;

  tanggalPertama7(dynamic context) async {
    selectedTanggalpertama7 = await showDatePicker(
            locale: Locale('id', 'ID'),
            context: context,
            initialDate: selectedTanggalpertama7 ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2051)) ??
        selectedTanggalpertama7;
  }

  // Jenis Kelamin
  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  var _selectedKelamin2 = ''.obs;
  String get selectedKelamin2 => _selectedKelamin2.value;
  set selectedKelamin2(String value) => _selectedKelamin2.value = value;

  var _selectedKelamin3 = ''.obs;
  String get selectedKelamin3 => _selectedKelamin3.value;
  set selectedKelamin3(String value) => _selectedKelamin3.value = value;

  var _selectedKelamin4 = ''.obs;
  String get selectedKelamin4 => _selectedKelamin4.value;
  set selectedKelamin4(String value) => _selectedKelamin4.value = value;

  var _selectedKelamin5 = ''.obs;
  String get selectedKelamin5 => _selectedKelamin5.value;
  set selectedKelamin5(String value) => _selectedKelamin5.value = value;

  var _selectedKelamin6 = ''.obs;
  String get selectedKelamin6 => _selectedKelamin6.value;
  set selectedKelamin6(String value) => _selectedKelamin6.value = value;

  var _selectedKelamin7 = ''.obs;
  String get selectedKelamin7 => _selectedKelamin7.value;
  set selectedKelamin7(String value) => _selectedKelamin7.value = value;

  //Akta Lahir
  var _selectedAktalahir = ''.obs;
  String get selectedAktalahir => _selectedAktalahir.value;
  set selectedAktalahir(String value) => _selectedAktalahir.value = value;

  var _selectedAktalahir2 = ''.obs;
  String get selectedAktalahir2 => _selectedAktalahir2.value;
  set selectedAktalahir2(String value) => _selectedAktalahir2.value = value;

  var _selectedAktalahir3 = ''.obs;
  String get selectedAktalahir3 => _selectedAktalahir3.value;
  set selectedAktalahir3(String value) => _selectedAktalahir3.value = value;

  var _selectedAktalahir4 = ''.obs;
  String get selectedAktalahir4 => _selectedAktalahir4.value;
  set selectedAktalahir4(String value) => _selectedAktalahir4.value = value;

  var _selectedAktalahir5 = ''.obs;
  String get selectedAktalahir5 => _selectedAktalahir5.value;
  set selectedAktalahir5(String value) => _selectedAktalahir5.value = value;

  var _selectedAktalahir6 = ''.obs;
  String get selectedAktalahir6 => _selectedAktalahir6.value;
  set selectedAktalahir6(String value) => _selectedAktalahir6.value = value;

  var _selectedAktalahir7 = ''.obs;
  String get selectedAktalahir7 => _selectedAktalahir7.value;
  set selectedAktalahir7(String value) => _selectedAktalahir7.value = value;

  //Akta Kawin
  var _selectedAktakawin = ''.obs;
  String get selectedAktakawin => _selectedAktakawin.value;
  set selectedAktakawin(String value) => _selectedAktakawin.value = value;

  var _selectedAktakawin2 = ''.obs;
  String get selectedAktakawin2 => _selectedAktakawin2.value;
  set selectedAktakawin2(String value) => _selectedAktakawin2.value = value;

  var _selectedAktakawin3 = ''.obs;
  String get selectedAktakawin3 => _selectedAktakawin3.value;
  set selectedAktakawin3(String value) => _selectedAktakawin3.value = value;

  var _selectedAktakawin4 = ''.obs;
  String get selectedAktakawin4 => _selectedAktakawin4.value;
  set selectedAktakawin4(String value) => _selectedAktakawin4.value = value;

  var _selectedAktakawin5 = ''.obs;
  String get selectedAktakawin5 => _selectedAktakawin5.value;
  set selectedAktakawin5(String value) => _selectedAktakawin5.value = value;

  var _selectedAktakawin6 = ''.obs;
  String get selectedAktakawin6 => _selectedAktakawin6.value;
  set selectedAktakawin6(String value) => _selectedAktakawin6.value = value;

  var _selectedAktakawin7 = ''.obs;
  String get selectedAktakawin7 => _selectedAktakawin7.value;
  set selectedAktakawin7(String value) => _selectedAktakawin7.value = value;

  // Akta Cerai
  var _selectedAktacerai = ''.obs;
  String get selectedAktacerai => _selectedAktacerai.value;
  set selectedAktacerai(String value) => _selectedAktacerai.value = value;

  var _selectedAktacerai2 = ''.obs;
  String get selectedAktacerai2 => _selectedAktacerai2.value;
  set selectedAktacerai2(String value) => _selectedAktacerai2.value = value;

  var _selectedAktacerai3 = ''.obs;
  String get selectedAktacerai3 => _selectedAktacerai3.value;
  set selectedAktacerai3(String value) => _selectedAktacerai3.value = value;

  var _selectedAktacerai4 = ''.obs;
  String get selectedAktacerai4 => _selectedAktacerai4.value;
  set selectedAktacerai4(String value) => _selectedAktacerai4.value = value;

  var _selectedAktacerai5 = ''.obs;
  String get selectedAktacerai5 => _selectedAktacerai5.value;
  set selectedAktacerai5(String value) => _selectedAktacerai5.value = value;

  var _selectedAktacerai6 = ''.obs;
  String get selectedAktacerai6 => _selectedAktacerai6.value;
  set selectedAktacerai6(String value) => _selectedAktacerai6.value = value;

  var _selectedAktacerai7 = ''.obs;
  String get selectedAktacerai7 => _selectedAktacerai7.value;
  set selectedAktacerai7(String value) => _selectedAktacerai7.value = value;

  // Cacat
  var _selectedCacat = ''.obs;
  String get selectedCacat => _selectedCacat.value;
  set selectedCacat(String value) => _selectedCacat.value = value;

  var _selectedCacat2 = ''.obs;
  String get selectedCacat2 => _selectedCacat2.value;
  set selectedCacat2(String value) => _selectedCacat2.value = value;

  var _selectedCacat3 = ''.obs;
  String get selectedCacat3 => _selectedCacat3.value;
  set selectedCacat3(String value) => _selectedCacat3.value = value;

  var _selectedCacat4 = ''.obs;
  String get selectedCacat4 => _selectedCacat4.value;
  set selectedCacat4(String value) => _selectedCacat4.value = value;

  var _selectedCacat5 = ''.obs;
  String get selectedCacat5 => _selectedCacat5.value;
  set selectedCacat5(String value) => _selectedCacat5.value = value;

  var _selectedCacat6 = ''.obs;
  String get selectedCacat6 => _selectedCacat6.value;
  set selectedCacat6(String value) => _selectedCacat6.value = value;

  var _selectedCacat7 = ''.obs;
  String get selectedCacat7 => _selectedCacat7.value;
  set selectedCacat7(String value) => _selectedCacat7.value = value;

  //Data Keluarga
  var _selectedDataKeluarga = ''.obs;
  String get selectedDataKeluarga => _selectedDataKeluarga.value;
  set selectedDataKeluarga(String value) => _selectedDataKeluarga.value = value;

  //Pendidikan Pengantar
  List<String> ListPendidikan_pngntr = [
    "SD",
    "SLTP",
    "SLTA",
    "SMK",
    "SI",
    "SII",
    "Sederajat"
  ];
  String? selectedPendidikan_pngntr;

  // Pendidikan
  List<String> listPendidikan = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma I/II",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan;

  List<String> listPendidikan2 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan2;

  List<String> listPendidikan3 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan3;

  List<String> listPendidikan4 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan4;

  List<String> listPendidikan5 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan5;

  List<String> listPendidikan6 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan6;

  List<String> listPendidikan7 = [
    "Tidak/Belum Sekolah",
    "Belum Tamat SD/Sederajat",
    "Tamat SD/Sederajat",
    "SLTP/Sederajat",
    "SLTA/Sederajat",
    "Diploma VII",
    "Akademi/Diploma III/Sarjana Muda",
    "Diploma IV/Strata I/Strata II",
    "Strata III",
    "Lainnya"
  ];
  String? selectedPendidikan7;

  //Agama
  List<String> listAgama = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama;

  List<String> listAgama2 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama2;

  List<String> listAgama3 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama3;

  List<String> listAgama4 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama4;

  List<String> listAgama5 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama5;

  List<String> listAgama6 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama6;

  List<String> listAgama7 = [
    "Islam",
    "Kristen",
    "Katholik",
    "Hindu",
    "Budha",
    "Konghucu",
    "Lainnya"
  ];
  String? selectedAgama7;

  // Jenis Cacat
  List<String> listJenisCacat = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat;

  List<String> listJenisCacat2 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat2;

  List<String> listJenisCacat3 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat3;

  List<String> listJenisCacat4 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat4;

  List<String> listJenisCacat5 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat5;

  List<String> listJenisCacat6 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat6;

  List<String> listJenisCacat7 = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat7;

  // Hubungan
  List<String> listHubungan = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan;

  List<String> listHubungan2 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan2;

  List<String> listHubungan3 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan3;

  List<String> listHubungan4 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan4;

  List<String> listHubungan5 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan5;

  List<String> listHubungan6 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan6;

  List<String> listHubungan7 = [
    "Kepala Keluarga",
    "Suami",
    "Istri",
    "Anak",
    "Menantu",
    "Cucu",
    "Orang Tua",
    "Mertua",
    "Famili",
    "Lainnya"
  ];
  String? selectedHubungan7;

  List<String> listSponsor = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor;

  List<String> listSponsor2 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor2;

  List<String> listSponsor3 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor3;

  List<String> listSponsor4 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor4;

  List<String> listSponsor5 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor5;

  List<String> listSponsor6 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor6;

  List<String> listSponsor7 = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor7;

  List<String> listStatus = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus;

  List<String> listStatus2 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus2;

  List<String> listStatus3 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus3;

  List<String> listStatus4 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus4;

  List<String> listStatus5 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus5;

  List<String> listStatus6 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus6;

  List<String> listStatus7 = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus7;

  List<String> listGoldarah = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah;

  List<String> listGoldarah2 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah2;

  List<String> listGoldarah3 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah3;

  List<String> listGoldarah4 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah4;

  List<String> listGoldarah5 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah5;

  List<String> listGoldarah6 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah6;

  List<String> listGoldarah7 = [
    "A",
    "B",
    "AB",
    "O",
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
    "Tidak Tahu",
  ];
  String? selectGoldarah7;

  List<String> listPekerjaan = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan;

  List<String> listPekerjaan2 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan2;

  List<String> listPekerjaan3 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan3;

  List<String> listPekerjaan4 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan4;

  List<String> listPekerjaan5 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan5;

  List<String> listPekerjaan6 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan6;

  List<String> listPekerjaan7 = [
    "Belum/Tidak Bekerja",
    "Mengurus Rumah Tangga",
    "Pelajar/Mahasiswa",
    "Pensiunan",
    "Pegawai Negeri Sipil",
    "Tentara Nasional Indonesia",
    "Kepolisian RI",
    "Perdagangan",
    "Petani/Pekebun",
    "Peternak",
    "Nelayan/Perikanan",
    "Industri",
    "Konstruksi",
    "Transportasi",
    "Karyawan Swasta",
    "Karyawan BUMN",
    "Karyawan BUMD",
    "Karyawan Honorer",
    "Buruh Harian Lepas",
    "Buruh Tani/Perkebunan",
    "Buruh Nelayan/Perikanan",
    "Buruh Peternakan",
    "Pembantu Rumah Tangga",
    "Tukang Cukur",
    "Tukang Listrik",
    "Tukang Batu",
    "Tukang Kayu",
    "Tukang Sol Sepatu",
    "Tukang Las/Pandai Besi",
    "Tukang Jahit",
    "Tukang Gigi",
    "Penata Rias",
    "Penata Busana",
    "Penata Rambut",
    "Mekanik",
    "Seniman",
    "Tabib",
    "Paraji",
    "Perancang Busana",
    "Penterjemah",
    "Imam Masjid",
    "Pendeta",
    "Pastor",
    "Wartawan",
    "Ustadz/Mubaligh",
    "Juru Masak",
    "Promotor Acara",
    "Anggota DPR-RI",
    "Anggota DPD",
    "Anggota BPK",
    "Presiden",
    "Wakil Presiden",
    "Anggota Mahkamah Konstitusi",
    "Anggota Kabinet/Kementrian",
    "Duta Besar",
    "Gubernur",
    "Wakil Gubernur",
    "Bupati",
    "Wakil Bupati",
    "Walikota",
    "Wakil Walikota",
    "Anggota DPRD Provinsi",
    "Anggota DPRD Kab/Kota",
    "Dosen",
    "Guru",
    "Pilot",
    "Pengacara",
    "Notaris",
    "Arsitek",
    "Akuntan",
    "Konsultan",
    "Dokter",
    "Bidan",
    "Perawat",
    "Apoteker",
    "Psikiater/Psikolog",
    "Penyiar Televisi",
    "Penyiar Radio",
    "Pelaut",
    "Peneliti",
    "Sopir",
    "Pialang",
    "Paranormal",
    "Pedagang",
    "Perangkat Desa",
    "Kepala Desa",
    "Biarawati",
    "Wiraswasta",
    "Anggota Lembaga Tinggi Lainnya",
    "Artis",
    "Atlit",
    "Chef",
    "Manajer",
    "Tenaga Tata Usaha",
    "Operator",
    "Pekerja Pengolahan Kerajinan",
    "Teknisi",
    "Asisten Ahli",
    "Lainnya.........",
  ];
  String? selectedPekerjaan7;

  late File image;
  var imagePath = ''.obs;

  List<String> listKeperluan1 = [
    "Pengurusan Surat Pindah",
    "Pengurusan Surat Datang",
    "Surat Kontrak Rumah",
    "Pengurusan Surat Kelahiran",
    "Pengurusan Surat Kematian",
    "Surat Keterangan Tidak Mampu",
    "Surat Pernyataan Waris",
    "Surat Ijin Keramaian",
    "Pengurusan Surat Ijin Usaha",
    "Pengantar Surat Nikah",
    "Pengurusan Surat Pensiun",
    "Surat Keterangan Penghasilan",
    "Surat Keterangan Permohonan KPR",
    "Surat Keterangan Bersih Diri",
    "Surat Keterangan Catatan Kepolisian",
    "Surat Tunjangan Keluarga",
    "Surat Pengurusan Paspor",
    "Surat Keterangan Domisili",
    "Surat Boro Kerja",
    "Pengurusan KTP Baru",
    "Pengurusan KK Baru",
    "Surat Ijin Mendirikan Bangunan"
  ];
  String? selectedKeperluan1;

  List<String> listKeperluan2 = [
    "Pengurusan Surat Pindah",
    "Pengurusan Surat Datang",
    "Surat Kontrak Rumah",
    "Pengurusan Surat Kelahiran",
    "Pengurusan Surat Kematian",
    "Surat Keterangan Tidak Mampu",
    "Surat Pernyataan Waris",
    "Surat Ijin Keramaian",
    "Pengurusan Surat Ijin Usaha",
    "Pengantar Surat Nikah",
    "Pengurusan Surat Pensiun",
    "Surat Keterangan Penghasilan",
    "Surat Keterangan Permohonan KPR",
    "Surat Keterangan Bersih Diri",
    "Surat Keterangan Catatan Kepolisian",
    "Surat Tunjangan Keluarga",
    "Surat Pengurusan Paspor",
    "Surat Keterangan Domisili",
    "Surat Boro Kerja",
    "Pengurusan KTP Baru",
    "Pengurusan KK Baru",
    "Surat Ijin Mendirikan Bangunan"
  ];
  String? selectedKeperluan2;

  var _selectedWNI = ''.obs;
  String get selectedWNI => _selectedWNI.value;
  set selectedWNI(String value) => _selectedWNI.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(bool value) => _isSaving.value = value;

  Future pickImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      File file = File(result.files.single.path!);
      imagePath.value = file.path;
    }
  }

  // modelToController(kk kk) {
  //   namaC.text = kk.nama ?? '';
  //   tempatC.text = kk.tempatlahir ?? '';
  //   pekerjaanC.text = kk.pekerjaan ?? '';
  //   alamatC.text = kk.alamat ?? '';
  //   nikC.text = kk.nik?.toString() ?? '';
  //   selectedAgama = kk.agama;
  //   selectedKelamin = kk.kelamin ?? '';
  //   selectedTanggal = kk.tanggallahir ?? DateTime.now();
  //   selectedPendidikan = kk.pekerjaan;
  //   selectedStatus = kk.status;
  //   selectedWNI = kk.wni ?? '';
  //   rtC.text = kk.rt ?? '';
  //   rwC.text = kk.rw ?? '';
  //   kelurahanC.text = kk.kelurahan ?? '';
  //   kecamatanC.text = kk.kecamatan ?? '';
  //   selectGoldarah = kk.goldarah ?? '';
  // }

  Future store(KK kk) async {
    isSaving = true;
    KK nomerC = await KK().streamList();
    if (kk.nomer == null) {
      kk.nomer = (nomerC.nomer ?? 0) + 1;
    }
    kk.datakeluarga = selectedDataKeluarga;
    kk.jumkeluarga = int.tryParse(jumkeluargaC.text);
    kk.namakepala = namakepalaC.text;
    kk.namalengkap = namalengkapC.text;
    kk.namalengkap2 = namalengkap2C.text;
    kk.namalengkap3 = namalengkap3C.text;
    kk.namalengkap4 = namalengkap4C.text;
    kk.namalengkap5 = namalengkap5C.text;
    kk.namalengkap6 = namalengkap6C.text;
    kk.namalengkap7 = namalengkap7C.text;
    kk.gelarbelakang = gelarbelakangC.text;
    kk.gelardepan = gelardepanC.text;
    kk.nopaspor = nopasporC.text;
    kk.nopaspor2 = nopaspor2C.text;
    kk.nopaspor3 = nopaspor3C.text;
    kk.nopaspor4 = nopaspor4C.text;
    kk.nopaspor5 = nopaspor5C.text;
    kk.nopaspor6 = nopaspor6C.text;
    kk.nopaspor7 = nopaspor7C.text;
    kk.tanggalpaspor = selectedTanggalpaspor;
    kk.tanggalpaspor2 = selectedTanggalpaspor2;
    kk.tanggalpaspor3 = selectedTanggalpaspor3;
    kk.tanggalpaspor4 = selectedTanggalpaspor4;
    kk.tanggalpaspor5 = selectedTanggalpaspor5;
    kk.tanggalpaspor6 = selectedTanggalpaspor6;
    kk.tanggalpaspor7 = selectedTanggalpaspor7;
    kk.namasponsor = namasponsorC.text;
    kk.namasponsor2 = namasponsor2C.text;
    kk.namasponsor3 = namasponsor3C.text;
    kk.namasponsor4 = namasponsor4C.text;
    kk.namasponsor5 = namasponsor5C.text;
    kk.namasponsor6 = namasponsor6C.text;
    kk.namasponsor7 = namasponsor7C.text;
    kk.tipesponsor = selectedSponsor;
    kk.tipesponsor2 = selectedSponsor2;
    kk.tipesponsor3 = selectedSponsor3;
    kk.tipesponsor4 = selectedSponsor4;
    kk.tipesponsor5 = selectedSponsor5;
    kk.tipesponsor6 = selectedSponsor6;
    kk.tipesponsor7 = selectedSponsor7;
    kk.alamatsponsor = alamatsponsorC.text;
    kk.alamatsponsor2 = alamatsponsor2C.text;
    kk.alamatsponsor3 = alamatsponsor3C.text;
    kk.alamatsponsor4 = alamatsponsor4C.text;
    kk.alamatsponsor5 = alamatsponsor5C.text;
    kk.alamatsponsor6 = alamatsponsor6C.text;
    kk.alamatsponsor7 = alamatsponsor7C.text;
    kk.kodeppos = int.tryParse(kodeposC.text);
    kk.telepon = int.tryParse(teleponC.text);
    kk.pekerjaan = selectedPekerjaan;
    kk.pekerjaan2 = selectedPekerjaan2;
    kk.pekerjaan3 = selectedPekerjaan3;
    kk.pekerjaan4 = selectedPekerjaan4;
    kk.pekerjaan5 = selectedPekerjaan5;
    kk.pekerjaan6 = selectedPekerjaan6;
    kk.pekerjaan7 = selectedPekerjaan7;
    kk.agama = selectedAgama;
    kk.agama2 = selectedAgama2;
    kk.agama3 = selectedAgama3;
    kk.agama4 = selectedAgama4;
    kk.agama5 = selectedAgama5;
    kk.agama6 = selectedAgama6;
    kk.agama7 = selectedAgama7;
    kk.statuskawin = selectedStatus;
    kk.statuskawin2 = selectedStatus2;
    kk.statuskawin3 = selectedStatus3;
    kk.statuskawin4 = selectedStatus4;
    kk.statuskawin5 = selectedStatus5;
    kk.statuskawin6 = selectedStatus6;
    kk.statuskawin7 = selectedStatus7;
    kk.alamat = alamatC.text;
    kk.kelamin = selectedKelamin;
    kk.kelamin2 = selectedKelamin2;
    kk.kelamin3 = selectedKelamin3;
    kk.kelamin4 = selectedKelamin4;
    kk.kelamin5 = selectedKelamin5;
    kk.kelamin6 = selectedKelamin6;
    kk.kelamin7 = selectedKelamin7;
    kk.nikibu = int.tryParse(nikibuC.text);
    kk.nikibu2 = int.tryParse(nikibu2C.text);
    kk.nikibu3 = int.tryParse(nikibu3C.text);
    kk.nikibu4 = int.tryParse(nikibu4C.text);
    kk.nikibu5 = int.tryParse(nikibu5C.text);
    kk.nikibu6 = int.tryParse(nikibu6C.text);
    kk.nikibu7 = int.tryParse(nikibu7C.text);
    kk.tanggallahir = selectedTanggallahir;
    kk.tanggallahir2 = selectedTanggallahir2;
    kk.tanggallahir3 = selectedTanggallahir3;
    kk.tanggallahir4 = selectedTanggallahir4;
    kk.tanggallahir5 = selectedTanggallahir5;
    kk.tanggallahir6 = selectedTanggallahir6;
    kk.tanggallahir7 = selectedTanggallahir7;
    kk.tempatlahir = tempatC.text;
    kk.tempatlahir2 = tempat2C.text;
    kk.tempatlahir3 = tempat3C.text;
    kk.tempatlahir4 = tempat4C.text;
    kk.tempatlahir5 = tempat5C.text;
    kk.tempatlahir6 = tempat6C.text;
    kk.tempatlahir7 = tempat7C.text;
    kk.kewarganegaraan = kewarganegaraanC.text;
    kk.kewarganegaraan2 = kewarganegaraan2C.text;
    kk.kewarganegaraan3 = kewarganegaraan3C.text;
    kk.kewarganegaraan4 = kewarganegaraan4C.text;
    kk.kewarganegaraan5 = kewarganegaraan5C.text;
    kk.kewarganegaraan6 = kewarganegaraan6C.text;
    kk.kewarganegaraan7 = kewarganegaraan7C.text;
    kk.nowali = int.tryParse(nowaliC.text);
    kk.nowali2 = int.tryParse(nowali2C.text);
    kk.nowali3 = int.tryParse(nowali3C.text);
    kk.nowali4 = int.tryParse(nowali4C.text);
    kk.nowali5 = int.tryParse(nowali5C.text);
    kk.nowali6 = int.tryParse(nowali6C.text);
    kk.nowali7 = int.tryParse(nowali7C.text);
    kk.rt = int.tryParse(rtC.text);
    kk.rw = int.tryParse(rwC.text);
    kk.goldarah = selectGoldarah;
    kk.goldarah2 = selectGoldarah2;
    kk.goldarah3 = selectGoldarah3;
    kk.goldarah4 = selectGoldarah4;
    kk.goldarah5 = selectGoldarah5;
    kk.goldarah6 = selectGoldarah6;
    kk.goldarah7 = selectGoldarah7;
    kk.aktalahir = selectedAktalahir;
    kk.aktalahir2 = selectedAktalahir2;
    kk.aktalahir3 = selectedAktalahir3;
    kk.aktalahir4 = selectedAktalahir4;
    kk.aktalahir5 = selectedAktalahir5;
    kk.aktalahir6 = selectedAktalahir6;
    kk.aktalahir7 = selectedAktalahir7;
    kk.noakta = noaktalahirC.text;
    kk.noakta2 = noaktalahir2C.text;
    kk.noakta3 = noaktalahir3C.text;
    kk.noakta4 = noaktalahir4C.text;
    kk.noakta5 = noaktalahir5C.text;
    kk.noakta6 = noaktalahir6C.text;
    kk.noakta7 = noaktalahir7C.text;
    kk.orgagama = orgagamaC.text;
    kk.orgagama2 = orgagama2C.text;
    kk.orgagama3 = orgagama3C.text;
    kk.orgagama4 = orgagama4C.text;
    kk.orgagama5 = orgagama5C.text;
    kk.orgagama6 = orgagama6C.text;
    kk.orgagama7 = orgagama7C.text;
    kk.noaktakawin = noaktakawinC.text;
    kk.noaktakawin2 = noaktakawin2C.text;
    kk.noaktakawin3 = noaktakawin3C.text;
    kk.noaktakawin4 = noaktakawin4C.text;
    kk.noaktakawin5 = noaktakawin5C.text;
    kk.noaktakawin6 = noaktakawin6C.text;
    kk.noaktakawin7 = noaktakawin7C.text;
    kk.aktakawin = selectedAktakawin;
    kk.aktakawin2 = selectedAktakawin2;
    kk.aktakawin3 = selectedAktakawin3;
    kk.aktakawin4 = selectedAktakawin4;
    kk.aktakawin5 = selectedAktakawin5;
    kk.aktakawin6 = selectedAktakawin6;
    kk.aktakawin7 = selectedAktakawin7;
    kk.tanggalkawin = selectedTanggalkawin;
    kk.tanggalkawin2 = selectedTanggalkawin2;
    kk.tanggalkawin3 = selectedTanggalkawin3;
    kk.tanggalkawin4 = selectedTanggalkawin4;
    kk.tanggalkawin5 = selectedTanggalkawin5;
    kk.tanggalkawin6 = selectedTanggalkawin6;
    kk.tanggalkawin7 = selectedTanggalkawin7;
    kk.aktacerai = selectedAktacerai;
    kk.aktacerai2 = selectedAktacerai2;
    kk.aktacerai3 = selectedAktacerai3;
    kk.aktacerai4 = selectedAktacerai4;
    kk.aktacerai5 = selectedAktacerai5;
    kk.aktacerai6 = selectedAktacerai6;
    kk.aktacerai7 = selectedAktacerai7;
    kk.noaktacerai = noaktaceraiC.text;
    kk.noaktacerai2 = noaktacerai2C.text;
    kk.noaktacerai3 = noaktacerai3C.text;
    kk.noaktacerai4 = noaktacerai4C.text;
    kk.noaktacerai5 = noaktacerai5C.text;
    kk.noaktacerai6 = noaktacerai6C.text;
    kk.noaktacerai7 = noaktacerai7C.text;
    kk.tanggalcerai = selectedTanggalcerai;
    kk.tanggalcerai2 = selectedTanggalcerai2;
    kk.tanggalcerai3 = selectedTanggalcerai3;
    kk.tanggalcerai4 = selectedTanggalcerai4;
    kk.tanggalcerai5 = selectedTanggalcerai5;
    kk.tanggalcerai6 = selectedTanggalcerai6;
    kk.tanggalcerai7 = selectedTanggalcerai7;
    kk.statuskeluarga = selectedHubungan;
    kk.statuskeluarga2 = selectedHubungan2;
    kk.statuskeluarga3 = selectedHubungan3;
    kk.statuskeluarga4 = selectedHubungan4;
    kk.statuskeluarga5 = selectedHubungan5;
    kk.statuskeluarga6 = selectedHubungan6;
    kk.statuskeluarga7 = selectedHubungan7;
    kk.cacat = selectedCacat;
    kk.cacat2 = selectedCacat2;
    kk.cacat3 = selectedCacat3;
    kk.cacat4 = selectedCacat4;
    kk.cacat5 = selectedCacat5;
    kk.cacat6 = selectedCacat6;
    kk.cacat7 = selectedCacat7;
    kk.jeniscacat = selectedJenisCacat;
    kk.jeniscacat2 = selectedJenisCacat2;
    kk.jeniscacat3 = selectedJenisCacat3;
    kk.jeniscacat4 = selectedJenisCacat4;
    kk.jeniscacat5 = selectedJenisCacat5;
    kk.jeniscacat6 = selectedJenisCacat6;
    kk.jeniscacat7 = selectedJenisCacat7;
    kk.pendidikan = selectedPendidikan;
    kk.pendidikan2 = selectedPendidikan2;
    kk.pendidikan3 = selectedPendidikan3;
    kk.pendidikan4 = selectedPendidikan4;
    kk.pendidikan5 = selectedPendidikan5;
    kk.pendidikan6 = selectedPendidikan6;
    kk.pendidikan7 = selectedPendidikan7;
    kk.noitas = noitasC.text;
    kk.noitas2 = noitas2C.text;
    kk.noitas3 = noitas3C.text;
    kk.noitas4 = noitas4C.text;
    kk.noitas5 = noitas5C.text;
    kk.noitas6 = noitas6C.text;
    kk.noitas7 = noitas7C.text;
    kk.tempatitas = tempatItasC.text;
    kk.tempatitas2 = tempatItas2C.text;
    kk.tempatitas3 = tempatItas3C.text;
    kk.tempatitas4 = tempatItas4C.text;
    kk.tempatitas5 = tempatItas5C.text;
    kk.tempatitas6 = tempatItas6C.text;
    kk.tempatitas7 = tempatItas7C.text;
    kk.tanggalterbititas = selectedTanggalTerbitItas;
    kk.tanggalterbititas2 = selectedTanggalTerbitItas2;
    kk.tanggalterbititas3 = selectedTanggalTerbitItas3;
    kk.tanggalterbititas4 = selectedTanggalTerbitItas4;
    kk.tanggalterbititas5 = selectedTanggalTerbitItas5;
    kk.tanggalterbititas6 = selectedTanggalTerbitItas6;
    kk.tanggalterbititas7 = selectedTanggalTerbitItas7;
    kk.tanggalitas = selectedTanggalItas;
    kk.tanggalitas2 = selectedTanggalItas2;
    kk.tanggalitas3 = selectedTanggalItas3;
    kk.tanggalitas4 = selectedTanggalItas4;
    kk.tanggalitas5 = selectedTanggalItas5;
    kk.tanggalitas6 = selectedTanggalItas6;
    kk.tanggalitas7 = selectedTanggalItas7;
    kk.tempatpertama = tempatPertamaC.text;
    kk.tempatpertama2 = tempatPertama2C.text;
    kk.tempatpertama3 = tempatPertama3C.text;
    kk.tempatpertama4 = tempatPertama4C.text;
    kk.tempatpertama5 = tempatPertama5C.text;
    kk.tempatpertama6 = tempatPertama6C.text;
    kk.tempatpertama7 = tempatPertama7C.text;
    kk.tanggalpertama = selectedTanggalpertama;
    kk.tanggalpertama2 = selectedTanggalpertama2;
    kk.tanggalpertama3 = selectedTanggalpertama3;
    kk.tanggalpertama4 = selectedTanggalpertama4;
    kk.tanggalpertama5 = selectedTanggalpertama5;
    kk.tanggalpertama6 = selectedTanggalpertama6;
    kk.tanggalpertama7 = selectedTanggalpertama7;
    kk.nikayah = int.tryParse(nikayahC.text);
    kk.nikayah2 = int.tryParse(nikayah2C.text);
    kk.nikayah3 = int.tryParse(nikayah3C.text);
    kk.nikayah4 = int.tryParse(nikayah4C.text);
    kk.nikayah5 = int.tryParse(nikayah5C.text);
    kk.nikayah6 = int.tryParse(nikayah6C.text);
    kk.nikayah7 = int.tryParse(nikayah7C.text);
    kk.namaibu = namaibuC.text;
    kk.namaibu2 = namaibu2C.text;
    kk.namaibu3 = namaibu3C.text;
    kk.namaibu4 = namaibu4C.text;
    kk.namaibu5 = namaibu5C.text;
    kk.namaibu6 = namaibu6C.text;
    kk.namaibu7 = namaibu7C.text;
    kk.namaayah = namaayahC.text;
    kk.namaayah2 = namaayah2C.text;
    kk.namaayah3 = namaayah3C.text;
    kk.namaayah4 = namaayah4C.text;
    kk.namaayah5 = namaayah5C.text;
    kk.namaayah6 = namaayah6C.text;
    kk.namaayah7 = namaayah7C.text;
    kk.email = emailC.text;
    kk.keperluan1 = keperluan;
    kk.wni = selectedWNI;
    kk.nik = int.tryParse(nikC.text);
    kk.kk = int.tryParse(kkC.text);
    kk.pendidikan_pngntr = selectedPendidikan_pngntr;
    if (kk.id == null) {
      kk.waktu = DateTime.now();
    }
    try {
      await kk.save();
      Get.defaultDialog(
        title: "Berhasil",
        middleText:
            "Surat Pengajuan Anda Berhasil dan Tunggu Persetujuan Ketua RT",
        textConfirm: "Oke",
        onConfirm: () {
          Get.back();
          Get.back();
        },
        buttonColor: primary,
        cancelTextColor: primary,
        confirmTextColor: white,
        titleStyle: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
        ),
        middleTextStyle: TextStyle(
          color: Color(0XFF757575),
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      );
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  var keperluan = "Pengurusan KK baru";

  Future storeabsen(Absen absen) async {
    isSaving = true;
    absen.nama = namakepalaC.text;
    absen.alamat = alamatC.text;
    absen.email = emailC.text;
    if (absen.id == null) {
      absen.waktu = DateTime.now();
    }
    try {
      await absen.save();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    namalengkapC = TextEditingController();
    namalengkap2C = TextEditingController();
    namalengkap3C = TextEditingController();
    namalengkap4C = TextEditingController();
    namalengkap5C = TextEditingController();
    namalengkap6C = TextEditingController();
    namalengkap7C = TextEditingController();
    namakepalaC = TextEditingController();
    namasponsorC = TextEditingController();
    namasponsor2C = TextEditingController();
    namasponsor3C = TextEditingController();
    namasponsor4C = TextEditingController();
    namasponsor5C = TextEditingController();
    namasponsor6C = TextEditingController();
    namasponsor7C = TextEditingController();
    namaayahC = TextEditingController();
    namaayah2C = TextEditingController();
    namaayah3C = TextEditingController();
    namaayah4C = TextEditingController();
    namaayah5C = TextEditingController();
    namaayah6C = TextEditingController();
    namaayah7C = TextEditingController();
    namaibuC = TextEditingController();
    namaibu2C = TextEditingController();
    namaibu3C = TextEditingController();
    namaibu4C = TextEditingController();
    namaibu5C = TextEditingController();
    namaibu6C = TextEditingController();
    namaibu7C = TextEditingController();
    kodeposC = TextEditingController();
    jumkeluargaC = TextEditingController();
    teleponC = TextEditingController();
    gelardepanC = TextEditingController();
    gelardepan2C = TextEditingController();
    gelardepan3C = TextEditingController();
    gelardepan4C = TextEditingController();
    gelardepan5C = TextEditingController();
    gelardepan6C = TextEditingController();
    gelardepan7C = TextEditingController();
    gelarbelakangC = TextEditingController();
    gelarbelakang2C = TextEditingController();
    gelarbelakang3C = TextEditingController();
    gelarbelakang4C = TextEditingController();
    gelarbelakang5C = TextEditingController();
    gelarbelakang6C = TextEditingController();
    gelarbelakang7C = TextEditingController();
    nopasporC = TextEditingController();
    nopaspor2C = TextEditingController();
    nopaspor3C = TextEditingController();
    nopaspor4C = TextEditingController();
    nopaspor5C = TextEditingController();
    nopaspor6C = TextEditingController();
    nopaspor7C = TextEditingController();
    tempatC = TextEditingController();
    tempat2C = TextEditingController();
    tempat3C = TextEditingController();
    tempat4C = TextEditingController();
    tempat5C = TextEditingController();
    tempat6C = TextEditingController();
    tempat7C = TextEditingController();
    pekerjaanC = TextEditingController();
    pekerjaan2C = TextEditingController();
    pekerjaan3C = TextEditingController();
    pekerjaan4C = TextEditingController();
    pekerjaan5C = TextEditingController();
    pekerjaan6C = TextEditingController();
    pekerjaan7C = TextEditingController();
    nikibuC = TextEditingController();
    nikibu2C = TextEditingController();
    nikibu3C = TextEditingController();
    nikibu4C = TextEditingController();
    nikibu5C = TextEditingController();
    nikibu6C = TextEditingController();
    nikibu7C = TextEditingController();
    nikayahC = TextEditingController();
    nikayah2C = TextEditingController();
    nikayah3C = TextEditingController();
    nikayah4C = TextEditingController();
    nikayah5C = TextEditingController();
    nikayah6C = TextEditingController();
    nikayah7C = TextEditingController();
    noitasC = TextEditingController();
    noitas2C = TextEditingController();
    noitas3C = TextEditingController();
    noitas4C = TextEditingController();
    noitas5C = TextEditingController();
    noitas6C = TextEditingController();
    noitas7C = TextEditingController();
    tempatItasC = TextEditingController();
    tempatItas2C = TextEditingController();
    tempatItas3C = TextEditingController();
    tempatItas4C = TextEditingController();
    tempatItas5C = TextEditingController();
    tempatItas6C = TextEditingController();
    tempatItas7C = TextEditingController();
    tempatPertamaC = TextEditingController();
    tempatPertama2C = TextEditingController();
    tempatPertama3C = TextEditingController();
    tempatPertama4C = TextEditingController();
    tempatPertama5C = TextEditingController();
    tempatPertama6C = TextEditingController();
    tempatPertama7C = TextEditingController();
    alamatC = TextEditingController();
    alamatsponsorC = TextEditingController();
    alamatsponsor2C = TextEditingController();
    alamatsponsor3C = TextEditingController();
    alamatsponsor4C = TextEditingController();
    alamatsponsor5C = TextEditingController();
    alamatsponsor6C = TextEditingController();
    alamatsponsor7C = TextEditingController();
    rtC = TextEditingController();
    rwC = TextEditingController();
    nowaliC = TextEditingController();
    nowali2C = TextEditingController();
    nowali3C = TextEditingController();
    nowali4C = TextEditingController();
    nowali5C = TextEditingController();
    nowali6C = TextEditingController();
    nowali7C = TextEditingController();
    noaktalahirC = TextEditingController();
    noaktalahir2C = TextEditingController();
    noaktalahir3C = TextEditingController();
    noaktalahir4C = TextEditingController();
    noaktalahir5C = TextEditingController();
    noaktalahir6C = TextEditingController();
    noaktalahir7C = TextEditingController();
    noaktakawinC = TextEditingController();
    noaktakawin2C = TextEditingController();
    noaktakawin3C = TextEditingController();
    noaktakawin4C = TextEditingController();
    noaktakawin5C = TextEditingController();
    noaktakawin6C = TextEditingController();
    noaktakawin7C = TextEditingController();
    noaktaceraiC = TextEditingController();
    noaktacerai2C = TextEditingController();
    noaktacerai3C = TextEditingController();
    noaktacerai4C = TextEditingController();
    noaktacerai5C = TextEditingController();
    noaktacerai6C = TextEditingController();
    noaktacerai7C = TextEditingController();
    orgagamaC = TextEditingController();
    orgagama2C = TextEditingController();
    orgagama3C = TextEditingController();
    orgagama4C = TextEditingController();
    orgagama5C = TextEditingController();
    orgagama6C = TextEditingController();
    orgagama7C = TextEditingController();
    kewarganegaraanC = TextEditingController();
    kewarganegaraan2C = TextEditingController();
    kewarganegaraan3C = TextEditingController();
    kewarganegaraan4C = TextEditingController();
    kewarganegaraan5C = TextEditingController();
    kewarganegaraan6C = TextEditingController();
    kewarganegaraan7C = TextEditingController();
    nikC = TextEditingController();
    kkC = TextEditingController();
    emailC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namalengkapC.clear();
    namalengkap2C.clear();
    namalengkap3C.clear();
    namalengkap4C.clear();
    namalengkap5C.clear();
    namalengkap6C.clear();
    namalengkap7C.clear();
    namakepalaC.clear();
    namasponsorC.clear();
    namasponsor2C.clear();
    namasponsor3C.clear();
    namasponsor4C.clear();
    namasponsor5C.clear();
    namasponsor6C.clear();
    namasponsor7C.clear();
    namaayahC.clear();
    namaayah2C.clear();
    namaayah3C.clear();
    namaayah4C.clear();
    namaayah5C.clear();
    namaayah6C.clear();
    namaayah7C.clear();
    namaibuC.clear();
    namaibu2C.clear();
    namaibu3C.clear();
    namaibu4C.clear();
    namaibu5C.clear();
    namaibu6C.clear();
    namaibu7C.clear();
    kodeposC.clear();
    jumkeluargaC.clear();
    teleponC.clear();
    gelardepanC.clear();
    gelardepan2C.clear();
    gelardepan3C.clear();
    gelardepan4C.clear();
    gelardepan5C.clear();
    gelardepan6C.clear();
    gelardepan7C.clear();
    gelarbelakangC.clear();
    gelarbelakang2C.clear();
    gelarbelakang3C.clear();
    gelarbelakang4C.clear();
    gelarbelakang5C.clear();
    gelarbelakang6C.clear();
    gelarbelakang7C.clear();
    nopasporC.clear();
    nopaspor2C.clear();
    nopaspor3C.clear();
    nopaspor4C.clear();
    nopaspor5C.clear();
    nopaspor6C.clear();
    nopaspor7C.clear();
    tempatC.clear();
    tempat2C.clear();
    tempat3C.clear();
    tempat4C.clear();
    tempat5C.clear();
    tempat6C.clear();
    tempat7C.clear();
    pekerjaanC.clear();
    pekerjaan2C.clear();
    pekerjaan3C.clear();
    pekerjaan4C.clear();
    pekerjaan5C.clear();
    pekerjaan6C.clear();
    pekerjaan7C.clear();
    nikibuC.clear();
    nikibu2C.clear();
    nikibu3C.clear();
    nikibu4C.clear();
    nikibu5C.clear();
    nikibu6C.clear();
    nikibu7C.clear();
    nikayahC.clear();
    nikayah2C.clear();
    nikayah3C.clear();
    nikayah4C.clear();
    nikayah5C.clear();
    nikayah6C.clear();
    nikayah7C.clear();
    noitasC.clear();
    noitas2C.clear();
    noitas3C.clear();
    noitas4C.clear();
    noitas5C.clear();
    noitas6C.clear();
    noitas7C.clear();
    tempatItasC.clear();
    tempatItas2C.clear();
    tempatItas3C.clear();
    tempatItas4C.clear();
    tempatItas5C.clear();
    tempatItas6C.clear();
    tempatItas7C.clear();
    tempatPertamaC.clear();
    tempatPertama2C.clear();
    tempatPertama3C.clear();
    tempatPertama4C.clear();
    tempatPertama5C.clear();
    tempatPertama6C.clear();
    tempatPertama7C.clear();
    alamatC.clear();
    alamatsponsorC.clear();
    alamatsponsor2C.clear();
    alamatsponsor3C.clear();
    alamatsponsor4C.clear();
    alamatsponsor5C.clear();
    alamatsponsor6C.clear();
    alamatsponsor7C.clear();
    rtC.clear();
    rwC.clear();
    nowaliC.clear();
    nowali2C.clear();
    nowali3C.clear();
    nowali4C.clear();
    nowali5C.clear();
    nowali6C.clear();
    nowali7C.clear();
    noaktalahirC.clear();
    noaktalahir2C.clear();
    noaktalahir3C.clear();
    noaktalahir4C.clear();
    noaktalahir5C.clear();
    noaktalahir6C.clear();
    noaktalahir7C.clear();
    noaktakawinC.clear();
    noaktakawin2C.clear();
    noaktakawin3C.clear();
    noaktakawin4C.clear();
    noaktakawin5C.clear();
    noaktakawin6C.clear();
    noaktakawin7C.clear();
    noaktaceraiC.clear();
    noaktacerai2C.clear();
    noaktacerai3C.clear();
    noaktacerai4C.clear();
    noaktacerai5C.clear();
    noaktacerai6C.clear();
    noaktacerai7C.clear();
    orgagamaC.clear();
    orgagama2C.clear();
    orgagama3C.clear();
    orgagama4C.clear();
    orgagama5C.clear();
    orgagama6C.clear();
    orgagama7C.clear();
    kewarganegaraanC.clear();
    kewarganegaraan2C.clear();
    kewarganegaraan3C.clear();
    kewarganegaraan4C.clear();
    kewarganegaraan5C.clear();
    kewarganegaraan6C.clear();
    kewarganegaraan7C.clear();
    nikC.clear();
    kkC.clear();
    emailC.clear();
  }
}
