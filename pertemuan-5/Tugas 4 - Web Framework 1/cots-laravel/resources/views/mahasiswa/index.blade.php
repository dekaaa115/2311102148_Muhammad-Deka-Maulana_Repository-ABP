<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Data Mahasiswa</title>
    <meta name="csrf-token" content="{{ csrf_token() }}"> 
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css">
</head>
<body class="container mt-5">
    <h2>Daftar Mahasiswa (Laravel JSON DataTables)</h2>
    <a href="/create" class="btn btn-primary mb-3">Tambah Data</a>
    
    <table id="tabelMahasiswa" class="table table-striped table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th>NIM</th>
                <th>Nama</th>
                <th>Jurusan</th>
                <th>Aksi</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>

    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>

    <script>
        $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
        });

        $(document).ready(function() {
            $('#tabelMahasiswa').DataTable({
                ajax: '/api/mahasiswa',
                columns: [
                    { data: 'id' },
                    { data: 'nim' },
                    { data: 'nama' },
                    { data: 'jurusan' },
                    { 
                        data: null, 
                        render: function(data, type, row) {
                            return `<a href="/edit/${row.id}" class="btn btn-sm btn-warning">Edit</a>
                                    <button class="btn btn-sm btn-danger" onclick="hapusData(${row.id})">Hapus</button>`;
                        }
                    }
                ]
            });
        });

        function hapusData(id) {
            if(confirm('Hapus data ini?')) {
                $.ajax({
                    url: '/api/mahasiswa/' + id,
                    type: 'DELETE',
                    success: function(response) {
                        alert(response.message);
                        $('#tabelMahasiswa').DataTable().ajax.reload();
                    }
                });
            }
        }
    </script>
</body>
</html>