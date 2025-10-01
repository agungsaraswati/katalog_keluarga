// lib/anggota_keluarga.dart
class AnggotaKeluarga {
  final String nama;
  final String hubungan;
  final String tanggalLahir;
  final String fotoProfil;
  final String telepon;
  final String email;

  AnggotaKeluarga({
    required this.nama,
    required this.hubungan,
    required this.tanggalLahir,
    required this.fotoProfil,
    this.telepon = '-', // Default value jika tidak diisi
    this.email = '-',   // Default value jika tidak diisi
  });
}