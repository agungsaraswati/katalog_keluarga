// lib/halaman_utama.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'anggota_keluarga.dart';
import 'halaman_detail.dart';
import '../models/anggota_model.dart';
import '../services/anggota_service.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  late final AnggotaService service;
  late Future<List<AnggotaModel>> futureAnggota;

  @override
  void initState() {
    super.initState();
    final base = kIsWeb
        ? 'http://localhost:8000/api/keluarga'
        : 'http://192.168.18.192:8000/api/keluarga';
    service = AnggotaService(baseUrl: base);
    futureAnggota = service.fetchAnggota();
  }

  // Pick a foto path: if API provided a URL, return it; otherwise pick local asset by hubungan
  String _pickFoto(AnggotaModel a) {
    final fp = a.fotoProfil;
    if (fp != null && fp.isNotEmpty) return fp;

    final key = a.hubungan.toLowerCase();
    if (key.contains('ayah') || key.contains('bapak'))
      return 'assets/images/ayah.jpg';
    if (key.contains('ibu') || key.contains('emak'))
      return 'assets/images/ibu.jpg';
    if (key.contains('anak') && key.contains('pertama'))
      return 'assets/images/anak_pertama.png';
    if (key.contains('anak') && key.contains('kedua'))
      return 'assets/images/anak_kedua.jpg';
    if (key.contains('anak') && key.contains('ketiga'))
      return 'assets/images/anak_ketiga.jpeg';
    if (key.contains('anak') && key.contains('keempat'))
      return 'assets/images/anak_keempat.png';
    // default
    return 'assets/images/anak_pertama.png';
  }

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
              child: Column(
                // UBAH: dari Row menjadi Column
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

            // --- DAFTAR KELUARGA (dari API) ---
            Expanded(
              child: FutureBuilder<List<AnggotaModel>>(
                future: futureAnggota,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final apiList = snapshot.data ?? [];
                  if (apiList.isEmpty)
                    return const Center(child: Text('Tidak ada data'));

                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: apiList.length,
                    itemBuilder: (context, index) {
                      final a = apiList[index];

                      // Map AnggotaModel -> AnggotaKeluarga
                      final anggota = AnggotaKeluarga(
                        nama: a.nama,
                        hubungan: a.hubungan,
                        tanggalLahir: a.tanggalLahir,
                        fotoProfil: _pickFoto(a),
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HalamanDetail(anggota: anggota),
                            ),
                          );
                        },
                        child: Card(
                          color: const Color(0xFFE8E8E8),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      anggota.fotoProfil.startsWith('http')
                                      ? NetworkImage(anggota.fotoProfil)
                                            as ImageProvider
                                      : AssetImage(anggota.fotoProfil),
                                  backgroundColor: Colors.grey[300],
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        anggota.nama,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF232B3B),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        anggota.hubungan,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                        ),
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
