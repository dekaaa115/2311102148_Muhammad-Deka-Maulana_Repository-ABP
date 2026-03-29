<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Tambah Data</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Tambah Data Mahasiswa</h2>
    <div class="card p-4 shadow-sm" style="max-width: 500px;">
        <form id="formTambah">
            <div class="mb-3">
                <label>NIM</label>
                <input type="text" id="nim" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Nama</label>
                <input type="text" id="nama" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Jurusan</label>
                <input type="text" id="jurusan" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-success">Simpan Data</button>
            <a href="/" class="btn btn-secondary">Batal</a>
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script>
        $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
        });

        $('#formTambah').submit(function(e) {
            e.preventDefault();
            
            $.ajax({
                url: '/api/mahasiswa',
                type: 'POST',
                data: {
                    nim: $('#nim').val(),
                    nama: $('#nama').val(),
                    jurusan: $('#jurusan').val()
                },
                success: function(response) {
                    alert(response.message);
                    window.location.href = '/';
                }
            });
        });
    </script>
</body>
</html>