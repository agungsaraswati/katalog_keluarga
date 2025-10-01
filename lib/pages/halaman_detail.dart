// lib/halaman_detail.dart
import 'package:flutter/material.dart';
import 'anggota_keluarga.dart';

class HalamanDetail extends StatelessWidget {
  final AnggotaKeluarga anggota;

  const HalamanDetail({super.key, required this.anggota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232B3B),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 350.0,
            pinned: true,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              // UBAH: Gunakan Stack untuk mengatur posisi teks secara manual
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Gambar Latar
                  Image.asset(
                    anggota.fotoProfil,
                    fit: BoxFit.cover,
                    // Tambahkan gradasi agar teks lebih terbaca
                    color: Colors.black.withAlpha(102),
                    colorBlendMode: BlendMode.darken,
                  ),
                  // Teks Nama yang Diposisikan
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      anggota.nama,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28, // Perbesar sedikit sesuai Figma
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kartu Bio
                  Card(
                    color: const Color(0xFF3C4455),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            anggota.hubungan,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Lahir pada ${anggota.tanggalLahir}',
                            style: const TextStyle(fontSize: 16, color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Kartu Kontak
                  Card(
                    color: const Color(0xFF3C4455),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.phone, color: Colors.white70),
                          title: Text(
                            anggota.telepon,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const Divider(height: 1, indent: 16, endIndent: 16, color: Colors.white24),
                        ListTile(
                          leading: const Icon(Icons.email, color: Colors.white70),
                          title: Text(
                            anggota.email,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}