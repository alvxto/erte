import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/database.dart';
import 'package:erte/app/data/models/user.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthController extends GetxController {
  // RxBool hidden = true.obs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> streamAuth() => _auth.authStateChanges();

  var role = "User";

  var currUser = UserModel().obs;
  UserModel get user => currUser.value;
  set user(UserModel value) => currUser.value = value;

  var _isRegis = false.obs;
  bool get isRegis => _isRegis.value;
  set isRegis(value) => _isRegis.value = value;

  var _isSaving = false.obs;
  bool get isSaving => _isSaving.value;
  set isSaving(value) => _isSaving.value = value;

  late Rx<User?> firebaseUser;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController nameC = TextEditingController();

  login() async {
    try {
      final myuser = await _auth.signInWithEmailAndPassword(
          email: emailC.text, password: passwordC.text);
      // .then((value) => Get.toNamed(Routes.HOME));
      if (myuser.user!.emailVerified) {
        Get.offAndToNamed(Routes.HOME);
        // if (user.role == "Admin") {
        //   Get.offAndToNamed(Routes.ADMIN);
        // } else {
        //   Get.offAndToNamed(Routes.HOME);
        // }
      } else {
        Get.defaultDialog(
            title: "Gagal Login",
            middleText:
                "Verifikasi email terlebih dahulu. Apakah verifikasi perlu dikirim ulang",
            onConfirm: () async {
              await myuser.user!.sendEmailVerification();
              Get.back();
            },
            textConfirm: "Iya",
            textCancel: "Tidak",
            buttonColor: primary,
            cancelTextColor: primary,
            confirmTextColor: white,
            titleStyle: TextStyle(color: primary),
            middleTextStyle: TextStyle(color: primary));
      }
    } on FirebaseAuthException catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          textConfirm: "Oke",
          onConfirm: () => Get.back(),
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } catch (e) {
      Get.defaultDialog(
          title: "Error",
          middleText: e.toString(),
          textConfirm: "Oke",
          onConfirm: () => Get.back(),
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    }
  }

  register() async {
    try {
      isSaving = true;
      UserModel user = UserModel(
        nama: nameC.text,
        email: emailC.text,
        password: passwordC.text,
        role: role,
        waktu: DateTime.now(),
      );

      final myuser = await _auth
          .createUserWithEmailAndPassword(
        email: emailC.text,
        password: passwordC.text,
      )
          .then((value) async {
        await value.user!.sendEmailVerification();
        user.id = value.user?.uid;
        if (user.id != null) {
          firestore
              .collection(userCollection)
              .doc(user.id)
              .set(user.toJson)
              .then((value) {
            Get.defaultDialog(
                title: "Verifikasi Email",
                middleText: "Kami telah mengirimkan verifikasi ke Email anda",
                textConfirm: "Oke",
                onConfirm: () {
                  // Get.toNamed(Routes.HOME);
                  nameC.clear();
                  passwordC.clear();
                  emailC.clear();
                  Get.back();
                },
                buttonColor: primary,
                cancelTextColor: primary,
                confirmTextColor: white,
                titleStyle: TextStyle(color: primary),
                middleTextStyle: TextStyle(color: primary));
          });
        }
      });
      isSaving = false;
    } on FirebaseAuthException catch (e) {
      isSaving = false;
      Get.defaultDialog(
          title: "Error",
          textConfirm: "Oke",
          onConfirm: () {
            Get.back();
            nameC.clear();
            passwordC.clear();
            emailC.clear();
            // selectedGender = 0;
            // selectedDate = DateTime.now();
          },
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    }
  }

  void logout() async {
    Get.defaultDialog(
        title: "Logout",
        middleText: "Anda yakin ingin keluar?",
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          Get.back();
          isSaving = false;
          emailC.clear();
          passwordC.clear();
          Get.offAndToNamed(Routes.AUTH);
          // selectedGender = 0;
          // selectedDate = DateTime.now();
        },
        textConfirm: "Iya",
        textCancel: "Tidak",
        buttonColor: primary,
        cancelTextColor: primary,
        confirmTextColor: white,
        titleStyle: TextStyle(color: primary),
        middleTextStyle: TextStyle(color: primary));
  }

  void reset(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      await _auth.sendPasswordResetEmail(email: email);
      Get.defaultDialog(
          title: "Berhasil",
          middleText: "Berhasil mengirim link reset password ke email anda",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "Oke",
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } else {
      Get.defaultDialog(
          title: "Error",
          middleText: "Email tidak valid",
          textConfirm: "Oke",
          onConfirm: () => Get.back(),
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    }
  }

  streamUser(User? fuser) {
    if (fuser != null) {
      currUser.bindStream(UserModel().streamList(fuser.uid));
      print("auth id = " + fuser.uid);
      print("tojson =  ${user.toJson}");
    } else {
      print("null auth");
      user = UserModel();
      print("toJson =  ${user.toJson}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, streamUser);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // hidden.value = true;
    emailC.clear();
    passwordC.clear();
    nameC.clear();
    // selectedGender = 0;
    // selectedDate = DateTime.now();
  }
}
