import 'package:flutter/material.dart';
import '../helpers/ui_helpers.dart';

class HalamanForm extends StatefulWidget {
  const HalamanForm({super.key});
  @override
  State<HalamanForm> createState() => _HalamanFormState();
}

class _HalamanFormState extends State<HalamanForm> {
  final _key   = GlobalKey<FormState>();
  final _nama  = TextEditingController();
  final _email = TextEditingController();
  String _gender = 'Laki-laki';

  InputDecoration _deco(String label, IconData icon) => InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: Colors.grey),
    prefixIcon: Icon(icon, color: Colors.teal),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.teal, width: 2)),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
  );

  void _submit() {
    if (!_key.currentState!.validate()) {
      popupAlert(context,
        judul: 'Form Tidak Lengkap',
        isi: 'Harap isi semua field yang wajib diisi sebelum mengirim.',
        icon: Icons.warning_amber_rounded, iconColor: Colors.red,
      );
      return;
    }
    popupAlert(context,
      judul: 'Data Terkirim!',
      isi: 'Nama: ${_nama.text}\nEmail: ${_email.text}\nGender: $_gender',
      icon: Icons.check_circle, iconColor: Colors.teal,
      tombolBatal: 'Tutup',
      tombolOk: 'Reset Form',
      onOk: () {
        _nama.clear(); _email.clear();
        setState(() => _gender = 'Laki-laki');
        snack(context, 'Form direset', color: Colors.teal);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Input'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Isi Data Diri',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 8),
              const Text('Pastikan data yang diisi sudah benar dan sesuai.',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 28),
              TextFormField(
                controller: _nama,
                decoration: _deco('Nama Lengkap', Icons.person_outline),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration: _deco('Email', Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => v!.isEmpty
                    ? 'Wajib diisi'
                    : (!v.contains('@') ? 'Email tidak valid' : null)
              ),
              const SizedBox(height: 28),
              const Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: ['Laki-laki', 'Perempuan'].map((g) => RadioListTile<String>(
                    title: Text(g, style: const TextStyle(fontWeight: FontWeight.w500)),
                    value: g,
                    groupValue: _gender,
                    activeColor: Colors.teal,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    onChanged: (v) => setState(() => _gender = v!),
                  )).toList()
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Kirim Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  onPressed: _submit,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}