import 'package:flutter/material.dart';

import '../models/sesi_pengguna.dart';

class KartuSesi extends StatelessWidget {
  final SesiPengguna sesi;
  final DateTime sekarang;
  final VoidCallback? onKeluar;
  final bool sedangKeluar;
  final bool tampilkanToken;

  const KartuSesi({
    super.key,
    required this.sesi,
    required this.sekarang,
    this.onKeluar,
    this.sedangKeluar = false,
    this.tampilkanToken = false,
  });

  static String samarkanToken(String token) {
    if (token.isEmpty) return '(kosong)';
    if (token.length <= 6) return _titik(token.length);
    return '${token.substring(0, 6)}${_titik(12)}';
  }

  static String _titik(int jumlah) =>
      List<String>.filled(jumlah, '\u2022').join();

  static String formatWaktu(String iso) {
    const List<String> bulan = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final DateTime? waktu = DateTime.tryParse(iso);
    if (waktu == null) return 'tidak diketahui';
    final String jam = waktu.hour.toString().padLeft(2, '0');
    final String menit = waktu.minute.toString().padLeft(2, '0');
    return '${waktu.day} ${bulan[waktu.month - 1]} ${waktu.year}, $jam:$menit';
  }

  static String formatSisa(Duration sisa) {
    if (sisa.inSeconds <= 0) return 'sudah berakhir';
    if (sisa.inMinutes < 1) return '${sisa.inSeconds} detik';
    if (sisa.inHours < 1) return '${sisa.inMinutes} menit';
    final int menit = sisa.inMinutes.remainder(60);
    return menit == 0
        ? '${sisa.inHours} jam'
        : '${sisa.inHours} jam $menit menit';
  }

  Widget _baris(String label, String nilai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(label, style: const TextStyle(color: Colors.black54)),
          ),
          Expanded(child: Text(nilai)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final Duration sisa = sesi.sisaWaktu(sekarang);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: warna.primaryContainer,
                  child: Icon(
                    Icons.person_rounded,
                    color: warna.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        sesi.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(SesiPengguna.labelPeran(sesi.peran)),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            _baris('Email', sesi.email),
            _baris('Masuk pada', formatWaktu(sesi.masukPada)),
            _baris('Berakhir pada', formatWaktu(sesi.kadaluwarsaPada)),
            _baris('Sisa waktu', formatSisa(sisa)),
            _baris(
              'Token',
              tampilkanToken ? sesi.token : samarkanToken(sesi.token),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: sedangKeluar ? null : onKeluar,
                icon: sedangKeluar
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout_rounded),
                label: Text(sedangKeluar ? 'Keluar...' : 'Keluar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
