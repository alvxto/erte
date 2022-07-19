import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin_surat/bindings/admin_surat_binding.dart';
import '../modules/admin_surat/views/admin_surat_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/buku_tamu/bindings/buku_tamu_binding.dart';
import '../modules/buku_tamu/views/buku_tamu_view.dart';
import '../modules/form_kk/bindings/form_kk_binding.dart';
import '../modules/form_kk/views/form_kk_view.dart';
import '../modules/form_ktp/bindings/form_ktp_binding.dart';
import '../modules/form_ktp/views/form_ktp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hubungi_admin/bindings/hubungi_admin_binding.dart';
import '../modules/hubungi_admin/views/hubungi_admin_view.dart';
import '../modules/info_apk/bindings/info_apk_binding.dart';
import '../modules/info_apk/views/info_apk_view.dart';
import '../modules/info_lengkap/bindings/info_lengkap_binding.dart';
import '../modules/info_lengkap/views/info_lengkap_view.dart';
import '../modules/informasi/bindings/informasi_binding.dart';
import '../modules/informasi/views/informasi_view.dart';
import '../modules/intro/bindings/intro_binding.dart';
import '../modules/intro/views/intro_view.dart';
import '../modules/kas/bindings/kas_binding.dart';
import '../modules/kas/views/kas_view.dart';
import '../modules/lapor/bindings/lapor_binding.dart';
import '../modules/lapor/views/lapor_view.dart';
import '../modules/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/pengaturan/views/pengaturan_view.dart';
import '../modules/profil/bindings/profil_binding.dart';
import '../modules/profil/views/profil_view.dart';
import '../modules/reset/bindings/reset_binding.dart';
import '../modules/reset/views/reset_view.dart';
import '../modules/riwayat/bindings/riwayat_binding.dart';
import '../modules/riwayat/views/riwayat_view.dart';
import '../modules/riwayat_lapor/bindings/riwayat_lapor_binding.dart';
import '../modules/riwayat_lapor/views/riwayat_lapor_view.dart';
import '../modules/s_domisili/bindings/s_domisili_binding.dart';
import '../modules/s_domisili/views/s_domisili_view.dart';
import '../modules/s_pengantar/bindings/s_pengantar_binding.dart';
import '../modules/s_pengantar/views/s_pengantar_view.dart';
import '../modules/tes_pdf/bindings/tes_pdf_binding.dart';
import '../modules/tes_pdf/views/tes_pdf_view.dart';

// import '../modules/s_acara/bindings/s_acara_binding.dart';
// import '../modules/s_acara/views/s_acara_view.dart';
// import '../modules/s_kelahiran/bindings/s_kelahiran_binding.dart';
// import '../modules/s_kelahiran/views/s_kelahiran_view.dart';
// import '../modules/s_kematian/bindings/s_kematian_binding.dart';
// import '../modules/s_kematian/views/s_kematian_view.dart';
// import '../modules/s_kontrak/bindings/s_kontrak_binding.dart';
// import '../modules/s_kontrak/views/s_kontrak_view.dart';
// import '../modules/s_pernyataan/bindings/s_pernyataan_binding.dart';
// import '../modules/s_pernyataan/views/s_pernyataan_view.dart';
// import '../modules/s_usaha/bindings/s_usaha_binding.dart';
// import '../modules/s_usaha/views/s_usaha_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.S_PENGANTAR,
      page: () => SPengantarView(),
      binding: SPengantarBinding(),
    ),
    GetPage(
      name: _Paths.FORM_KTP,
      page: () => FormKtpView(),
      binding: FormKtpBinding(),
    ),
    GetPage(
      name: _Paths.LAPOR,
      page: () => LaporView(),
      binding: LaporBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT,
      page: () => RiwayatView(),
      binding: RiwayatBinding(),
    ),
    GetPage(
      name: _Paths.FORM_KK,
      page: () => FormKkView(),
      binding: FormKkBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.RESET,
      page: () => ResetView(),
      binding: ResetBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilView(),
      binding: ProfilBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
      binding: IntroBinding(),
    ),
    GetPage(
      name: _Paths.S_DOMISILI,
      page: () => SDomisiliView(),
      binding: SDomisiliBinding(),
    ),
    // GetPage(
    //   name: _Paths.S_PERNYATAAN,
    //   page: () => SPernyataanView(),
    //   binding: SPernyataanBinding(),
    // ),
    // GetPage(
    //   name: _Paths.S_KEMATIAN,
    //   page: () => SKematianView(),
    //   binding: SKematianBinding(),
    // ),
    // GetPage(
    //   name: _Paths.S_KELAHIRAN,
    //   page: () => SKelahiranView(),
    //   binding: SKelahiranBinding(),
    // ),
    // GetPage(
    //   name: _Paths.S_KONTRAK,
    //   page: () => SKontrakView(),
    //   binding: SKontrakBinding(),
    // ),
    // GetPage(
    //   name: _Paths.S_USAHA,
    //   page: () => SUsahaView(),
    //   binding: SUsahaBinding(),
    // ),
    // GetPage(
    //   name: _Paths.S_ACARA,
    //   page: () => SAcaraView(),
    //   binding: SAcaraBinding(),
    // ),
    GetPage(
      name: _Paths.ADMIN_SURAT,
      page: () => AdminSuratView(),
      binding: AdminSuratBinding(),
    ),
    GetPage(
      name: _Paths.KAS,
      page: () => KasView(),
      binding: KasBinding(),
    ),
    GetPage(
      name: _Paths.INFORMASI,
      page: () => InformasiView(),
      binding: InformasiBinding(),
    ),
    GetPage(
      name: _Paths.BUKU_TAMU,
      page: () => BukuTamuView(),
      binding: BukuTamuBinding(),
    ),
    GetPage(
      name: _Paths.INFO_LENGKAP,
      page: () => InfoLengkapView(),
      binding: InfoLengkapBinding(),
    ),
    GetPage(
      name: _Paths.TES_PDF,
      page: () => TesPdfView(),
      binding: TesPdfBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.INFO_APK,
      page: () => InfoApkView(),
      binding: InfoApkBinding(),
    ),
    GetPage(
      name: _Paths.HUBUNGI_ADMIN,
      page: () => const HubungiAdminView(),
      binding: HubungiAdminBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_LAPOR,
      page: () => RiwayatLaporView(),
      binding: RiwayatLaporBinding(),
    ),
  ];
}
