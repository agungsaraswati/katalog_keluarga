// lib/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'halaman_utama.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HalamanUtama()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F6), // Warna latar belakang putih gading
      body: Stack(
        children: [
          // Lingkaran Besar Kiri Atas
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFFF9DC24), // Kuning Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Lingkaran Kecil Kanan Atas
          Positioned(
            top: 60,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFF9DC24), // Kuning Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Lingkaran Sedang Kiri Tengah
          Positioned(
            top: MediaQuery.of(context).size.height / 3,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFF9DC24), // Kuning Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Lingkaran Besar Kanan Bawah
          Positioned(
            bottom: -70,
            right: -70,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFF9DC24), // Kuning Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Lingkaran Kecil Kiri Bawah
          Positioned(
            bottom: 50,
            left: 30,
            child: Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFFF9DC24), // Kuning Figma
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Konten Utama (Ikon & Teks)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.family_restroom_rounded, size: 100, color: Color(0xFF232B3B)), // Warna ikon gelap
                SizedBox(height: 20),
                Text(
                  'Choise Family', // Ganti teks sesuai Figma
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF232B3B), // Warna teks gelap
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}