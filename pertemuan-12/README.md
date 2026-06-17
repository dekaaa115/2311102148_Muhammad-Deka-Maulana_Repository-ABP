```markdown
<h3 align="center">LAPORAN PRAKTIKUM</h3>
<h3 align="center">APLIKASI BERBASIS PLATFORM</h3>
<h3 align="center">Modul 8 & 9</h3>
<h3 align="center">API PERANGKAT KERAS</h3>

<br>
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/id/thumb/e/e0/Telkom_University_Logo.svg/1200px-Telkom_University_Logo.svg.png" width="150"/>
</p>
<br>

<p align="center">
Disusun oleh:
<br><br>
MUHAMMAD DEKA MAULANA  
<br>
2311102148  
<br>
S1 IF-11-04  
</p>

<br>

<p align="center">
Dosen Pengampu:
<br>
Cahyo Prihantoro, S.Kom., M.Eng  
</p>

<br><br>

<p align="center">
PROGRAM STUDI S1 INFORMATIKA  
<br>
FAKULTAS INFORMATIKA  
<br>
TELKOM UNIVERSITY PURWOKERTO  
<br>
2026  
</p>

---

# Deskripsi Proyek
Aplikasi **Cyber Capture** adalah aplikasi media capture modern yang menerapkan desain *Glassmorphism* dengan estetika futuristik. Aplikasi ini memanfaatkan API perangkat keras untuk mengambil gambar melalui kamera atau memilih dari galeri, serta mengintegrasikan *Local Notifications* untuk memberikan umpan balik kepada pengguna setelah proses pengambilan gambar berhasil.

Tautan Repository: [https://github.com/URL_GITHUB_KAMU](https://github.com/URL_GITHUB_KAMU)

---

# Dependencies yang Digunakan

Pada project ini digunakan beberapa package tambahan yang terdapat pada file `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.2.0
  flutter_local_notifications: ^19.4.0
  google_fonts: ^6.3.1

```

### Fungsi:

* **image_picker**: Akses kamera dan galeri perangkat.
* **flutter_local_notifications**: Menampilkan notifikasi lokal pada perangkat.
* **google_fonts**: Menggunakan font Poppins untuk modernisasi UI.

---

# Permission yang Dibutuhkan

Aplikasi memerlukan akses izin pada file `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.VIBRATE"/>

```

---

# Penjelasan Source Code

## 1. Efek Glassmorphism

Untuk mencapai tampilan modern, digunakan widget `BackdropFilter` untuk memberikan efek buram (*blur*) pada background di dalam `Container`.

```dart
Widget glassContainer({required Widget child, EdgeInsetsGeometry? padding}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          border: Border.all(color: Colors.cyanAccent.withOpacity(0.5)),
        ),
        child: child,
      ),
    ),
  );
}

```

## 2. Inisialisasi Kamera & Galeri

Fungsi `openCamera()` dan `openGallery()` menggunakan `picker.pickImage` dengan `imageQuality: 80` untuk memastikan gambar memiliki ukuran yang optimal namun tetap jernih.

## 3. Sistem Notifikasi

Setelah gambar berhasil dimuat, fungsi `showNotification()` dipanggil untuk memberikan konfirmasi kepada pengguna bahwa gambar telah tersimpan atau terpilih di dalam *state* aplikasi.

---

# Screenshot Hasil Program

Berikut adalah hasil implementasi aplikasi pada emulator:

| Tampilan Awal | Mengambil Foto (In-Camera) | Upload & Notifikasi |
| --- | --- | --- |
|  |  |  |

*(Pastikan file gambar sudah di-upload ke folder `screenshot` di repository GitHub kamu).*

---

# Kesimpulan

Praktikum Modul 8 & 9 berhasil diselesaikan dengan mengintegrasikan API Kamera dan Galeri. Implementasi desain *Glassmorphism* memberikan tampilan antarmuka yang modern, responsif, dan menarik, sesuai dengan standar pengembangan aplikasi berbasis platform saat ini.

```

### Langkah Terakhir:
1.  Buat folder bernama **`screenshot`** di dalam repository GitHub kamu.
2.  Masukkan 3 file gambar kamu (`in-camera.png`, `tampilan-awal.png`, `upload-dan-notifikasi.png`) ke dalam folder tersebut.
3.  Ubah `URL_GITHUB_KAMU` di file `.md` tersebut dengan link repo kamu yang asli.
4.  Commit dan push perubahannya ke GitHub.

```