<h3 align="center">LAPORAN PRAKTIKUM</h3>
<h3 align="center">APLIKASI BERBASIS PLATFORM</h3>
<h3 align="center">Pertemuan 13</h3>
<h3 align="center">Modul 12 & 13</h3>

<br>
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/0/03/Logo_Telkom_University_potrait.png" alt="Logo" width="300" width="150"/>
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
Aplikasi **Modern Counter App** ini adalah pengembangan dari aplikasi *counter* bawaan Flutter. Aplikasi ini memperbarui antarmuka menggunakan standar *Material 3* dengan elemen desain seperti `Card` bersudut membulat dan pewarnaan dinamis. Selain itu, aplikasi mengintegrasikan *Local Notifications* untuk memberikan umpan balik langsung ke *system tray* Android setiap kali pengguna menekan tombol *increment*.

Tautan Repository: [Masukkan Link Repository GitHub Kamu Di Sini]

---

# Dependencies yang Digunakan

Pada project ini digunakan beberapa *package* tambahan yang terdapat pada file `pubspec.yaml` serta konfigurasi dependensi Gradle:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_local_notifications: ^17.0.0

```

Pada `android/app/build.gradle.kts`:

```kotlin
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
}

```

### Fungsi:

* **flutter_local_notifications**: Menampilkan push notifikasi lokal pada perangkat Android.
* **coreLibraryDesugaring**: Modul *desugar* untuk mendukung penggunaan fitur waktu dan tanggal dari API Java 8+ pada Android versi lama.

---

# Konfigurasi Tambahan yang Dibutuhkan

Berbeda dengan proyek sederhana, aplikasi ini memerlukan modifikasi *build options* pada file `android/app/build.gradle.kts` agar tidak terjadi *error* saat *compile*:

```kotlin
compileOptions {
    isCoreLibraryDesugaringEnabled = true
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

```

Serta menambahkan izin untuk notifikasi pada file `android/app/src/main/AndroidManifest.xml` (khusus untuk perangkat Android 13+):

```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

```

---

# Penjelasan Source Code

## 1. Pembaruan Desain Antarmuka (Material 3)

Aplikasi menggunakan `ThemeData(useMaterial3: true)`. Angka counter dibungkus menggunakan widget `Card` dengan *shadow* yang halus, dan tata letak diseimbangkan dengan menggunakan `FloatingActionButton.extended` di bagian tengah bawah layar.

## 2. Inisialisasi Notifikasi Lokal

Fungsi `initNotification()` digunakan untuk mendaftarkan *icon* aplikasi (`@mipmap/ic_launcher`) ke dalam *settings* notifikasi, serta memicu *prompt* (dialog box) untuk meminta izin (permission) menampilkan notifikasi dari sistem operasi perangkat.

```dart
Future<void> initNotification() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings settings = InitializationSettings(
    android: androidSettings,
  );
  await flutterLocalNotificationsPlugin.initialize(settings);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.requestNotificationsPermission();
}

```

## 3. Memicu Notifikasi pada Counter

Di dalam fungsi `_incrementCounter()`, pemanggilan `showNotification()` ditambahkan agar setiap kali nilai state `_counter` bertambah, pesan berisi angka terbaru akan didorong masuk ke dalam laci notifikasi Android.

---

# Screenshot Hasil Program

Berikut adalah hasil implementasi aplikasi pada emulator:

![Tampilan Awal](./Screenshot%20Output/screenshot1.png)
![Notifikasi Counter](./Screenshot%20Output/screenshot2.png)
![Notifikasi Counter](./Screenshot%20Output/screenshot3.png)
---

# Kesimpulan

Praktikum Modul 12 & 13 berhasil diselesaikan dengan baik. Implementasi *package* `flutter_local_notifications` dapat berjalan setelah mengatasi *error* kompilasi dengan mengaktifkan fitur `coreLibraryDesugaring` pada Gradle. Hasil akhir menunjukkan aplikasi *counter* yang tidak hanya lebih modern secara visual, tetapi juga interaktif melalui notifikasi sistem *real-time*.

```
