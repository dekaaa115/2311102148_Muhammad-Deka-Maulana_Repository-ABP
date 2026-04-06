<div align="center">
  <br />
  <h1>LAPORAN PRAKTIKUM<br>APLIKASI BERBASIS PLATFORM</h1>
  <br />
  <h3>CODING ON THE SPOT<br>MANAJEMEN DATA MAHASISWA</h3>
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

### CRUD (Create, Read, Update, Delete)
Konsep CRUD (Create, Read, Update, Delete) merupakan paradigma fundamental dalam manajemen dan manipulasi data pada sebuah sistem informasi. Secara terminologi, konsep ini merepresentasikan empat operasi dasar yang saling berintegrasi pada basis data, yaitu : Create (menciptakan atau menambah data baru), Read (membaca atau menampilkan informasi), Update (memodifikasi data yang telah ada), dan Delete (menghapus rekaman data). Dalam arsitektur web modern, operasi ini selaras dengan protokol komunikasi HTTP seperti GET, POST, PUT/PATCH, dan DELETE.

### Node.js & Express
Node.js adalah lingkungan *runtime* JavaScript lintas platform yang mengeksekusi kode JavaScript di luar peramban web (sisi server). Node.js menggunakan arsitektur *event-driven* dan *non-blocking I/O* yang membuatnya ringan dan efisien. Express adalah kerangka kerja aplikasi web (framework) minimalis dan fleksibel untuk Node.js yang menyediakan serangkaian fitur kuat untuk membangun aplikasi web dan API, termasuk memfasilitasi penanganan rute (routing) dan *middleware*.

### SQLite
SQLite adalah sistem manajemen basis data relasional (RDBMS) yang terintegrasi secara mandiri (*self-contained*), tanpa server (*serverless*), dan tidak memerlukan konfigurasi (*zero-configuration*). Berbeda dengan RDBMS lain seperti MySQL yang beroperasi sebagai proses latar belakang terpisah, SQLite membaca dan menulis langsung ke dalam file disk biasa, menjadikannya pilihan yang sangat ringan dan efisien untuk aplikasi berskala kecil hingga menengah.

### Bootstrap
Bootstrap adalah kerangka kerja CSS *front-end* yang dimanfaatkan untuk merancang antarmuka web agar responsif, modern, dan efisien tanpa harus menulis kode CSS dari awal. Mengadopsi sistem grid 12-kolom dan komponen siap pakai, Bootstrap mengotomatisasi aspek tata letak sehingga elemen visual dapat beradaptasi dinamis pada berbagai ukuran resolusi layar.

### jQuery & DataTables
jQuery adalah pustaka JavaScript yang mempermudah manipulasi Document Object Model (DOM), penanganan peristiwa, dan implementasi AJAX dengan sintaks yang lebih bersih. DataTables adalah ekstensi dari jQuery yang mengevolusi tabel HTML statis menjadi tabel interaktif. Plug-in ini menyediakan fitur lanjutan seperti pencarian data langsung, pengurutan, dan pembagian halaman (pagination), serta sangat efektif untuk merender data berformat JSON dari API.

### JSON (JavaScript Object Notation)
JSON adalah format serialisasi data tekstual yang ringan dan mudah dibaca oleh manusia serta mesin. JSON berfungsi sebagai jembatan komunikasi utama antara *frontend* dan *backend*, merepresentasikan data dalam bentuk pasangan kunci-nilai (*key-value pairs*). 

### EJS (Embedded JavaScript)
EJS adalah mesin templating sederhana yang memungkinkan pembuatan markup HTML dengan JavaScript murni. EJS memudahkan injeksi data dari server (Node.js) langsung ke dalam struktur antarmuka pengguna secara dinamis sebelum dirender oleh peramban web.

## 2. Struktur Folder
```text
Coding-On-The-Spot/
├── node_modules/       
├── views/              
│   ├── index.ejs       
│   ├── form.ejs        
│   └── table.ejs       
├── package.json        
├── package-lock.json   
├── server.js           
├── database.sqlite     
└── README.md           
````

## 3\. Sourcecode

### server.js

```javascript
const express = require('express');
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const path = require('path');

const app = express();
const db = new sqlite3.Database('./database.sqlite');

app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

db.run(`CREATE TABLE IF NOT EXISTS mahasiswa (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nama TEXT,
    nim TEXT,
    jurusan TEXT
)`);

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/form', (req, res) => {
    res.render('form', { data: null });
});

app.get('/data', (req, res) => {
    res.render('table');
});

app.get('/api/mahasiswa', (req, res) => {
    db.all("SELECT * FROM mahasiswa", [], (err, rows) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ data: rows });
    });
});

app.post('/api/mahasiswa', (req, res) => {
    const { nama, nim, jurusan } = req.body;
    db.run(`INSERT INTO mahasiswa (nama, nim, jurusan) VALUES (?, ?, ?)`, [nama, nim, jurusan], function(err) {
        if (err) {
            return res.status(500).send(err.message);
        }
        res.redirect('/data');
    });
});

app.get('/form/:id', (req, res) => {
    const id = req.params.id;
    db.get(`SELECT * FROM mahasiswa WHERE id = ?`, [id], (err, row) => {
        res.render('form', { data: row });
    });
});

app.post('/api/mahasiswa/:id', (req, res) => {
    const id = req.params.id;
    const { nama, nim, jurusan } = req.body;
    db.run(`UPDATE mahasiswa SET nama = ?, nim = ?, jurusan = ? WHERE id = ?`, [nama, nim, jurusan, id], function(err) {
        res.redirect('/data');
    });
});

app.get('/api/mahasiswa/delete/:id', (req, res) => {
    const id = req.params.id;
    db.run(`DELETE FROM mahasiswa WHERE id = ?`, [id], function(err) {
        res.redirect('/data');
    });
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
```

### views/index.ejs

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link href="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css)" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Coding-On-The-Spot</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/form">Form</a></li>
                    <li class="nav-item"><a class="nav-link" href="/data">Data Tabel</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <div class="text-center">
            <h1 class="display-4">Selamat Datang</h1>
            <p class="lead">Aplikasi web sederhana dengan Bootstrap, Node.js, dan jQuery DataTable.</p>
            <a class="btn btn-primary btn-lg" href="/data" role="button">Lihat Data</a>
        </div>
    </div>
    <script src="[https://code.jquery.com/jquery-3.6.0.min.js](https://code.jquery.com/jquery-3.6.0.min.js)"></script>
    <script src="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js)"></script>
</body>
</html>
```

### views/form.ejs

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Data</title>
    <link href="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css)" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Coding-On-The-Spot</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/form">Form</a></li>
                    <li class="nav-item"><a class="nav-link" href="/data">Data Tabel</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <h2>Form Mahasiswa</h2>
        <form action="<%= data ? '/api/mahasiswa/' + data.id : '/api/mahasiswa' %>" method="POST">
            <div class="mb-3">
                <label class="form-label">Nama</label>
                <input type="text" class="form-control" name="nama" value="<%= data ? data.nama : '' %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">NIM</label>
                <input type="text" class="form-control" name="nim" value="<%= data ? data.nim : '' %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Jurusan</label>
                <input type="text" class="form-control" name="jurusan" value="<%= data ? data.jurusan : '' %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Simpan</button>
            <a href="/data" class="btn btn-secondary">Batal</a>
        </form>
    </div>
    <script src="[https://code.jquery.com/jquery-3.6.0.min.js](https://code.jquery.com/jquery-3.6.0.min.js)"></script>
    <script src="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js)"></script>
</body>
</html>
```

### views/table.ejs

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Tabel</title>
    <link href="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css)" rel="stylesheet">
    <link rel="stylesheet" href="[https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css](https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css)">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Coding-On-The-Spot</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="/form">Form</a></li>
                    <li class="nav-item"><a class="nav-link" href="/data">Data Tabel</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <h2>Data Mahasiswa</h2>
        <a href="/form" class="btn btn-success mb-3">Tambah Data</a>
        <table id="dataTable" class="table table-striped table-bordered" style="width:100%">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nama</th>
                    <th>NIM</th>
                    <th>Jurusan</th>
                    <th>Aksi</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <script src="[https://code.jquery.com/jquery-3.6.0.min.js](https://code.jquery.com/jquery-3.6.0.min.js)"></script>
    <script src="[https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js](https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js)"></script>
    <script src="[https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js](https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js)"></script>
    <script src="[https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js](https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js)"></script>

    <script>
        $(document).ready(function() {
            $('#dataTable').DataTable({
                "ajax": "/api/mahasiswa",
                "columns": [
                    { "data": "id" },
                    { "data": "nama" },
                    { "data": "nim" },
                    { "data": "jurusan" },
                    {
                        "data": null,
                        "render": function (data, type, row) {
                            return `
                                <a href="/form/${row.id}" class="btn btn-sm btn-warning">Edit</a>
                                <a href="/api/mahasiswa/delete/${row.id}" class="btn btn-sm btn-danger" onclick="return confirm('Yakin ingin menghapus?')">Delete</a>
                            `;
                        }
                    }
                ]
            });
        });
    </script>
</body>
</html>
```

## 4\. Penjelasan Cara Kerja Aplikasi & Screenshot Output

Berikut merupakan cara kerja aplikasi dan screenshot output berdasarkan masing-masing operasi CRUD (Create, Read, Update, Delete) :

### Operasi Read

Pada operasi Read (menampilkan data), proses terjadi ketika pengguna membuka halaman `/data`. Di halaman ini, tabel diinisialisasi menggunakan jQuery DataTables. DataTables secara otomatis mengirimkan *request* AJAX ke *endpoint* API `/api/mahasiswa`. *Endpoint* ini ditangani oleh backend Express.js, yang menjalankan perintah query `SELECT * FROM mahasiswa` ke dalam database SQLite. Hasil dari query tersebut kemudian dikembalikan dalam format JSON. Frontend DataTables menangkap JSON ini dan merendernya ke dalam kolom tabel yang telah dikonfigurasi, lengkap dengan fitur pencarian dan paginasi otomatis.
![OPERASI READ](/pertemuan-5/Coding-On-The-Spot/assets/read.png)

### Operasi Create

Operasi Create (penambahan data) diawali saat pengguna menekan tombol "Tambah Data" atau menavigasi ke halaman `/form`. Halaman form dirender menggunakan templating EJS. Ketika pengguna mengisi data Nama, NIM, dan Jurusan lalu menekan tombol Simpan, aplikasi akan mengirimkan HTTP POST request menuju *endpoint* `/api/mahasiswa`. Data dari formulir (*body request*) ditangkap oleh Express.js, lalu dieksekusi menggunakan perintah `INSERT INTO` ke tabel SQLite. Setelah data berhasil tersimpan, *server* secara otomatis akan melakukan *redirect* (mengarahkan kembali) pengguna ke halaman tabel `/data` untuk melihat data yang baru saja ditambahkan.
![OPERASI CREATE](/pertemuan-5/Coding-On-The-Spot/assets/form_create.png)
![OPERASI CREATE](/pertemuan-5/Coding-On-The-Spot/assets/after_create.png)

### Operasi Update

Operasi Update (mengubah data) dimulai saat pengguna menekan tombol "Edit" pada salah satu baris data di halaman tabel. Tombol ini mengarahkan pengguna ke *endpoint* GET `/form/:id`. Server Express.js menangkap ID tersebut, mencari data spesifik melalui query `SELECT` dari SQLite, lalu merender file `form.ejs` sambil menginjeksi (pre-populating) data lama ke dalam *input field*. Setelah pengguna memodifikasi data dan menekan simpan, sistem melakukan HTTP POST ke `/api/mahasiswa/:id`. Backend menangkap perubahan ini dan menjalankan query `UPDATE mahasiswa SET... WHERE id = ?`. Jika berhasil, pengguna akan langsung dialihkan kembali ke halaman Data Tabel.
![OPERASI UPDATE](/pertemuan-5/Coding-On-The-Spot/assets/form_edit.png)
![OPERASI UPDATE](/pertemuan-5/Coding-On-The-Spot/assets/after_edit.png)

### Operasi Delete

Operasi Delete (menghapus data) dilakukan melalui tabel interaktif. Pada kolom Aksi di DataTables, terdapat tombol "Delete" yang dikonfigurasi memiliki rute tautan `/api/mahasiswa/delete/:id`. Saat ditekan, peramban akan memunculkan pesan peringatan JavaScript *native* `confirm()` untuk mencegah penghapusan yang tidak disengaja. Jika pengguna menyetujui, *request* GET dikirimkan ke *endpoint* tersebut. *Server* Express.js mengeksekusi perintah SQL `DELETE FROM mahasiswa WHERE id = ?`. Seketika setelah data berhasil dihapus secara permanen dari SQLite, halaman akan langsung kembali me-*redirect* ke `/data`.
![OPERASI DELETE](/pertemuan-5/Coding-On-The-Spot/assets/popup_delete.png)
![OPERASI DELETE](/pertemuan-5/Coding-On-The-Spot/assets/after_delete.png)

### Operasi Search
Fitur pencarian di DataTables memungkinkan pengguna untuk mencari data secara real-time. Saat pengguna mengetikkan kata kunci di kotak pencarian, DataTables secara otomatis mengirimkan permintaan AJAX ke *endpoint* `/api/mahasiswa` dengan parameter pencarian yang sesuai. Backend Express.js menangani permintaan ini dengan menjalankan query SQL yang memfilter data berdasarkan kata kunci yang dimasukkan. Hasilnya dikembalikan dalam format JSON, dan DataTables memperbarui tampilan tabel secara dinamis untuk menampilkan hanya data yang cocok dengan kriteria pencarian.
![OPERASI SEARCH](/pertemuan-5/Coding-On-The-Spot/assets/search.png)

## Kesimpulan

Aplikasi web sederhana ini berhasil dibangun menggunakan *runtime* Node.js dengan kerangka kerja Express.js untuk sisi *backend* dan SQLite sebagai basis data yang ringan. Implementasi konsep CRUD (Create, Read, Update, Delete) berjalan dengan lancar dan selaras melalui arsitektur perutean *endpoint* API. Pada sisi *frontend*, penggunaan framework Bootstrap memastikan tata letak yang bersih dan responsif, sementara perpaduan jQuery dan DataTables memungkinkan pengelolaan serta visualisasi data secara interaktif dan dinamis menggunakan format pertukaran data JSON.

## Link PPT & Video Presentasi

https://drive.google.com/drive/folders/1PnPKE7WP3j4JBfVMFI1R9KLa1TH7ZVlT?usp=sharing
