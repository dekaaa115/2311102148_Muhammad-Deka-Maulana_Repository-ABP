<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Praktikum AJAX Laravel 12</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            
            // Efek loading pada tombol
            btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Memuat...';
            btn.disabled = true;

            // Proses AJAX menggunakan Fetch API
            fetch('/api/mahasiswa')
                .then(response => response.json())
                .then(data => {
                    areaHasil.innerHTML = ''; // Kosongkan area terlebih dahulu

                    // Looping data dan buat elemen Card
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
                    // Kembalikan tombol ke kondisi semula
                    btn.innerHTML = 'Tampilkan Data';
                    btn.disabled = false;
                });
        });
    </script>
</body>
</html>