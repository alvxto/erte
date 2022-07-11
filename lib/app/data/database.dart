import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erte/app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
const pengantarCollection = "surat_pengantar";
const domisiliCollection = "surat_domisili";
const ktpCollection = "form_ktp";
const kkCollection = "form_kk";
const laporCollection = "laporan";
const userCollection = "user";
const absenCollection = "absen";
const kasCollection = "kas";
const informasiCollection = "informasi";
// const pernyataanCollection = "surat_pernyataan";
// const kelahiranCollection = "surat_kelahiran";
// const kematianCollection = "surat_kematian";
// const usahaCollection = "surat_usaha";
// const acaraCollection = "surat_acara";
// const kontrakCollection = "surat_kontrak";

class Database {
  CollectionReference collectionReference;
  Reference storageReference;
  Database({required this.collectionReference, required this.storageReference});

  Future<String?> add(Map<String, dynamic> json) async {
    try {
      DocumentReference book = await collectionReference.add(json);
      return book.id;
    } on FirebaseException {
      Get.defaultDialog(
          title: "Error",
          middleText: "Gagal Menambahkan",
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    }
    return null;
  }

  Future edit(Map<String, dynamic> json) async {
    try {
      return await collectionReference.doc(json["id"]).update(json);
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
      rethrow;
    }
  }

  Future delete(String id, {String? url}) async {
    try {
      if (url is String) {
        await storage.refFromURL(url).delete();
      }
      return await collectionReference.doc(id).delete();
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
      rethrow;
    }
  }

  Future<String?> upload({required String id, required File file}) async {
    try {
      var task = await storageReference.child(id).putFile(file);
      if (task.state == TaskState.success) {
        return await storageReference.child(id).getDownloadURL();
      }

      Get.defaultDialog(
          title: "Error",
          middleText: "Gagal Upload Gambar",
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } on FirebaseException catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
      rethrow;
    } catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          onConfirm: () => Get.back(),
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
      rethrow;
    }
    return null;
  }
}
