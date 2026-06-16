<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM<br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>PERTEMUAN 11 - MOBILE</h3>
  <br />
  <img src="https://upload.wikimedia.org/wikipedia/commons/0/03/Logo_Telkom_University_potrait.png" alt="Logo" width="300"> 
  <br />
  <h3>Disusun Oleh :</h3>
  <p>
    <strong>Muhammad Deka Maulana</strong><br>
    <strong>2311102148</strong><br>
    <strong>PS1IF-11-REG04</strong>
  </p>
  <br />
  <h3>Dosen Pengampu :</h3>
  <p>
    <strong>Cahyo Prihantoro, S.Kom., M.Eng</strong>
  </p>
  <br />
    <h4>Asisten Praktikum :</h4>
    <strong>Gilang Saputra</strong> <br>
    <strong>Rangga Pradarrell Fathi</strong>
  <br />
  <h3>LABORATORIUM HIGH PERFORMANCE
 <br>PROGRAM STUDI TEKNIK INFORMATIKA<br>FAKULTAS INFORMATIKA<br>UNIVERSITAS TELKOM PURWOKERTO<br>2026</h3>
</div>

---

## LINK GIT
<a href="https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/tree/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11">
    https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/tree/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11 
</a>

---

## TUGAS PERTEMUAN 11 MOBILE
Tugas Praktikum Modul 7 - Mobile

Membaca modul 7 dan buat route dari source code yang dikasih kemarin (gdrive). Buat 6 sampai 7 halaman, dan tambahkan notifikasi. Untuk notifikasinya bebas modelnya mau kaya gimana.

Output yang dikumpulkan: Screenshot hasilnya, Source code terstruktur, dan Penjelasan singkat tiap widget.

## JAWABAN

### Source Code helpers/ui_helpers.dart
```dart
import 'package:flutter/material.dart';

void snack(BuildContext ctx, String msg, {Color color = Colors.blueAccent}) =>
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 1),
    ));

Future<void> popupAlert(
  BuildContext ctx, {
  required String judul,
  required String isi,
  IconData icon = Icons.info_outline,
  Color iconColor = Colors.blueAccent,
  String tombolOk = 'OK',
  String? tombolBatal,
  VoidCallback? onOk,
}) {
  return showDialog(
    context: ctx,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      title: Column(children: [
        CircleAvatar(
            radius: 36,
            backgroundColor: iconColor.withOpacity(.15),
            child: Icon(icon, color: iconColor, size: 36)),
        const SizedBox(height: 16),
        Text(judul,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ]),
      content: Text(isi,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      actions: [
        if (tombolBatal != null)
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: iconColor, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            onPressed: () => Navigator.pop(ctx),
            child: Text(tombolBatal, style: TextStyle(color: iconColor, fontWeight: FontWeight.bold)),
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: iconColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
          onPressed: () {
            Navigator.pop(ctx);
            onOk?.call();
          },
          child: Text(tombolOk, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    ),
  );
}
```

### Source Code main.dart
```dart
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
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':          (ctx) => const HalamanUtama(),
        '/profil':    (ctx) => const HalamanProfil(),
        '/form':      (ctx) => const HalamanForm(),
        '/galeri':    (ctx) => const HalamanGaleri(),
        '/pengaturan':(ctx) => const HalamanPengaturan(),
        '/notifikasi':(ctx) => const HalamanNotifikasi(),
        '/tentang':   (ctx) => const HalamanTentang(),
      },
    );
  }
}
```

### Source Code screens/halaman_utama.dart
```dart
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
```

### Source Code screens/halaman_profil.dart
```dart
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
```

### Source Code screens/halaman_form.dart
```dart
import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});
  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  final _key   = GlobalKey<FormState>();
  final _nama  = TextEditingController();
  final _email = TextEditingController();
  String _gender = 'Laki-laki';

  InputDecoration _deco(String label, IconData icon) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey),
    prefixIcon: Icon(icon, color: Colors.teal),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.teal, width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
  );

  void _submit() {
    if (!_key.currentState!.validate()) {
      popupAlert(context,
        judul: 'Form Tidak Lengkap',
        isi: 'Harap isi semua field yang wajib diisi sebelum mengirim.',
        icon: Icons.warning_amber_rounded, iconColor: Colors.red,
      );
      return;
    }
    popupAlert(context,
      judul: 'Data Terkirim!',
      isi: 'Nama: ${_nama.text}\nEmail: ${_email.text}\nGender: $_gender',
      icon: Icons.check_circle, iconColor: Colors.teal,
      tombolBatal: 'Tutup',
      tombolOk: 'Reset Form',
      onOk: () {
        _nama.clear(); _email.clear();
        setState(() => _gender = 'Laki-laki');
        snack(context, 'Form direset', color: Colors.teal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Isi Data Diri',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text('Pastikan data yang diisi sudah benar dan sesuai.',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 28),
              TextFormField(
                controller: _nama,
                decoration: _deco('Nama Lengkap', Icons.person_outline),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration: _deco('Email', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty
                    ? 'Wajib diisi'
                    : (!v.contains('@') ? 'Email tidak valid' : null)
              ),
              const SizedBox(height: 28),
              const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: ['Laki-laki', 'Perempuan'].map((g) => RadioListTile<String>(
                    title: Text(g, style: const TextStyle(fontWeight: FontWeight.w500)),
                    value: g,
                    groupValue: _gender,
                    activeColor: Colors.teal,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onChanged: (v) => setState(() => _gender = v!),
                  )).toList()
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Kirim Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: _submit,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
```

### Source Code screens/halaman_galeri.dart
```dart
import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanGaleri extends StatelessWidget {
  const HalamanGaleri({super.key});

  static const _items = [
    [Icons.landscape,       'Alam',       Colors.green],
    [Icons.directions_car,  'Otomotif',   Colors.red],
    [Icons.food_bank,       'Kuliner',    Colors.orange],
    [Icons.sports_soccer,   'Olahraga',   Colors.blue],
    [Icons.music_note,      'Musik',      Colors.pink],
    [Icons.computer,        'Teknologi',  Colors.indigo],
    [Icons.travel_explore,  'Travel',     Colors.teal],
    [Icons.palette,         'Seni',       Colors.purple],
    [Icons.architecture,    'Arsitektur', Colors.brown],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeri'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final r = _items[index];
          final color = r[2] as Color;
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => popupAlert(context,
              judul: r[1] as String,
              isi: 'Kamu membuka kategori "${r[1]}".\nFitur galeri lengkap segera hadir!',
              icon: r[0] as IconData, iconColor: color,
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))
                  ],
                  border: Border.all(color: color.withOpacity(0.15))),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle
                  ),
                  child: Icon(r[0] as IconData, color: color, size: 36)
                ),
                const SizedBox(height: 12),
                Text(r[1] as String,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
```

### Source Code screens/halaman_pengaturan.dart
```dart
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
```

### Source Code screens/halaman_notifikasi.dart
```dart
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
```

### Source Code screens/halaman_tentang.dart
```dart
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
```

### Screenshot Output 

![Tampilan Awal](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/tampilan_awal.png)

![Button Klik Saya](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/button-klik-saya.png)

![Memilih Tab](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/memilih_tab.png)

![Input Form](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/input-form.png)

![Galeri](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/galeri.png)

![Pengaturan](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/pengaturan.png)

![Notifikasi](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/notifikasi.png)

![Tentang Aplikasi](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/tentang-aplikasi.png)

![Tentang](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/792dba5a6fc70aaeee873cfca3a6acaace501ce3/pertemuan-11/Screenshot%20Output/tentang.png)

### Pembahasan Fungsionalitas Setiap Widget

#### 1. Widget Routing & Navigator (`MaterialApp routes`)
Dalam arsitektur aplikasi *multi-screen* ini, perpindahan layar tidak diletakkan dalam satu alur hierarki yang bertumpuk pada satu file. Flutter mengatasinya menggunakan mekanisme `routes` pada `MaterialApp`. Metode ini mendaftarkan setiap file tampilan sebagai alamat direktori (seperti `'/profil'`, `'/galeri'`). Implementasi pemanggilannya menggunakan perintah `Navigator.pushNamed(context, route)`. Fungsionalitas ini memastikan memori aplikasi tetap stabil karena *screen* akan dirender hanya ketika dipanggil, serta akan dihancurkan (*pop*) saat tombol kembali (back) ditekan.

#### 2. Widget Container (Gradien & Shadow)
`Container` bertindak sebagai pembungkus yang fleksibel untuk modifikasi UI modern. Dalam aplikasi ini, sebuah kartu identitas dirender di `HalamanUtama` menggunakan parameter `BoxDecoration`.
* **LinearGradient**: Menyuntikkan transisi dua warna (`Colors.blueAccent` ke `Colors.lightBlue`), menghapus kebosanan warna solid (datar).
* **BoxShadow**: Menciptakan efek kedalaman visual dengan mengatur warna bayangan yang memudar (`blurRadius: 10`) ke arah sumbu Y bawah (`offset: Offset(0, 5)`).
* **BorderRadius**: Memotong kekakuan ujung bujur sangkar menjadikannya membulat, menegaskan pedoman desain Material 3 yang estetik.

#### 3. Widget Custom Dialog (`showDialog` / `AlertDialog`)
*Alert box* standar sistem operasi seringkali kaku. Pada proyek ini, diciptakan fungsi terpisah `popupAlert` (pada `ui_helpers.dart`) untuk menghasilkan *modal dialog* yang responsif dan konsisten di seluruh halaman aplikasi.
Fungsionalitasnya bertumpu pada `AlertDialog` di mana properti `title` dikustomisasi dengan kombinasi logo lingkaran (`CircleAvatar`) dan judul teks tebal. Sementara blok `actions` menampung kumpulan `ElevatedButton` dan `OutlinedButton` interaktif. Pemisahan fungsi ke dalam satu *helper* ini meminimalisasi redudansi (duplikasi) baris kode secara drastis saat berbagai halaman perlu menampilkan notifikasi.

#### 4. Widget GridView.count
Komponen antarmuka yang sangat direkomendasikan untuk menyortir tata letak secara matriks atau galeri pada menu utama. Berbeda dengan implementasi satu-persatu, metode perulangan *mapping* dari array `_menu` ke susunan *grid* digunakan agar *source code* menjadi jauh lebih padat dan bersih.
* `crossAxisCount: 3` secara kaku membagi lebar layar utama menjadi tiga jalur sejajar.
* Pemanggilan metode `NeverScrollableScrollPhysics()` amat krusial di sini. Lantaran letak grid berada di dalam bungkus *widget* `SingleChildScrollView`, fitur *scroll* internal milik grid dibekukan demi mencegah bentrokan sistem gestur *scroll* layar utamanya.

#### 5. Widget ListView & ListTile
Merupakan arsitektur andalan untuk melahirkan susunan baris menu atau daftar bacaan vertikal, seperti yang diterapkan pada halaman Profil dan Pengaturan.
Alih-alih menyusun tata letak baris secara manual, properti `ListTile` digunakan. *Widget* bawaan Material ini bertugas melakukan manajemen posisi instan meliputi blok `leading` (ikon sisi kiri), `title` (teks utama), `subtitle` (teks deskripsi sekunder), dan `trailing` (komponen paling kanan seperti panah navigasi). Semua perataan asimetris tersebut dikalkulasi rapi tanpa perlu memberikan nilai *margin* manual.

#### 6. Form Validation (`TextFormField`)
Berpadu dengan kelas `GlobalKey<FormState>`, integrasi `Form` ini menghadirkan fungsionalitas sistem keamanan input interaktif pada `HalamanForm`.
Setiap blok `TextFormField` dibekali algoritma logika mandiri via parameter `validator`. Sebagai contoh: skrip deteksi kolom tidak berizin dikosongkan (`v!.isEmpty`) atau memastikan eksistensi karakter at/simbol wajib penulisan email elektronik (`!v.contains('@')`). Sistem aplikasi akan menahan laju pengiriman form dan otomatis mencetak peringatan jika serangkaian syarat logika ini tidak terpenuhi oleh *user*.