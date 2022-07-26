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
  late TextEditingController namakepalaC;
  late TextEditingController namasponsorC;
  late TextEditingController namaayahC;
  late TextEditingController namaibuC;
  late TextEditingController kodeposC;
  late TextEditingController jumkeluargaC;
  late TextEditingController teleponC;
  late TextEditingController gelardepanC;
  late TextEditingController gelarbelakangC;
  late TextEditingController nopasporC;
  late TextEditingController tempatC;
  late TextEditingController pekerjaanC;
  late TextEditingController nikibuC;
  late TextEditingController nikayahC;
  late TextEditingController noitasC;
  late TextEditingController tempatItasC;
  late TextEditingController tempatPertamaC;
  late TextEditingController alamatC;
  late TextEditingController alamatsponsorC;
  late TextEditingController rtC;
  late TextEditingController rwC;
  late TextEditingController nowaliC;
  late TextEditingController noaktalahirC;
  late TextEditingController noaktakawinC;
  late TextEditingController noaktaceraiC;
  late TextEditingController orgagamaC;
  late TextEditingController kewarganegaraanC;
  late TextEditingController emailC;
  late TextEditingController nikC;
  late TextEditingController kkC;

  RxList<KK> rxKK = RxList<KK>();
  List<KK> get listAnggota => rxKK.value;
  set listAnggota(List<KK> value) => rxKK.value = value;

  modelcontroller(Anggota anggota) async {
    namalengkapC.text = anggota.namalengkap ?? '';
  }

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

  //Tanggal terbit itas
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

  // Tanggal Kawin
  Rx<DateTime?> _selectedTanggalkawin = DateTime(2050, 1, 1).obs;
  DateTime? get selectedTanggalkawin => _selectedTanggalkawin.value;
  set selectedTanggalkawin(DateTime? value) =>
      _selectedTanggalkawin.value = value;

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

  //Tanggal cerai
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

  //tanggal paspor
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

  //tanggal kedatangan pertama
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

  // Jenis Kelamin
  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  //Akta Lahir
  var _selectedAktalahir = ''.obs;
  String get selectedAktalahir => _selectedAktalahir.value;
  set selectedAktalahir(String value) => _selectedAktalahir.value = value;

  //Akta Kawin
  var _selectedAktakawin = ''.obs;
  String get selectedAktakawin => _selectedAktakawin.value;
  set selectedAktakawin(String value) => _selectedAktakawin.value = value;

  // Akta Cerai
  var _selectedAktacerai = ''.obs;
  String get selectedAktacerai => _selectedAktacerai.value;
  set selectedAktacerai(String value) => _selectedAktacerai.value = value;

  // Cacat
  var _selectedCacat = ''.obs;
  String get selectedCacat => _selectedCacat.value;
  set selectedCacat(String value) => _selectedCacat.value = value;

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

  List<String> listSponsor = [
    "Organisasi Internasional",
    "Pemerintah",
    "Perusahaan",
    "Perorangan",
  ];
  String? selectedSponsor;

  List<String> listStatusPngntr = [
    "Belum Kawin",
    "Kawin",
    "Cerai Hidup",
    "Cerai Mati",
  ];
  String? selectedstatuskwinpngntr;

  List<String> listStatus = [
    "Belum Kawin",
    "Kawin Tercatat",
    "Kawin Belum Tercatat",
    "Cerai Hidup Tercatat",
    "Cerai Hidup Belum Tercatat",
    "Cerai Mati",
  ];
  String? selectedStatus;

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

  Future store(KK kk, Anggota anggota) async {
    isSaving = true;

    kk.datakeluarga = selectedDataKeluarga;
    kk.jumkeluarga = int.tryParse(jumkeluargaC.text);
    kk.namakepala = namakepalaC.text;
    anggota.namalengkap = namalengkapC.text;
    anggota.gelarbelakang = gelarbelakangC.text;
    anggota.gelardepan = gelardepanC.text;
    anggota.nopaspor = nopasporC.text;
    anggota.tanggalpaspor = selectedTanggalpaspor;
    anggota.namasponsor = namasponsorC.text;
    anggota.tipesponsor = selectedSponsor;
    anggota.alamatsponsor = alamatsponsorC.text;
    kk.kodepos = int.tryParse(kodeposC.text);
    kk.telepon = int.tryParse(teleponC.text);
    anggota.pekerjaan = selectedPekerjaan;
    anggota.agama = selectedAgama;
    anggota.statuskwinpngntr = selectedstatuskwinpngntr;
    anggota.statuskawin = selectedStatus;
    kk.alamat = alamatC.text;
    anggota.kelamin = selectedKelamin;
    anggota.nikibu = int.tryParse(nikibuC.text);
    anggota.tanggallahir = selectedTanggallahir;
    anggota.tempatlahir = tempatC.text;
    anggota.kewarganegaraan = kewarganegaraanC.text;
    anggota.nowali = int.tryParse(nowaliC.text);
    kk.rt = int.tryParse(rtC.text);
    kk.rw = int.tryParse(rwC.text);
    anggota.goldarah = selectGoldarah;
    anggota.aktalahir = selectedAktalahir;
    anggota.noakta = noaktalahirC.text;
    anggota.orgagama = orgagamaC.text;
    anggota.noaktakawin = noaktakawinC.text;
    anggota.aktakawin = selectedAktakawin;
    anggota.tanggalkawin = selectedTanggalkawin;
    anggota.aktacerai = selectedAktacerai;
    anggota.noaktacerai = noaktaceraiC.text;
    anggota.tanggalcerai = selectedTanggalcerai;
    anggota.statuskeluarga = selectedHubungan;
    anggota.cacat = selectedCacat;
    anggota.jeniscacat = selectedJenisCacat;
    anggota.pendidikan = selectedPendidikan;
    anggota.noitas = noitasC.text;
    anggota.tempatitas = tempatItasC.text;
    anggota.tanggalterbititas = selectedTanggalTerbitItas;
    anggota.tanggalitas = selectedTanggalItas;
    anggota.tempatpertama = tempatPertamaC.text;
    anggota.tanggalpertama = selectedTanggalpertama;
    anggota.nikayah = int.tryParse(nikayahC.text);
    anggota.namaibu = namaibuC.text;
    anggota.namaayah = namaayahC.text;
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
    absen.nama = namalengkapC.text;
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
    namakepalaC = TextEditingController();
    namasponsorC = TextEditingController();
    namaayahC = TextEditingController();
    namaibuC = TextEditingController();
    kodeposC = TextEditingController();
    jumkeluargaC = TextEditingController();
    teleponC = TextEditingController();
    gelardepanC = TextEditingController();
    gelarbelakangC = TextEditingController();
    nopasporC = TextEditingController();
    tempatC = TextEditingController();
    pekerjaanC = TextEditingController();
    nikibuC = TextEditingController();
    nikayahC = TextEditingController();
    noitasC = TextEditingController();
    tempatItasC = TextEditingController();
    tempatPertamaC = TextEditingController();
    alamatC = TextEditingController();
    alamatsponsorC = TextEditingController();
    rtC = TextEditingController();
    rwC = TextEditingController();
    nowaliC = TextEditingController();
    noaktalahirC = TextEditingController();
    noaktakawinC = TextEditingController();
    noaktaceraiC = TextEditingController();
    orgagamaC = TextEditingController();
    kewarganegaraanC = TextEditingController();
    nikC = TextEditingController();
    kkC = TextEditingController();
    emailC = TextEditingController();
    rxKK.bindStream(KK().listKK());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    namalengkapC.clear();
    namakepalaC.clear();
    namasponsorC.clear();
    namaayahC.clear();
    namaibuC.clear();
    kodeposC.clear();
    jumkeluargaC.clear();
    teleponC.clear();
    gelardepanC.clear();
    gelarbelakangC.clear();
    nopasporC.clear();
    tempatC.clear();
    pekerjaanC.clear();
    nikibuC.clear();
    nikayahC.clear();
    noitasC.clear();
    tempatItasC.clear();
    tempatPertamaC.clear();
    alamatC.clear();
    alamatsponsorC.clear();
    rtC.clear();
    rwC.clear();
    nowaliC.clear();
    noaktalahirC.clear();
    noaktakawinC.clear();
    noaktaceraiC.clear();
    orgagamaC.clear();
    kewarganegaraanC.clear();
    nikC.clear();
    kkC.clear();
    emailC.clear();
  }
}
