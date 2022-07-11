import 'dart:io';

import 'package:erte/app/const/color.dart';
import 'package:erte/app/data/models/absen.dart';
import 'package:erte/app/data/models/form_kk.dart';
import 'package:erte/app/data/models/s_pengantar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

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

  Rx<DateTime?> _selectedTanggallahir = DateTime.now().obs;
  DateTime? get selectedTanggallahir => _selectedTanggallahir.value;
  set selectedTanggallahir(DateTime? value) =>
      _selectedTanggallahir.value = value;

  tanggalLahir(dynamic context) async {
    selectedTanggallahir = await showDatePicker(
            context: context,
            initialDate: selectedTanggallahir ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggallahir;
  }

  Rx<DateTime?> _selectedTanggalItas = DateTime.now().obs;
  DateTime? get selectedTanggalItas => _selectedTanggalItas.value;
  set selectedTanggalItas(DateTime? value) =>
      _selectedTanggalItas.value = value;

  tanggalItas(dynamic context) async {
    selectedTanggalItas = await showDatePicker(
            context: context,
            initialDate: selectedTanggalItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalItas;
  }

  Rx<DateTime?> _selectedTanggalTerbitItas = DateTime.now().obs;
  DateTime? get selectedTanggalTerbitItas => _selectedTanggalTerbitItas.value;
  set selectedTanggalTerbitItas(DateTime? value) =>
      _selectedTanggalTerbitItas.value = value;

  tanggalTerbitItas(dynamic context) async {
    selectedTanggalTerbitItas = await showDatePicker(
            context: context,
            initialDate: selectedTanggalTerbitItas ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalTerbitItas;
  }

  Rx<DateTime?> _selectedTanggalkawin = DateTime.now().obs;
  DateTime? get selectedTanggalkawin => _selectedTanggalkawin.value;
  set selectedTanggalkawin(DateTime? value) =>
      _selectedTanggalkawin.value = value;

  tanggalkawin(dynamic context) async {
    selectedTanggalkawin = await showDatePicker(
            context: context,
            initialDate: selectedTanggalkawin ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalkawin;
  }

  Rx<DateTime?> _selectedTanggalcerai = DateTime.now().obs;
  DateTime? get selectedTanggalcerai => _selectedTanggalcerai.value;
  set selectedTanggalcerai(DateTime? value) =>
      _selectedTanggalcerai.value = value;

  tanggalcerai(dynamic context) async {
    selectedTanggalcerai = await showDatePicker(
            context: context,
            initialDate: selectedTanggalcerai ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalcerai;
  }

  Rx<DateTime?> _selectedTanggalpaspor = DateTime.now().obs;
  DateTime? get selectedTanggalpaspor => _selectedTanggalpaspor.value;
  set selectedTanggalpaspor(DateTime? value) =>
      _selectedTanggalpaspor.value = value;

  tanggalPaspor(dynamic context) async {
    selectedTanggalpaspor = await showDatePicker(
            context: context,
            initialDate: selectedTanggalpaspor ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalpaspor;
  }

  Rx<DateTime?> _selectedTanggalpertama = DateTime.now().obs;
  DateTime? get selectedTanggalpertama => _selectedTanggalpertama.value;
  set selectedTanggalpertama(DateTime? value) =>
      _selectedTanggalpertama.value = value;

  tanggalPertama(dynamic context) async {
    selectedTanggalpertama = await showDatePicker(
            context: context,
            initialDate: selectedTanggalpertama ?? DateTime.now(),
            // initialDatePickerMode: DatePickerMode.year,
            firstDate: DateTime(1900),
            lastDate: DateTime(2050)) ??
        selectedTanggalpertama;
  }

  var _selectedKelamin = ''.obs;
  String get selectedKelamin => _selectedKelamin.value;
  set selectedKelamin(String value) => _selectedKelamin.value = value;

  var _selectedAktalahir = ''.obs;
  String get selectedAktalahir => _selectedAktalahir.value;
  set selectedAktalahir(String value) => _selectedAktalahir.value = value;

  var _selectedAktakawin = ''.obs;
  String get selectedAktakawin => _selectedAktakawin.value;
  set selectedAktakawin(String value) => _selectedAktakawin.value = value;

  var _selectedAktacerai = ''.obs;
  String get selectedAktacerai => _selectedAktacerai.value;
  set selectedAktacerai(String value) => _selectedAktacerai.value = value;

  var _selectedCacat = ''.obs;
  String get selectedCacat => _selectedCacat.value;
  set selectedCacat(String value) => _selectedCacat.value = value;

  var _selectedDataKeluarga = ''.obs;
  String get selectedDataKeluarga => _selectedDataKeluarga.value;
  set selectedDataKeluarga(String value) => _selectedDataKeluarga.value = value;

  List<String> listPendidikan = [
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
  String? selectedPendidikan;

  List<String> listAgama = [
    "Islam",
    "Katholik",
    "Kristen",
    "Hindu",
    "Budha",
    "Konghucu"
  ];
  String? selectedAgama;

  List<String> listJenisCacat = [
    "Cacat Fisik",
    "Cacat Netra/Buta",
    "Cacat Rungu/Bicara",
    "Cacat Mental/Jiwa",
    "Cacat Fisik dan Mental",
    "Cacat Lainnya"
  ];
  String? selectedJenisCacat;

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
    "Asisten Ahli"
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

  Future store(KK kk) async {
    isSaving = true;
    kk.datakeluarga = selectedDataKeluarga;
    kk.jumkeluarga = int.tryParse(jumkeluargaC.text);
    kk.namakepala = namakepalaC.text;
    kk.namalengkap = namalengkapC.text;
    kk.gelarbelakang = gelarbelakangC.text;
    kk.gelardepan = gelardepanC.text;
    kk.nopaspor = nopasporC.text;
    kk.tanggalpaspor = selectedTanggalpaspor;
    kk.namasponsor = namasponsorC.text;
    kk.tipesponsor = selectedSponsor;
    kk.alamatsponsor = alamatsponsorC.text;
    kk.kodeppos = int.tryParse(kodeposC.text);
    kk.telepon = int.tryParse(teleponC.text);
    kk.pekerjaan = selectedPekerjaan;
    kk.agama = selectedAgama;
    kk.statuskawin = selectedStatus;
    kk.alamat = alamatC.text;
    kk.kelamin = selectedKelamin;
    kk.nikibu = int.tryParse(nikibuC.text);
    kk.tanggallahir = selectedTanggallahir;
    kk.tempatlahir = tempatC.text;
    kk.kewarganegaraan = kewarganegaraanC.text;
    kk.nowali = int.tryParse(nowaliC.text);
    kk.rt = int.tryParse(rtC.text);
    kk.rw = int.tryParse(rwC.text);
    kk.goldarah = selectGoldarah;
    kk.aktalahir = selectedAktalahir;
    kk.noakta = noaktalahirC.text;
    kk.orgagama = orgagamaC.text;
    kk.noaktakawin = noaktakawinC.text;
    kk.aktakawin = selectedAktakawin;
    kk.tanggalkawin = selectedTanggalkawin;
    kk.aktacerai = selectedAktacerai;
    kk.noaktacerai = noaktaceraiC.text;
    kk.tanggalcerai = selectedTanggalcerai;
    kk.statuskeluarga = selectedHubungan;
    kk.cacat = selectedCacat;
    kk.jeniscacat = selectedJenisCacat;
    kk.pendidikan = selectedPendidikan;
    kk.noitas = noitasC.text;
    kk.tempatitas = tempatItasC.text;
    kk.tanggalterbititas = selectedTanggalTerbitItas;
    kk.tanggalitas = selectedTanggalItas;
    kk.tempatpertama = tempatPertamaC.text;
    kk.tanggalpertama = selectedTanggalpertama;
    kk.nikayah = int.tryParse(nikayahC.text);
    kk.namaibu = namaibuC.text;
    kk.namaayah = namaayahC.text;
    kk.email = emailC.text;
    if (kk.id == null) {
      kk.waktu = DateTime.now();
    }
    try {
      await kk.save();
      Get.defaultDialog(
          title: "Berhasil",
          textConfirm: "Oke",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          buttonColor: primary,
          cancelTextColor: primary,
          confirmTextColor: white,
          titleStyle: TextStyle(color: primary),
          middleTextStyle: TextStyle(color: primary));
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

  var keperluan = "Pengurusan KK baru";

  Future storepengantar(Pengantar pengantar) async {
    isSaving = true;
    pengantar.nama = namakepalaC.text;
    pengantar.pekerjaan = selectedPekerjaan;
    pengantar.agama = selectedAgama;
    pengantar.status = selectedStatus;
    pengantar.alamat = alamatC.text;
    pengantar.pendidikan = selectedPendidikan;
    pengantar.keperluan1 = keperluan;
    // pengantar.keperluan2 = selectedKeperluan2;
    // pengantar.kk = int.tryParse(kkC.text);
    pengantar.wni = selectedWNI;
    pengantar.kelamin = selectedKelamin;
    // pengantar.nik = int.tryParse(nikC.text);
    pengantar.tanggallahir = selectedTanggallahir;
    pengantar.tempatlahir = tempatC.text;
    pengantar.email = emailC.text;
    if (pengantar.id == null) {
      pengantar.waktu = DateTime.now();
    }
    try {
      await pengantar.save();
    } catch (e) {
      print(e);
    } finally {
      isSaving = false;
    }
  }

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
    emailC = TextEditingController();
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
    emailC.clear();
  }
}
