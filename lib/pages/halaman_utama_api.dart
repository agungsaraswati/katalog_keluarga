// lib/pages/halaman_utama_api.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../models/anggota_model.dart';
import '../services/anggota_service.dart';

class HalamanUtamaApi extends StatefulWidget {
  const HalamanUtamaApi({super.key});

  @override
  State<HalamanUtamaApi> createState() => _HalamanUtamaApiState();
}

class _HalamanUtamaApiState extends State<HalamanUtamaApi> {
  late final AnggotaService service;
  late Future<List<AnggotaModel>> futureAnggota;

  @override
  void initState() {
    super.initState();
    // Auto-select base URL for web vs other platforms.
    // For web (Edge/Chrome), use localhost so the browser can reach the local PHP server.
    final base = kIsWeb
        ? 'http://localhost:8000/api/keluarga'
        : 'http://000.0.0.0:8000/api/keluarga';
    service = AnggotaService(baseUrl: base);
    futureAnggota = service.fetchAnggota();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Keluarga (API)')),
      body: FutureBuilder<List<AnggotaModel>>(
        future: futureAnggota,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // Show friendly guidance for common web errors (CORS or connection refused)
            final err = snapshot.error.toString();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: $err',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Jika menjalankan di web, pastikan API Laravel berjalan di http://localhost:8000 dan CORS diizinkan.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Untuk development, jalankan: php artisan serve --host=0.0.0.0 --port=8000',
                    ),
                  ],
                ),
              ),
            );
          }
          final apiList = snapshot.data ?? [];
          if (apiList.isEmpty)
            return const Center(child: Text('Tidak ada data'));

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            itemCount: apiList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final a = apiList[index];

              // choose image provider: network if url, otherwise asset fallback
              final imageProvider =
                  (a.fotoProfil != null && a.fotoProfil!.startsWith('http'))
                  ? NetworkImage(a.fotoProfil!) as ImageProvider
                  : AssetImage(_assetForHubungan(a.hubungan));

              return ListTile(
                tileColor: const Color(0xFFEFEFEF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: imageProvider,
                  backgroundColor: Colors.grey[300],
                ),
                title: Text(
                  a.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${a.hubungan} • ${a.tanggalLahir}'),
                onTap: () {
                  // simple details dialog instead of full HalamanDetail
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(a.nama),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hubungan: ${a.hubungan}'),
                          Text('Lahir: ${a.tanggalLahir}'),
                          if (a.telepon != null) Text('Tel: ${a.telepon}'),
                          if (a.email != null) Text('Email: ${a.email}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Tutup'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  String _assetForHubungan(String hubungan) {
    final key = hubungan.toLowerCase();
    if (key.contains('ayah') || key.contains('bapak'))
      return 'assets/images/ayah.jpg';
    if (key.contains('ibu') || key.contains('emak'))
      return 'assets/images/ibu.jpg';
    if (key.contains('pertama')) return 'assets/images/anak_pertama.png';
    if (key.contains('kedua')) return 'assets/images/anak_kedua.jpg';
    if (key.contains('ketiga')) return 'assets/images/anak_ketiga.jpeg';
    if (key.contains('keempat')) return 'assets/images/anak_keempat.png';
    return 'assets/images/anak_pertama.png';
  }
}
