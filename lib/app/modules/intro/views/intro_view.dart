import 'package:erte/app/const/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import '../controllers/intro_controller.dart';
import 'package:erte/app/routes/app_pages.dart';
import 'package:lottie/lottie.dart';

class IntroView extends GetView<IntroController> {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Selamat Datang",
          decoration: PageDecoration(titleTextStyle: TextStyle(color: primary, fontSize: 20),
          ),
          body:
              "Aplikasi dapat membantu warga untuk membuat dan menyerahkan surat pengantar tanpa menemui Ketua Rukun Tetangga (RT) ",
          image: Center(
            child: Lottie.asset(
              "images/Intro1.json",
              height: 175.0,
            ),
          ),
        ),
        PageViewModel(
          // title: "ERTE",
          titleWidget: Container(
            height: 90,
            width: 130,
            child: Image.asset("images/erte.png", fit: BoxFit.fitWidth,)),
          body:
              "Aplikasi Untuk Membuat Surat Pengantar Untuk Kebutuhan Seperti Surat Kelahiran, Kematian, Domisili, Membuat KTP, DLL",
          image: Center(
            child: Lottie.asset("images/Intro2.json", height: 175.0),
          ),
        ),
        PageViewModel(
          title: "Surat Pengantar",
          decoration: PageDecoration(titleTextStyle: TextStyle(color: primary, fontSize: 20),
          ),
          body:
              "Surat Pengantar dikenal sebagai sebuah dokumen yang menjadi pembuka relasi atau formal antar individu maupun instansi",
          image: Center(
            child: Lottie.asset("images/Intro3.json", height: 175.0),
          ),
        ),
      ],
      done: const Text(
        "DONE",
        style: TextStyle(color: primary),
      ),
      showNextButton: true,
      next: Text("NEXT", style: TextStyle(color: primary),),
      onDone: () => Get.offAndToNamed(Routes.HOME),
      showSkipButton: true,
      skip: Text("SKIP", style: TextStyle(color: primary),),
      onSkip: ()=> Get.offAndToNamed(Routes.HOME),
    );
  }
}
