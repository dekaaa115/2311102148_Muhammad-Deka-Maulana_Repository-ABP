# Tugas Praktikum 6 : Laravel 12 + AJAX (Tanpa Database)

Halo! Ini adalah dokumentasi dari tugas praktikum saya terkait implementasi Laravel dan AJAX. 

Tantangan utama di tugas ini adalah **tidak boleh menggunakan database**. Jadi, sebagai solusinya, saya menyimpan data mahasiswa di dalam file JSON lokal dan memanggilnya menggunakan Fetch API (Vanilla JavaScript). Hasilnya, data bisa tampil secara instan tanpa perlu *reload* halaman sama sekali!

## Saya :
- **Nama:** Muhammad Deka Maulana
- **NIM:** 2311102148
- **Prodi:** S1 Teknik Informatika
- **Instansi:** Telkom University Purwokerto

---

## Output Program

Berikut adalah hasil jepretan layar saat program dijalankan :

### 1. Tampilan Awal
Saat halaman baru saja dibuka. Hanya ada judul dan tombol pemicu.
![Tampilan Awal](pertemuan-6/output tugas-laravel-ajax/tampilan-awal.png)

### 2. Tampilan Setelah Tombol Diklik
Setelah menekan tombol "Tampilkan Data", JavaScript akan melakukan *request* AJAX ke backend Laravel, mengambil data JSON, dan merendernya ke dalam bentuk Card Bootstrap.
![Tampilkan Data](pertemuan-6/output tugas-laravel-ajax/tampilkan-data.png)

---

## Struktur Kode

Berikut adalah bagian-bagian kode utama yang saya gunakan untuk menyelesaikan tugas ini :

### 1. Data JSON (`storage/app/mahasiswa.json`)
Data dummy yang saya gunakan sebagai pengganti database.
```json
[
    {
        "nama": "Muhammad Deka Maulana",
        "nim": "2311102148",
        "kelas": "IF-01-A",
        "prodi": "S1 Teknik Informatika"
    },
    {
        "nama": "Danendra Arden Shaduq",
        "nim": "2311102149",
        "kelas": "IF-01-A",
        "prodi": "S1 Teknik Informatika"
    },
    {
        "nama": "Budi Santoso",
        "nim": "2311102150",
        "kelas": "IF-01-B",
        "prodi": "S1 Teknik Informatika"
    }
]
```
### 2. Controller (app/Http/Controllers/MahasiswaController.php)
Di sini saya membuat logika untuk merender tampilan awal dan membuat endpoint API sederhana untuk membaca file JSON di atas.
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

        $jsonContent = File::get($path);
        $data = json_decode($jsonContent, true);

        return response()->json($data);
    }
}
```

### 3. Routing (routes/web.php)
Saya mendaftarkan dua route, satu untuk halaman utama dan satu lagi untuk jalur AJAX.
```php
<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MahasiswaController;

Route::get('/', [MahasiswaController::class, 'index']);
Route::get('/api/mahasiswa', [MahasiswaController::class, 'getJsonData']);
```

### 4. Tampilan & AJAX (resources/views/welcome.blade.php)
Bagian frontend menggunakan Bootstrap 5 untuk merapikan desain. Saya menggunakan Event Listener dan Fetch API untuk menangani click pada tombol dan mengambil datanya.
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
            
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Memuat...';
            btn.disabled = true;

            fetch('/api/mahasiswa')
                .then(response => response.json())
                .then(data => {
                    areaHasil.innerHTML = ''; 

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
                        areaHasil.innerHTML += card;
                    });
                })
                .catch(error => {
                    console.error('Error:', error);
                    areaHasil.innerHTML = '<div class="alert alert-danger text-center">Gagal mengambil data!</div>';
                })
                .finally(() => {
                    btn.innerHTML = 'Tampilkan Data';
                    btn.disabled = false;
                });
        });
    </script>
</body>
</html>
```