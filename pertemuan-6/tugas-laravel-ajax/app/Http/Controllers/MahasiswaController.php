<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class MahasiswaController extends Controller
{
    // Menampilkan halaman utama
    public function index()
    {
        return view('welcome');
    }

    // Membaca file JSON dan merespons untuk AJAX
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