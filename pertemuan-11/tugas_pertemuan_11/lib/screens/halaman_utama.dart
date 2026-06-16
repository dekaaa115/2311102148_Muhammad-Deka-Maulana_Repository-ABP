import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int _tabIdx = 0;
  String _dropdown = 'Flutter';

  static const _menu = [
    {'label': 'Profil',     'icon': Icons.person,        'route': '/profil',     'color': Colors.purple},
    {'label': 'Form',       'icon': Icons.edit_note,     'route': '/form',       'color': Colors.teal},
    {'label': 'Galeri',     'icon': Icons.photo_library, 'route': '/galeri',     'color': Colors.orange},
    {'label': 'Pengaturan', 'icon': Icons.settings,      'route': '/pengaturan', 'color': Colors.grey},
    {'label': 'Notifikasi', 'icon': Icons.notifications, 'route': '/notifikasi', 'color': Colors.red},
    {'label': 'Tentang',    'icon': Icons.info_outline,  'route': '/tentang',    'color': Colors.indigo},
  ];

  void _goto(String route, String label) {
    Navigator.pushNamed(context, route);
    snack(context, 'Membuka $label…');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gabungan Menu & Tombol'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Colors.blueAccent, Colors.lightBlue]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.blueAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
              ]
            ),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.transparent,
                    child: Icon(Icons.person, size: 45, color: Colors.white)),
              ),
              const SizedBox(height: 12),
              const Text('Muhammad Deka Maulana',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text('2311102148', style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text('Tab aktif: $_tabIdx', style: const TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.touch_app, size: 24),
              label: const Text('Klik Saya', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () => popupAlert(context,
                judul: 'Button Ditekan!',
                isi: 'Kamu berhasil menekan tombol ini.',
                icon: Icons.check_circle,
                iconColor: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 1.5),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                ]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _dropdown,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.blueAccent),
                style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
                items: ['Flutter', 'Laravel', 'UI Design']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) {
                  setState(() => _dropdown = v!);
                  popupAlert(context,
                    judul: 'Pilihan Diubah',
                    isi: 'Kamu memilih: $v',
                    icon: Icons.swap_horiz,
                    iconColor: Colors.indigo,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('Pilihan saat ini: $_dropdown', style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 28),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Menu Halaman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: _menu.map((m) {
              final color = m['color'] as Color;
              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => _goto(m['route'] as String, m['label'] as String),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: color.withOpacity(0.15)),
                      boxShadow: [
                        BoxShadow(color: color.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 4))
                      ]),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle
                      ),
                      child: Icon(m['icon'] as IconData, color: color, size: 28)
                    ),
                    const SizedBox(height: 10),
                    Text(m['label'] as String,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                  ]),
                ),
              );
            }).toList(),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
          ]
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BottomNavigationBar(
            currentIndex: _tabIdx,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            onTap: (i) {
              setState(() => _tabIdx = i);
              popupAlert(context,
                judul: 'Tab Dipilih',
                isi: 'Kamu menekan tab: ${['Home', 'Button', 'Profil'][i]}',
                icon: Icons.tab, iconColor: Colors.blueAccent,
              );
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded),         label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.smart_button_rounded), label: 'Button'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded),       label: 'Profil'),
            ],
          ),
        ),
      ),
    );
  }
}