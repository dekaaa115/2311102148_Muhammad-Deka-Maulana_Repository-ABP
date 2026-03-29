<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use Illuminate\Http\Request;

class MahasiswaController extends Controller
{
    public function index() {
        return view('mahasiswa.index');
    }
    public function create() {
        return view('mahasiswa.create');
    }

    public function dataJson() {
        $data = Mahasiswa::all();
        return response()->json(['data' => $data]);
    }

    public function store(Request $request) {
        Mahasiswa::create($request->all());
        return response()->json(['success' => true, 'message' => 'Data berhasil disimpan']);
    }

    public function destroy($id) {
        Mahasiswa::destroy($id);
        return response()->json(['success' => true, 'message' => 'Data berhasil dihapus']);
    }

    public function edit($id) {
        return view('mahasiswa.edit', compact('id'));
    }

    public function show($id) {
        $data = Mahasiswa::find($id);
        return response()->json($data);
    }

    public function update(Request $request, $id) {
        $mahasiswa = Mahasiswa::find($id);
        $mahasiswa->update($request->all());
        return response()->json(['success' => true, 'message' => 'Data berhasil diupdate']);
    }
}