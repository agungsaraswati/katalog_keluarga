// lib/models/anggota_model.dart
class AnggotaModel {
  final int? id;
  final String nama;
  final String? namaLengkap;
  final String hubungan;
  final String tanggalLahir;
  final String? fotoProfil;
  final String? telepon;
  final String? email;
  final String? nik;

  AnggotaModel({
    this.id,
    required this.nama,
    required this.hubungan,
    required this.tanggalLahir,
    this.namaLengkap,
    this.fotoProfil,
    this.telepon,
    this.email,
    this.nik,
  });

  factory AnggotaModel.fromJson(Map<String, dynamic> json) {
    return AnggotaModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      // API may use 'nama' or 'nama_lengkap'
      nama: (json['nama'] ?? json['nama_lengkap'] ?? '').toString(),
      namaLengkap: json['nama_lengkap'] ?? null,
      hubungan: json['hubungan'] ?? '',
      tanggalLahir: json['tanggal_lahir'] ?? '',
      fotoProfil: json['foto_profil'] ?? json['foto'] ?? null,
      telepon: json['telepon'] ?? json['phone'] ?? null,
      nik: json['nik'] ?? null,
      email: json['email'] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nama': nama,
      if (namaLengkap != null) 'nama_lengkap': namaLengkap,
      'hubungan': hubungan,
      'tanggal_lahir': tanggalLahir,
      if (fotoProfil != null) 'foto_profil': fotoProfil,
      if (telepon != null) 'telepon': telepon,
      if (email != null) 'email': email,
      if (nik != null) 'nik': nik,
    };
  }
}
