<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM<br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>PERTEMUAN 9 - MOBILE</h3>
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
<a href="https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/tree/ec120637ed434b325046243773fbdcccfa9a10a6/pertemuan-9">
    https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/tree/ec120637ed434b325046243773fbdcccfa9a10a6/pertemuan-9 
</a>

---

## TUGAS PERTEMUAN 9 MOBILE
Tugas Praktikum Modul 4-5 Flutter

Buat 1 project Flutter yang menampilkan beberapa widget UI berikut:
<br>Yang harus ada:
<br>Container → kotak berwarna
<br>GridView → minimal 6 item (grid)
<br>ListView → 3 item (A, B, C)
<br>ListView.builder → list dari data array
<br>ListView.separated → list + garis pembatas
<br>Stack → tampilan bertumpuk (kotak / text)

Output yang dikumpulkan: Screenshot hasilnya Source code Penjelasan singkat tiap widget

## JAWABAN

### Source Code main.dart
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Layanan IT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Data untuk ListView.builder dan ListView.separated
  final List<String> layananIT = const [
    'Servis Laptop & PC',
    'Instalasi Sistem Operasi',
    'Recovery Data Storage',
    'Setup Jaringan & Router',
    'Perbaikan Hardware',
  ];

  // Data array untuk GridView
  final List<Map<String, dynamic>> gridItems = const [
    {'title': 'Jaringan', 'icon': Icons.router, 'color': Colors.indigo},
    {'title': 'Keamanan', 'icon': Icons.security, 'color': Colors.redAccent},
    {'title': 'Cloud', 'icon': Icons.cloud, 'color': Colors.orange},
    {'title': 'Software', 'icon': Icons.laptop_windows, 'color': Colors.green},
    {'title': 'Hardware', 'icon': Icons.memory, 'color': Colors.deepPurple},
    {'title': 'Riwayat', 'icon': Icons.history, 'color': Colors.teal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f6fb),
      appBar: AppBar(
        title: const Text(
          'Tugas Pertemuan 9 - Mobile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //CONTAINER
            sectionTitle('1. Container'),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.lightBlue],
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo,
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.computer, color: Colors.white, size: 38),
                    SizedBox(height: 8),
                    Text(
                      "Muhammad Dhimas Hafizh Fathurrahman",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '2311102148',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            //GRIDVIEW
            sectionTitle('2. GridView Kategori Layanan'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: gridItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = gridItems[index];
                return Container(
                  decoration: BoxDecoration(
                    color: item['color'],
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: item['color'].withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item['icon'], size: 42, color: Colors.white),
                      const SizedBox(height: 10),
                      Text(
                        item['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            //LISTVIEW
            sectionTitle('3. ListView Status Perbaikan'),
            SizedBox(
              height: 180,
              child: ListView(
                children: const [
                  CustomTile('Pengecekan Masalah', Icons.search),
                  CustomTile('Sedang Diperbaiki', Icons.build_circle),
                  CustomTile(
                    'Perangkat Siap Diambil',
                    Icons.check_circle_outline,
                  ),
                ],
              ),
            ),

            //LISTVIEW.BUILDER
            sectionTitle('4. ListView.builder Paket IT'),
            SizedBox(
              height: 260,
              child: ListView.builder(
                itemCount: layananIT.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigo,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        layananIT[index],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Tersedia untuk perorangan & instansi',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  );
                },
              ),
            ),

            //LISTVIEW.SEPARATED
            sectionTitle('5. ListView.separated Detail Layanan'),
            SizedBox(
              height: 230,
              child: ListView.separated(
                itemCount: layananIT.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.2, color: Colors.indigoAccent),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.settings_ethernet,
                      color: Colors.indigoAccent,
                    ),
                    title: Text(
                      'Layanan: ${layananIT[index]}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Pengerjaan cepat dan bergaransi'),
                    trailing: const Icon(Icons.verified, color: Colors.green),
                  );
                },
              ),
            ),

            //STACK
            sectionTitle('6. Stack Promo Servis'),
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.indigo.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 25,
                    left: 25,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.settings_suggest,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 55,
                    left: 95,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Icon(
                        Icons.speed,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 28,
                    right: 24,
                    child: Text(
                      'Fast & Reliable',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk judul section
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
          color: Colors.indigo,
        ),
      ),
    );
  }
}

// Widget tambahan untuk ListView statis
class CustomTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomTile(this.title, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('Update status pengerjaan IT'),
      ),
    );
  }
}
```

### Screenshot Output 
![Screenshot Output 1](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/c8ddc42c71ead2c73d692a1295b29a0ace3c32d0/pertemuan-9/Screenshot_Output/1.png)

![Screenshot Output 2](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/c8ddc42c71ead2c73d692a1295b29a0ace3c32d0/pertemuan-9/Screenshot_Output/2.png)

![Screenshot Output 3](https://github.com/dekaaa115/2311102148_Muhammad-Deka-Maulana_Repository-ABP/blob/c8ddc42c71ead2c73d692a1295b29a0ace3c32d0/pertemuan-9/Screenshot_Output/3.png)

### Pembahasan Fungsionalitas Setiap Widget

#### 1. Widget Container

Di dalam ekosistem Flutter, `Container` bertindak sebagai elemen fundamental yang bertugas membungkus dan mengatur tata letak *widget* lain di dalamnya. Komponen ini menawarkan tingkat kustomisasi yang tinggi, mencakup pengaturan dimensi (panjang dan lebar), warna latar, spasi luar (*margin*), spasi dalam (*padding*), hingga ornamen visual seperti gradien, modifikasi kelengkungan sudut, serta efek bayangan. Pada kode `main.dart` ini, `Container` dirancang untuk membentuk sebuah kartu profil minimalis bernuansa modern.

Rincian implementasinya meliputi:

* **Pengaturan Dimensi:** `Container` dipatok dengan ukuran tinggi tetap 180 piksel, sedangkan sisi lebarnya menggunakan atribut `double.infinity` agar dapat membentang secara maksimal menyesuaikan lebar perangkat secara horizontal.
* **Desain Visual (BoxDecoration):** Aspek estetika dari latar belakang komponen ini dikelola menggunakan kelas `BoxDecoration`, yang memuat:
* **Warna Gradien:** Menggunakan `LinearGradient` untuk menciptakan transisi visual yang mulus dari warna biru pekat (`Colors.indigo`) menuju warna biru cerah (`Colors.lightBlue`).
* **Sudut Melengkung:** Properti `borderRadius: BorderRadius.circular(24)` ditambahkan guna mengubah sudut kaku pada kotak menjadi tumpul dengan radius 24 piksel.
* **Efek Timbul (Shadow):** Diaktifkannya efek bayangan dari `BoxShadow` dengan warna `Colors.indigo`, nilai *blur* 12 piksel, serta koordinat kemiringan `Offset(0, 6)` memberikan ilusi bahwa kartu tersebut sedikit melayang dari latar belakang.


* **Posisi Elemen di Dalamnya:** Bagian `child` dari Container diapit oleh *widget* `Center`. Tujuannya adalah memastikan semua isi konten secara presisi jatuh di poros tengah (*center*).
* **Konfigurasi Susunan Vertikal:** Pada area *Center*, dimasukkan `Column` dengan pengaturan `mainAxisAlignment: MainAxisAlignment.center`. Ini menjamin susunan ikon, nama, dan NIM berjajar lurus ke bawah dan mengunci posisinya di bagian tengah area komponen.
* **Rincian Konten:**
* **Ikon Visual:** Menampilkan gambar perangkat keras PC (`Icons.computer`) yang diubah warnanya menjadi putih solid dengan dimensi 38.
* **Pemberi Spasi (SizedBox):** Digunakan untuk menciptakan celah bernilai 8 dan 4 piksel sebagai pembatas area agar antarteks maupun ikon tidak terlihat tumpang tindih.
* **Label Nama:** Menyajikan teks "Muhammad Deka Maulana" berpemformatan rata tengah, berwarna putih solid, ukuran *font* 19, dan diberi ketebalan ekstra melalui `fontWeight.bold`.
* **Label Identitas (NIM):** Menyajikan rangkaian angka "2311102148" berukuran 15 piksel menggunakan pewarnaan putih dengan tingkat transparansi 70% (`Colors.white70`), membedakannya dari label utama.



#### 2. Widget GridView

`GridView` merupakan jenis komponen antarmuka yang dirancang khusus untuk memetakan serangkaian data dalam formasi kotak-kotak matriks (baris bersilangan dengan kolom). Format ini sangat cocok dimanfaatkan untuk menata menu, katalog produk, atau galeri visual. Pada proyek ini, implementasinya menggunakan metode `GridView.builder` karena algoritma pemrosesannya lebih ramah memori saat merender urutan data dari *array* secara dinamis.

Rincian implementasinya meliputi:

* **Pengendalian Sifat Scroll:** Oleh karena komponen letaknya tumpang tindih dengan fasilitas *scroll* dari layar utama, beberapa batasan harus diterapkan:
* `shrinkWrap: true`: Atribut ini krusial untuk memaksa grid menciut dan membatasi ketinggiannya sesuai dengan jumlah ruang dari objek yang dirender, menghindari terjadinya *error layout*.
* `physics: NeverScrollableScrollPhysics()`: Digunakan untuk membekukan fungsi gulir bawaan dari `GridView`, sehingga keseluruhan layar hanya merespons satu sistem *scroll* dari halaman induk.


* **Alokasi Tata Letak (gridDelegate):** Modul kelas `SliverGridDelegateWithFixedCrossAxisCount` mengatur pembagian area grid:
* `crossAxisCount: 2`: Menetapkan jumlah ruang kolom menjadi 2 bagian sejajar.
* `crossAxisSpacing` dan `mainAxisSpacing`: Memberikan spasi seragam sebesar 14 piksel pada celah vertikal maupun mendatar tiap kotak agar tidak melekat satu sama lain.
* `childAspectRatio: 1.1`: Menentukan proporsi perbandingan ukuran sisi-sisinya. Angka 1.1 membuat bingkai sedikit lebih lebar daripada tingginya.


* **Proses Pembuatan Elemen Dinamis (itemBuilder):** Parameter ini yang memproduksi susunan menu satu per satu secara kontinu:
* `itemCount`: Berfungsi menakar total perulangan, angkanya disesuaikan berdasarkan ukuran *array* bawaan `gridItems.length`.
* `item`: Pada setiap fase putaran *looping*, variabel ini akan mengekstrak susunan data warna, rujukan *icon*, serta teks judul dari struktur array sesuai nomor antreannya.


* **Pewarnaan dan Modifikasi Kartu (Container):** *Widget* bertindak sebagai cangkang pelindung dari susunan menu:
* *Background* setiap kotak diekstrak otomatis berdasarkan rekaman data struktur warnanya (`item['color']`).
* Tepian luar dikurasi menggunakan `BorderRadius.circular(22)`.
* Menambahkan `boxShadow` dengan pewarnaan yang sama persis dengan kartu utamanya namun berlevel opasitas 35%, serta memberikan *offset* (0, 5) guna memunculkan kesan 3D.


* **Tampilan Konten Grid:** Elemen disusun lurus ke bawah di tengah kanvas oleh `Column`. Memuat *icon* utama layanan (dimensi 42), dibatasi dengan ruang `SizedBox` setebal 10 piksel, lalu diakhiri oleh atribut teks nama menu dengan ukuran 18 dan bobot huruf tebal yang seluruhnya dirender menjadi berwarna putih kontras.

#### 3. Widget ListView

`ListView` adalah jenis *widget* vertikal (maupun mendatar) yang memiliki kapabilitas memuat kumpulan komponen secara berjejer sekaligus melengkapinya dengan fungsi interaksi *scroll* jika konten meluap ke luar layar. Komponen ini kerap dimanfaatkan dalam desain aplikasi modern untuk menangani menu gulir, linimasa status, hingga rekaman riwayat. Dalam kode bagian ini, tipe `ListView` standar (tanpa builder) diaplikasikan guna memunculkan rentetan indikator tahapan perbaikan secara konstan.

Rincian implementasinya meliputi:

* **Manajemen Batasan Area (SizedBox):** Sangat penting bagi sebuah `ListView` yang tertumpuk secara vertikal untuk dikarantina dimensinya. Oleh karena itu, properti dipagari menggunakan ukuran pasti melalui `SizedBox(height: 180)`. Jika tidak, widget ini bisa menyebabkan kelumpuhan *layout* akibat usahanya memakan layar tanpa henti (*unbounded height constraint*).
* **Pendekatan Pemanggilan Daftar (children):** Oleh sebab isi baris data bersifat permanen dan volumenya teramat minim, metode memasukkan kode satu-persatu melalui rentetan *array children* diakui jauh lebih efisien dan sederhana dibanding proses pelacakan *index* otomatis.
* **Arsitektur Daftar Statis:** Baris data dibentuk dalam rupa widget spesifik bertitel `CustomTile`. Di dalamnya terdapat tiga proses tahapan:
* Titik awal pengecekan: Disimbolkan oleh teks judul "Pengecekan Masalah" bersanding dengan logo `Icons.search`.
* Titik proses servis: Menampilkan tulisan "Sedang Diperbaiki" bertemankan lambang gir/alat `Icons.build_circle`.
* Titik tuntas pengerjaan: Mencetak keterangan "Perangkat Siap Diambil" lengkap dengan lencana persetujuan `Icons.check_circle_outline`.


* **Penerapan Widget Bantuan (CustomTile):** Alih-alih melakukan *copy-paste* puluhan baris parameter desain untuk tiap komponen menu, penggunaannya diringkas melalui modul `CustomTile`. Strategi ini menjadikan kodingan tidak rentan berantakan dan hanya cukup mem- *parsing* (melemparkan) konfigurasi teks serta gambar saat hendak digunakan.

#### 4. Widget ListView.builder

Merupakan bentuk penyempurnaan dari format urutan *list* sebelumnya. Nilai jual dari varian versi `builder` ini berfokus di kapabilitas efisiensi alokasi memori melalui fungsi *lazy loading*, sebuah konsep yang membuat program hanya mencetak visual pada layar sesaat setelah area layarnya bergeser atau tersorot pandangan pengguna. Pada tahapan `main.dart` ini, ia digunakan sebagai penampil referensi kumpulan katalog layanan teknologi.

Rincian implementasinya meliputi:

* **Pengunci Tinggi Area:** Sama seperi pendahulunya, jangkauan geseran area dibendung dalam kandang tinggi mutlak `SizedBox` berjumlah 260.
* **Kapasitas List (itemCount):** Proses iterasi akan dihentikan secara otomatis ketika panjang siklusnya sudah sinkron dengan volume tampungan elemen struktur `layananIT`.
* **Perakitan Item Dinamis (itemBuilder):** Modul eksekutor yang melahirkan entitas-entitas daftar di setiap siklus perulangannya. Proses pencetakan data ini mengandalkan variabel `index` untuk membedakan giliran nomor antre elemen apa yang sedang dirender.
* **Wadah Kartu Latar (Card):** Demi menata visibilitas agar nyaman dilihat, hasil perulangan dilindungi oleh objek `Card`. Desainnya diselaraskan menggunakan parameter `RoundedRectangleBorder` bersudut kelengkungan 16.
* **Arsitektur Penyusun List (ListTile):** Penempatan komponen antarmuka yang harmonis dieksekusi dengan modul `ListTile`:
* **Segmen Awal (Leading):** Diisi hiasan `CircleAvatar` bercorak indigo pekat untuk mewadahi cetakan urutan angka, yang dijabarkan lewat perhitungan matematis sederhana `${index + 1}`.
* **Segmen Utama (Title):** Menyematkan panggilan rekaman string spesifik `layananIT[index]` dengan pemformatan label yang diketik tebal.
* **Segmen Tambahan (Subtitle):** Berisi kalimat promosional statis dengan cetakan "Tersedia untuk perorangan & instansi".
* **Segmen Ujung Akhir (Trailing):** Di sela-sela area terjauh pojok list, diapit sebuah logo navigasi mini panah (`Icons.arrow_forward_ios`) untuk memancing sugesti gestur klik bagi penggunanya.



#### 5. Widget ListView.separated

Pengembangan setingkat lebih lanjut dari teknik render berseri ini menambahkan sebuah utilitas spesial, yaitu pembuatan jeda atau batasan antar komponen visual secara mutlak. Pendekatan perancangan semacam ini krusial saat menyusun hierarki menu berisikan baris panjang guna memperjelas pemetaan pembaca tanpa repot memikirkan desain sekatnya secara tunggal. Tujuannya adalah membedah klasifikasi tipe pelayanan sistem IT di menu utama.

Rincian implementasinya meliputi:

* **Standarisasi Ukuran Penampil:** Blok vertikal dipatenkan ukurannya di batasan maksimal 230 via perpaduan *widget* `SizedBox`.
* **Mekanisme Jumlah Baris:** *Counter* parameter *looping* ditancapkan persis merujuk data internal koleksi *array* dari variabel `layananIT.length`.
* **Fasilitas Pembelah Struktur (separatorBuilder):** Ini merupakan poin kelebihan dari kelas `.separated`. Komponen perantara diciptakan menggunakan *widget* `Divider`, membentuk goresan warna menyamping menggunakan rona *indigoAccent* lengkap bersama dimensi ketebalan modifikasi senilai 1.2.
* **Pembuat Isi List Otomatis:** Perilaku parameternya seratus persen serupa dengan fungsionalitas dari keluarga *builder*, yaitu merender satu item pada indeks putaran data terkini.
* **Penyelarasan Tampilan via ListTile:**
* **Leading:** Pada bilik perdana disuntikkan ikonik logo kabel LAN maya (`settings_ethernet`) berdampingan rona yang serasi dengan garis potong pembatas.
* **Title:** Diolah dari pemanggilan perulangan string berbalut modifikasi tulisan kombinasi "Layanan: [nama item]" melalui pembubuhan tingkat *boldness* `w600`.
* **Subtitle:** Digunakan memaparkan teks penunjang, berisikan kata "Pengerjaan cepat dan bergaransi".
* **Trailing:** Ditutup di penghujung daftar memakai lambang validasi (`verified`) berkebangsaan warna hijau demi memberikan jaminan kepercayaan komersial.



#### 6. Widget Stack

`Stack` adalah komponen krusial pada metode *layouting* di dimensi Flutter jika target estetikanya menyerupai kanvas desain (di mana objek-objek bisa bersilangan tempat/tertumpuk). Aturan penulisannya mengedepankan asas hierarki; baris kode penulisan *widget* awal bakal mendarat sebagai level paling mendasar (dasar permukaan kanvas), sementara yang di- *coding* di urutan belakang berhak merajai tampang depan antarmuka. Metode tersebut diskenariokan menjadi penampil iklan promosi jasa servis berlapis grafik dinamis.

Rincian implementasinya meliputi:

* **Fondasi Ruang Layar:** Penempatan modul tumpukan tersebut dideklarasikan ke dalam blok *Container* bervolume lebar utuh selayar penuh (`double.infinity`) bercampur ukuran tegak setinggi 180 piksel. Lapis tembok alas kanvas diberi sapuan warna `indigo.shade100` beraksen tepian halus (radius 24).
* **Implementasi Widget Stack:** Konsep kerja *widget* mementingkan presisi pengaturan sumbu koordinat. Hal tersebut diaktifkan berkat kolaborasi antarmuka bersama objek pembantu `Positioned` agar *developer* bebas berkreasi dalam menarik komponen ke mana saja.
* **Elemen Latar Permukaan Dasar (Layer 1):** Komponen didapuk di sekuens kesatu berwujud persegi empat *indigo* di mana sisi pojoknya agak meliuk. Keping ini didorong ke dalam sejauh 25 piksel merujuk tepi atas maupun batas tepian sebelah kiri sistem sumbu koordinat layar asalnya (`top: 25`, `left: 25`). Tengah-tengah dimensinya menyimpan simbol gir bersiluet putih (ukuran 50).
* **Elemen Lapisan Menengah (Layer 2):** Diselipkan satu blok *container* baru bercorak biru menyala (*light blue accent*) dengan ukuran bidang serupa lapisan pendahulu (110x110). Parameter sumbunya digeser agak menurun menjorok diagonal menjauhi pusat awal (`top: 55`, `left: 95`), otomatis mengarsir area dari bingkai pertamanya sembari menyajikan ornamen logo tipe pemicu kecepatan (speedometer).
* **Slogan Elemen Tertinggi (Layer 3):** Elemen kalimat mendarat pas di sekuens kode terakhir pada urutan kanvas agar kebal terhadap objek lainnya. Perintah deklarasi `Positioned`-nya mengambil arah berlawanan, menyudut ke titik pojok inferior sebelah kanan layar (`bottom: 28`, `right: 24`). Hal ini dirancang cermat menjamin teks promosi ber- *font* kuat yang mengusung "Fast & Reliable" tak pernah tercaplok, sekalipun aplikasinya dipaksa membesar-kecilkan *layout*.