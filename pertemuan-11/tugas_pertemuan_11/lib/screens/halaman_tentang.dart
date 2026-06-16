import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanTentang extends StatelessWidget {
  const HalamanTentang({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => popupAlert(context,
      judul: 'Tentang Aplikasi',
      isi: 'Ini adalah aplikasi Flutter buatan Muhammad Deka Maulana untuk tugas praktikum.',
      icon: Icons.info_outline, iconColor: Colors.indigo,
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Colors.indigo, Colors.blueAccent],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.indigo.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))
                ]),
            child: const Column(children: [
              Icon(Icons.layers_outlined, size: 70, color: Colors.white),
              SizedBox(height: 16),
              Text('Aplikasi Flutter', style: TextStyle(fontSize: 26,
                  fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
              SizedBox(height: 4),
              Text('Versi 1.0.0', style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
            ]),
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo.withOpacity(0.1))
            ),
            child: const Text('Aplikasi ini dibuat sebagai tugas praktikum mata kuliah '
                'Pengembangan Aplikasi Mobile. Menampilkan fitur navigasi multi-halaman, '
                'form validasi, dan popup alert notification dengan antarmuka yang lebih modern.',
                style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87), textAlign: TextAlign.justify),
          ),
          const SizedBox(height: 24),
          ...[
            [Icons.person_outline,   'Developer', 'Muhammad Deka Maulana'],
            [Icons.badge_outlined,   'NIM',       '2311102148'],
            [Icons.code,             'Framework', 'Flutter & Dart'],
            [Icons.school_outlined,  'Kampus',    'Telkom University Purwokerto'],
          ].map((r) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
              ]
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Icon(r[0] as IconData, color: Colors.indigo)
              ),
              title: Text(r[1] as String, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              subtitle: Text(r[2] as String,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.star_rounded, size: 24),
              label: const Text('Beri Rating', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () => popupAlert(context,
                judul: 'Terima Kasih! ⭐',
                isi: 'Rating kamu sangat berarti untuk pengembangan aplikasi ini.',
                icon: Icons.star_rounded, iconColor: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
