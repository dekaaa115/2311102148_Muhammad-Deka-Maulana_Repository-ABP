import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanPengaturan extends StatefulWidget {
  const HalamanPengaturan({super.key});
  @override
  State<HalamanPengaturan> createState() => _HalamanPengaturanState();
}

class _HalamanPengaturanState extends State<HalamanPengaturan> {
  bool _notif = true, _dark = false, _suara = true;

  Widget _switchTile(String title, String sub, IconData icon, bool val, Function(bool) cb) =>
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: SwitchListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          secondary: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Icon(icon, color: Colors.blueAccent)
          ),
          value: val,
          activeColor: Colors.white,
          activeTrackColor: Colors.blueAccent,
          inactiveThumbColor: Colors.grey.shade400,
          inactiveTrackColor: Colors.grey.shade200,
          onChanged: (v) {
            setState(() => cb(v));
            popupAlert(context,
              judul: title,
              isi: '$title telah ${v ? "diaktifkan" : "dinonaktifkan"}.',
              icon: v ? Icons.check_circle : Icons.cancel,
              iconColor: v ? Colors.green : Colors.grey,
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: const Color(0xFF2C3E50),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 12),
            child: Text('PREFERENSI',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2))),
          _switchTile('Notifikasi', 'Terima pemberitahuan aplikasi', Icons.notifications_active_outlined, _notif, (v) => _notif = v),
          _switchTile('Mode Gelap', 'Aktifkan tema dark mode', Icons.dark_mode_outlined, _dark, (v) => _dark = v),
          _switchTile('Suara', 'Aktifkan efek suara aplikasi', Icons.volume_up_outlined, _suara, (v) => _suara = v),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 8, bottom: 12),
            child: Text('AKUN',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.2))),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(Icons.lock_reset, color: Colors.orange)
                  ),
                  title: const Text('Reset Pengaturan', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Kembalikan ke setelan awal', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () => popupAlert(context,
                    judul: 'Reset Pengaturan?',
                    isi: 'Semua pengaturan akan dikembalikan ke nilai default.',
                    icon: Icons.warning_amber_rounded, iconColor: Colors.orange,
                    tombolBatal: 'Batal', tombolOk: 'Reset',
                    onOk: () {
                      setState(() { _notif = true; _dark = false; _suara = true; });
                      snack(context, 'Pengaturan berhasil direset!', color: Colors.orange);
                    },
                  ),
                ),
                Divider(height: 1, color: Colors.grey.shade200, indent: 70),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(Icons.logout, color: Colors.red)
                  ),
                  title: const Text('Keluar Akun', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  subtitle: const Text('Logout dari aplikasi', style: TextStyle(fontSize: 12)),
                  onTap: () => popupAlert(context,
                    judul: 'Keluar Akun?',
                    isi: 'Apakah kamu yakin ingin logout dari aplikasi?',
                    icon: Icons.logout, iconColor: Colors.red,
                    tombolBatal: 'Batal', tombolOk: 'Logout',
                    onOk: () => snack(context, 'Berhasil logout', color: Colors.red),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}