import 'package:flutter/material.dart';
import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  final Announcement announcement;

  const AnnouncementDetailScreen({
    super.key,
    required this.announcement,
  });

  @override
  State<AnnouncementDetailScreen> createState() => _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  bool _isLoading = false;
  bool _hasError = false;

  void _simulasiMuatUlang() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _pemicuError() {
    setState(() {
      _hasError = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${widget.announcement.title}'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Simulasi Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: _simulasiMuatUlang,
          ),
          IconButton(
            tooltip: 'Simulasi Error',
            icon: const Icon(Icons.bug_report),
            onPressed: _pemicuError,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // 1. STATE 1: LOADING
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat detail pengumuman...', style: TextStyle(color: Color(0xFF64748B))),
          ],
        ),
      );
    }

    // 2. STATE 2: ERROR (dengan Tombol Coba Lagi / Retry)
    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 64, color: Colors.redAccent),
              const SizedBox(height: 16),
              const Text(
                'Gagal Mengambil Detail Pengumuman',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Terjadi gangguan jaringan saat menghubungi server akademik. Silakan coba kembali.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _simulasiMuatUlang,
                style: FilledButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi (Retry)'),
              ),
            ],
          ),
        ),
      );
    }

    // 3. STATE 3: SUCCESS (Tampilkan Data Lengkap)
    // Catatan: `announcement` di sini wajib ada (non-nullable), sehingga
    // state "data tidak ditemukan" tidak lagi relevan di layar ini —
    // layar ini hanya dibuka ketika data sudah tersedia dari daftar.
    final Announcement announcement = widget.announcement;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          announcement.category,
                          style: const TextStyle(
                            color: Color(0xFF0284C7),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        announcement.date,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    announcement.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          announcement.author,
                          style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.visibility_outlined, size: 18, color: Color(0xFF64748B)),
                      const SizedBox(width: 8),
                      Text(
                        '${announcement.readCount} kali dibaca',
                        style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Isi Pengumuman',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 8),
          Text(
            announcement.content.isNotEmpty
                ? announcement.content
                : 'Belum ada isi untuk pengumuman ini.',
            style: const TextStyle(fontSize: 14, color: Color(0xFF475569), height: 1.5),
          ),
        ],
      ),
    );
  }
}