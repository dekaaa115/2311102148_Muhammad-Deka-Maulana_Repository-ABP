import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanNotifikasi extends StatefulWidget {
  const HalamanNotifikasi({super.key});
  @override
  State<HalamanNotifikasi> createState() => _HalamanNotifikasiState();
}

class _HalamanNotifikasiState extends State<HalamanNotifikasi> {
  final List<Map<String, dynamic>> _list = [
    {'judul': 'Selamat Datang!',   'isi': 'Aplikasi berhasil dijalankan.',  'icon': Icons.celebration,     'color': Colors.green,  'dibaca': false},
    {'judul': 'Update Tersedia',   'isi': 'Versi 1.1.0 siap diunduh.',      'icon': Icons.system_update,   'color': Colors.blue,   'dibaca': false},
    {'judul': 'Pengingat Tugas',   'isi': 'Deadline besok pukul 23:59.',    'icon': Icons.assignment_late, 'color': Colors.orange, 'dibaca': true},
    {'judul': 'Pesan Baru',        'isi': 'Ada pesan masuk dari dosen.',    'icon': Icons.mail,            'color': Colors.purple, 'dibaca': false},
    {'judul': 'Peringatan Sistem', 'isi': 'Login dari perangkat baru.',     'icon': Icons.security,        'color': Colors.red,    'dibaca': true},
  ];

  void _bukaNotif(int i) {
    final n = _list[i];
    setState(() => _list[i]['dibaca'] = true);
    popupAlert(context,
      judul: n['judul'] as String,
      isi: n['isi'] as String,
      icon: n['icon'] as IconData,
      iconColor: n['color'] as Color,
    );
  }

  @override
  Widget build(BuildContext context) {
    final unread = _list.where((n) => !(n['dibaca'] as bool)).length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        actions: [
          if (unread > 0)
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: Badge(
                  label: Text('$unread'),
                  backgroundColor: Colors.white,
                  textColor: Colors.redAccent,
                  child: const Icon(Icons.notifications, size: 26)
                ),
              ),
            )
        ],
      ),
      body: _list.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Tidak ada notifikasi', style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w600))
                ],
              ))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: _list.length,
              itemBuilder: (ctx, i) {
                final n = _list[i];
                final color = n['color'] as Color;
                final dibaca = n['dibaca'] as bool;
                return Dismissible(
                  key: ValueKey('$i-${n['judul']}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Icon(Icons.delete_sweep, color: Colors.white, size: 32),
                  ),
                  confirmDismiss: (_) async {
                    bool konfirm = false;
                    await popupAlert(ctx,
                      judul: 'Hapus Notifikasi?',
                      isi: 'Notifikasi "${n['judul']}" akan dihapus permanen.',
                      icon: Icons.delete_forever, iconColor: Colors.redAccent,
                      tombolBatal: 'Batal', tombolOk: 'Hapus',
                      onOk: () => konfirm = true,
                    );
                    return konfirm;
                  },
                  onDismissed: (_) {
                    setState(() => _list.removeAt(i));
                    snack(context, 'Notifikasi dihapus', color: Colors.redAccent);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: dibaca ? Colors.white : color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: dibaca ? Border.all(color: Colors.grey.withOpacity(0.2)) : Border.all(color: color.withOpacity(0.5), width: 1.5),
                      boxShadow: dibaca ? [] : [BoxShadow(color: color.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      onTap: () => _bukaNotif(i),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          shape: BoxShape.circle
                        ),
                        child: Icon(n['icon'] as IconData, color: color)
                      ),
                      title: Text(n['judul'] as String,
                          style: TextStyle(fontSize: 16, fontWeight: dibaca ? FontWeight.w600 : FontWeight.bold, color: Colors.black87)),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(n['isi'] as String, style: const TextStyle(fontSize: 13)),
                      ),
                      trailing: dibaca
                          ? null
                          : Container(
                              width: 12, height: 12,
                              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                            ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 0,
        icon: const Icon(Icons.done_all), label: const Text('Baca Semua', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () => popupAlert(context,
          judul: 'Tandai Semua Dibaca?',
          isi: 'Semua notifikasi akan ditandai sebagai sudah dibaca.',
          icon: Icons.done_all, iconColor: Colors.redAccent,
          tombolBatal: 'Batal', tombolOk: 'Ya, Tandai',
          onOk: () {
            setState(() { for (var n in _list) n['dibaca'] = true; });
            snack(context, 'Semua sudah dibaca', color: Colors.green);
          },
        ),
      ),
    );
  }
}