import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanProfil extends StatelessWidget {
  const HalamanProfil({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => popupAlert(context,
      judul: 'Selamat Datang!',
      isi: 'Kamu membuka halaman Profil.',
      icon: Icons.waving_hand, iconColor: Colors.purple,
    ));

    final info = [
      [Icons.school,        'Jurusan',  'Teknik Informatika'],
      [Icons.calendar_today,'Angkatan', '2023'],
      [Icons.location_on,   'Kota',     'Purwokerto'],
      [Icons.email,         'Email',    'muhamamddeka115@gmail.com'],
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.purple.withOpacity(0.3), width: 3),
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified, color: Colors.purple, size: 24),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text('Muhammad Deka Maulana',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
          ),
          const Center(
            child: Text('2311102148',
                style: TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 32),
          ...info.map((r) => Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4))
              ]
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Icon(r[0] as IconData, color: Colors.purple)
              ),
              title: Text(r[1] as String, style: const TextStyle(fontSize: 13, color: Colors.grey)),
              subtitle: Text(r[2] as String,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
            ),
          )),
          const SizedBox(height: 24),
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.edit_rounded),
              label: const Text('Edit Profil', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () => popupAlert(context,
                judul: 'Edit Profil',
                isi: 'Fitur edit profil akan segera tersedia di versi berikutnya.',
                icon: Icons.edit_note, iconColor: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}