// lib/halaman_utama.dart
import 'package:flutter/material.dart';
import 'anggota_keluarga.dart';
import 'halaman_detail.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  // Data keluarga (pastikan path gambar sudah benar)
  final List<AnggotaKeluarga> daftarKeluarga = [
    AnggotaKeluarga(
        nama: 'Gung Aji',
        hubungan: 'Ayah',
        tanggalLahir: '08 Agustus 1972',
        fotoProfil: 'assets/images/ayah.jpg',
        telepon: '081234567890',
        email: 'gungaji@email.com'),
    AnggotaKeluarga(
        nama: 'Bu Jro',
        hubungan: 'Ibu',
        tanggalLahir: '20 April 1977',
        fotoProfil: 'assets/images/ibu.jpg',
        telepon: '081234567891',
        email: 'bujro@email.com'),
    AnggotaKeluarga(
        nama: 'Gunggek Saras',
        hubungan: 'Anak Pertama',
        tanggalLahir: '25 Desember 2004',
        fotoProfil: 'assets/images/anak_pertama.png',
        telepon: '081234567892',
        email: 'gunggeksaras@email.com'),
    AnggotaKeluarga(
        nama: 'Gunggek Widya',
        hubungan: 'Anak Kedua',
        tanggalLahir: '30 Juni 2026',
        fotoProfil: 'assets/images/anak_kedua.jpg',
        telepon: '081234567893',
        email: 'gunggekwidya@email.com'),
    AnggotaKeluarga(
        nama: 'Gung Lanang',
        hubungan: 'Anak Ketiga',
        tanggalLahir: '01 Maret 2010',
        fotoProfil: 'assets/images/anak_ketiga.jpeg',
        telepon: '081234567894',
        email: 'gunglanang@email.com'),
    AnggotaKeluarga(
        nama: 'Gunggek Cantika',
        hubungan: 'Anak Keempat',
        tanggalLahir: '16 Juni 2012',
        fotoProfil: 'assets/images/anak_keempat.png',
        telepon: '081234567895',
        email: 'gunggekcantika@email.com'),
    // ...tambahkan anggota lain jika perlu
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            // --- HEADER KUSTOM BARU (DI TENGAH) ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column( // UBAH: dari Row menjadi Column
                children: const [
                  Icon(
                    Icons.family_restroom_rounded,
                    color: Color(0xFF232B3B),
                    size: 40, // Sedikit diperbesar
                  ),
                  SizedBox(height: 8), // Beri jarak antara ikon dan teks
                  Text(
                    'Choice Family',
                    style: TextStyle(
                      color: Color(0xFF232B3B),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            
            // --- DAFTAR KELUARGA ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                itemCount: daftarKeluarga.length,
                itemBuilder: (context, index) {
                  final anggota = daftarKeluarga[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HalamanDetail(anggota: anggota),
                        ),
                      );
                    },
                    child: Card(
                      color: const Color(0xFFE8E8E8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(anggota.fotoProfil),
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anggota.nama,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF232B3B)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    anggota.hubungan,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}