import 'package:flutter/material.dart';
import 'screens/halaman_utama.dart';
import 'screens/halaman_profil.dart';
import 'screens/halaman_form.dart';
import 'screens/halaman_galeri.dart';
import 'screens/halaman_pengaturan.dart';
import 'screens/halaman_notifikasi.dart';
import 'screens/halaman_tentang.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blueAccent,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => const HalamanUtama(),
        '/profil': (ctx) => const HalamanProfil(),
        '/form': (ctx) => const HalamanForm(),
        '/galeri': (ctx) => const HalamanGaleri(),
        '/pengaturan': (ctx) => const HalamanPengaturan(),
        '/notifikasi': (ctx) => const HalamanNotifikasi(),
        '/tentang': (ctx) => const HalamanTentang(),
      },
    );
  }
}
