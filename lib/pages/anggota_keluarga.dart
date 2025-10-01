// lib/anggota_keluarga.dart
class AnggotaKeluarga {
  final String nama;
  final String? namaLengkap;
  final String hubungan;
  final String tanggalLahir;
  final String fotoProfil;
  final String telepon;
  final String email;
  final String? nik;

  AnggotaKeluarga({
    required this.nama,
    this.namaLengkap,
    required this.hubungan,
    required this.tanggalLahir,
    required this.fotoProfil,
    this.telepon = '-', // Default value jika tidak diisi
    this.email = '-', // Default value jika tidak diisi
    this.nik,
  });
}
