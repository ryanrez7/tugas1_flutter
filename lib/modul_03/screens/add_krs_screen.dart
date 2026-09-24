import 'package:flutter/material.dart';

import '../models/krs_course.dart';

class AddKrsScreen extends StatefulWidget {
  const AddKrsScreen({super.key});

  @override
  State<AddKrsScreen> createState() => _AddKrsScreenState();
}

class _AddKrsScreenState extends State<AddKrsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lecturerController = TextEditingController();
  final TextEditingController _sksController = TextEditingController(text: '3');

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _lecturerController.dispose();
    _sksController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final KrsCourse courseBaru = KrsCourse(
      code: _codeController.text.trim().toUpperCase(),
      name: _nameController.text.trim(),
      lecturer: _lecturerController.text.trim(),
      sks: int.tryParse(_sksController.text.trim()) ?? 3,
    );

    Navigator.pop(context, courseBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Mata Kuliah')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Mata Kuliah',
                  hintText: 'Contoh: TRPL501',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final teks = value?.trim() ?? '';
                  if (teks.isEmpty) return 'Kode mata kuliah wajib diisi';
                  if (teks.length < 4)
                    return 'Kode minimal terdiri dari 4 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mata Kuliah',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final teks = value?.trim() ?? '';
                  if (teks.isEmpty) return 'Nama mata kuliah wajib diisi';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lecturerController,
                decoration: const InputDecoration(
                  labelText: 'Nama Dosen Pengampu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final teks = value?.trim() ?? '';
                  if (teks.isEmpty) return 'Nama dosen wajib diisi';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _sksController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Jumlah SKS',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final teks = value?.trim() ?? '';
                  if (teks.isEmpty) return 'SKS wajib diisi';
                  final sks = int.tryParse(teks);
                  if (sks == null || sks <= 0)
                    return 'SKS harus berupa angka positif';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _simpan,
                child: const Text('Simpan Mata Kuliah'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
