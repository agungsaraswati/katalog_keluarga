// lib/main.dart
import 'package:flutter/material.dart';
import 'pages/splash_screen.dart'; // Impor splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Keluarga',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', // Contoh font. Jika tidak punya, hapus baris ini
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
