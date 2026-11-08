import '../models/sesi_pengguna.dart';

class SesiMemori {
  SesiPengguna? _sesi;
  int jumlahPenulis = 0;

  SesiPengguna? baca() => _sesi;
  bool get adaSesi => _sesi != null;

  Future<void> simpan(SesiPengguna sesi) async {
    _sesi = sesi;
    jumlahPenulis++;
  }

  Future<void> hapus() async {
    _sesi = null;
  }
}
