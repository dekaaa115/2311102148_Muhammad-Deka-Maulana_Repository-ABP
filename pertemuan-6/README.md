<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM<br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>TUGAS PRAKTIKUM LARAVEL + AJAX<br>(TANPA DATABASE)</h3>
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

## 1. Dasar Teori

### Framework Laravel 12
Laravel adalah kerangka kerja (*framework*) aplikasi web berbasis PHP yang menggunakan arsitektur Model-View-Controller (MVC). Laravel dirancang untuk membuat proses pengembangan web menjadi lebih elegan, cepat, dan terstruktur dengan menyediakan berbagai fitur bawaan seperti *routing* yang intuitif, *middleware*, dan manajemen *file system*. Pada praktikum ini, Laravel digunakan sebagai *backend* untuk menyediakan antarmuka pengguna dan melayani *endpoint* API (Application Programming Interface).

### AJAX & Fetch API
AJAX (Asynchronous JavaScript and XML) adalah teknik pengembangan web yang memungkinkan aplikasi untuk mengirim dan mengambil data dari *server* secara asinkron di latar belakang. Dengan AJAX, halaman web dapat diperbarui secara dinamis tanpa perlu memuat ulang (*reload*) seluruh halaman. Dalam implementasi modern, **Fetch API** digunakan sebagai antarmuka JavaScript bawaan (*native*) yang lebih kuat dan fleksibel untuk melakukan *request* jaringan HTTP (seperti GET dan POST) menggantikan metode usang seperti `XMLHttpRequest`.

### JSON (JavaScript Object Notation)
JSON adalah format serialisasi data tekstual yang sangat ringan dan mudah diurai (*parsing*) baik oleh manusia maupun mesin. Berbasis dari struktur objek JavaScript (*key-value pairs*), JSON sering digunakan sebagai format standar untuk pertukaran data antara *klien* (browser) dan *server*. Dalam tugas praktikum ini, file JSON digunakan secara lokal sebagai media penyimpanan data alternatif untuk menggantikan peran *database* relasional.

### Bootstrap 5
Bootstrap adalah kerangka kerja CSS *front-end* terpopuler yang dimanfaatkan untuk merancang antarmuka web secara responsif dengan cepat. Dengan menggunakan sistem *grid* dan komponen visual siap pakai (seperti *Card*, *Button*, dan *Badge*), antarmuka aplikasi dapat dirancang agar terlihat modern, rapi, dan mampu beradaptasi secara dinamis pada berbagai ukuran layar perangkat.

### Blade Template Engine
Blade adalah mesin pembuat *template* (*templating engine*) bawaan Laravel yang sederhana namun sangat kuat. Blade memungkinkan pengembang untuk menulis kode HTML murni dengan sintaks tambahan untuk melakukan *rendering* data dari *server*. File Blade selalu menggunakan ekstensi `.blade.php` dan dikompilasi menjadi kode PHP murni oleh Laravel sehingga tidak membebani performa aplikasi.

## 2. Struktur Folder
Hanya menampilkan direktori dan *file* utama yang dimodifikasi atau dibuat selama pengerjaan tugas:

```text
tugas-laravel-ajax/
├── app/
│   └── Http/
│       └── Controllers/
│           └── MahasiswaController.php  # Mengelola logika backend
├── resources/
│   └── views/
│       └── welcome.blade.php            # Antarmuka utama (Frontend)
├── routes/
│   └── web.php                          # Pengaturan rute URL
├── storage/
│   └── app/
│       └── mahasiswa.json               # Tempat penyimpanan data lokal (Database tiruan)
└── .env                                 # Konfigurasi sistem (Session File, SQLite)
```

## 3. Source Code
storage/app/mahasiswa.json
Menyimpan data dummy mahasiswa dalam format array of objects.
```json
[
    {
        "nama": "Muhammad Deka Maulana",
        "nim": "2311102148",
        "kelas": "IF-11-D",
        "prodi": "S1 Teknik Informatika"
    },
    {
        "nama": "Danendra Arden Shaduq",
        "nim": "2311102146",
        "kelas": "IF-11-D",
        "prodi": "S1 Teknik Informatika"
    },
    {
        "nama": "Najwa Humairah",
        "nim": "2311102134",
        "kelas": "IF-11-D",
        "prodi": "S1 Teknik Informatika"
    }
]
```

app/Http/Controllers/MahasiswaController.php
Mengatur proses rendering halaman dan pembacaan file JSON lokal untuk diubah menjadi response API.
```php
<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class MahasiswaController extends Controller
{
    // Menampilkan halaman utama (Blade)
    public function index()
    {
        return view('welcome');
    }

    // Endpoint API untuk dikonsumsi oleh AJAX
    public function getJsonData()
    {
        $path = storage_path('app/mahasiswa.json');

        if (!File::exists($path)) {
            return response()->json(['message' => 'Data tidak ditemukan.'], 404);
        }

        // Membaca isi file lokal
        $jsonContent = File::get($path);
        // Mengurai JSON menjadi array PHP
        $data = json_decode($jsonContent, true);

        // Mengembalikan response format JSON
        return response()->json($data);
    }
}
```

routes/web.php
Mendefinisikan endpoint yang menghubungkan URL dengan controller.
```php
<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MahasiswaController;

// Rute untuk menampilkan halaman User Interface
Route::get('/', [MahasiswaController::class, 'index']);

// Rute API untuk melayani request AJAX Fetch
Route::get('/api/mahasiswa', [MahasiswaController::class, 'getJsonData']);
```

resources/views/welcome.blade.php
Halaman frontend utama yang memuat UI Bootstrap dan skrip Fetch API.
```html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Praktikum AJAX Laravel 12</title>
    <link href="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css)" rel="stylesheet">
</head>
<body class="bg-light">

    <div class="container py-5">
        <div class="text-center mb-5">
            <h1 class="fw-bold text-primary">Data Mahasiswa Praktikum</h1>
            <p class="text-muted">Implementasi Laravel 12 & AJAX tanpa Database</p>
        </div>
        
        <div class="d-flex justify-content-center mb-5">
            <button id="btnTampilData" class="btn btn-primary btn-lg shadow-sm">
                Tampilkan Data
            </button>
        </div>

        <div id="areaHasil" class="row justify-content-center g-4">
            </div>
    </div>

    <script>
        document.getElementById('btnTampilData').addEventListener('click', function() {
            const btn = this;
            const areaHasil = document.getElementById('areaHasil');
            
            // UX Loading state
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Memuat...';
            btn.disabled = true;

            // Mengambil data secara asinkron
            fetch('/api/mahasiswa')
                .then(response => response.json())
                .then(data => {
                    areaHasil.innerHTML = ''; // Membersihkan area

                    // Looping data dari JSON
                    data.forEach(mhs => {
                        const card = `
                            <div class="col-md-4">
                                <div class="card h-100 border-0 shadow-sm border-bottom border-primary border-4">
                                    <div class="card-body">
                                        <h5 class="card-title fw-bold text-dark mb-1">${mhs.nama}</h5>
                                        <h6 class="card-subtitle text-muted mb-3">${mhs.nim}</h6>
                                        <hr>
                                        <div class="d-flex justify-content-between text-sm">
                                            <span class="fw-semibold">Kelas:</span>
                                            <span>${mhs.kelas}</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-sm mt-2">
                                            <span class="fw-semibold">Prodi:</span>
                                            <span class="badge bg-primary rounded-pill">${mhs.prodi}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                        // Menyisipkan elemen HTML ke dalam DOM
                        areaHasil.innerHTML += card;
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    areaHasil.innerHTML = '<div class="alert alert-danger text-center">Gagal mengambil data!</div>';
                })
                .finally(() => {
                    // Mengembalikan tombol ke fungsi normal
                    btn.innerHTML = 'Tampilkan Data';
                    btn.disabled = false;
                });
        });
    </script>
</body>
</html>
```

## 4. Penjelasan Cara Kerja Aplikasi & Screenshot Output
Berikut merupakan penjelasan alur kerja aplikasi saat melakukan proses fetching data mahasiswa menggunakan AJAX tanpa me-reload halaman:

Kondisi Inisiasi (Tampilan Awal)
Saat pengguna mengakses rute URL utama (/), router Laravel mengarahkan permintaan tersebut ke fungsi index() pada MahasiswaController. Fungsi ini kemudian memanggil mesin template Blade untuk merender berkas welcome.blade.php. Pada tahap ini, interaksi klien dengan basis data atau file lokal belum terjadi. Halaman hanya menampilkan antarmuka statis (header) dan sebuah tombol pemicu (trigger) yang disiapkan untuk menjalankan skrip JavaScript (Event Listener).

Proses Asinkron (Pengambilan & Render Data)
Proses utama terjadi saat pengguna menekan tombol "Tampilkan Data". Event Listener pada JavaScript terpicu dan menjalankan fungsi Fetch API menuju endpoint /api/mahasiswa.

Di sisi backend (Laravel), rute menangkap permintaan HTTP GET tersebut dan memanggil fungsi getJsonData(). Fungsi ini mengakses file sistem lokal pada direktori storage/app/mahasiswa.json, membacanya, dan mengonversinya menjadi response JSON murni (HTTP 200).

Kembali ke sisi frontend (Browser), promise dari Fetch API berhasil dipenuhi (.then()). Skrip JavaScript kemudian mengekstraksi objek JSON tersebut, melakukan iterasi (looping), dan secara dinamis membuat struktur HTML berupa komponen Card dari Bootstrap. Elemen HTML (Document Object Model / DOM) pada halaman langsung dimanipulasi dengan menyisipkan kartu-kartu data mahasiswa ini ke dalam antarmuka. Seluruh proses pertukaran dan manipulasi data ini terjadi di latar belakang secara mulus tanpa membuat halaman browser berkedip (reload).

## 5. Kesimpulan
Aplikasi web sederhana ini berhasil mengimplementasikan komunikasi asinkron antara client-side dan server-side menggunakan teknologi AJAX (Fetch API) dan kerangka kerja Laravel 12. Kendala ketergantungan pada database tradisional (seperti MySQL) berhasil diatasi dengan menonaktifkan konfigurasi database default di file .env (mengubah sesi ke mode file) dan memanfaatkan file .json lokal di dalam direktori storage sebagai sumber penyimpanan data (data source). Pendekatan Single Page Experience yang didapatkan memberikan performa antarmuka yang cepat dan interaktif bagi pengguna.