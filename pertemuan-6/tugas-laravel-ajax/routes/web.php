<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MahasiswaController;

// Route Halaman Utama
Route::get('/', [MahasiswaController::class, 'index']);

// Route untuk AJAX mengambil data
Route::get('/api/mahasiswa', [MahasiswaController::class, 'getJsonData']);