<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MahasiswaController;

Route::get('/', [MahasiswaController::class, 'index']);
Route::get('/create', [MahasiswaController::class, 'create']);

Route::get('/api/mahasiswa', [MahasiswaController::class, 'dataJson']);
Route::post('/api/mahasiswa', [MahasiswaController::class, 'store']);
Route::delete('/api/mahasiswa/{id}', [MahasiswaController::class, 'destroy']);

// tampilan Halaman Edit
Route::get('/edit/{id}', [MahasiswaController::class, 'edit']);

// API untuk update data
Route::get('/api/mahasiswa/{id}', [MahasiswaController::class, 'show']); // Ambil data spesifik
Route::put('/api/mahasiswa/{id}', [MahasiswaController::class, 'update']); // Proses update