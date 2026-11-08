import '../../modul_07/data/repositori_tugas_memori.dart';
import '../../modul_07/data/sumber_tugas_memori.dart';
import '../../modul_07/domain/repositori_tugas.dart';
import '../presentation/view_model_tugas_pengayaan.dart';
import '../usecase/hapus_tugas.dart';
import '../usecase/muat_daftar_tugas.dart';
import '../usecase/tambah_tugas.dart';
import '../usecase/ubah_status_tugas.dart';

// Lokator milik contoh Modul 07, terpisah dari container global fitur lain.
final Lokator lokator = Lokator();

class Lokator {
  final Map<Type, Object Function()> _lazyFactories = {};
  final Map<Type, Object Function()> _factories = {};
  final Map<Type, Object> _instances = {};

  void registerLazySingleton<T extends Object>(T Function() factory) {
    _lazyFactories[T] = factory;
  }

  void registerFactory<T extends Object>(T Function() factory) {
    _factories[T] = factory;
  }

  T call<T extends Object>() {
    final instance = _instances[T];
    if (instance != null) return instance as T;

    final lazyFactory = _lazyFactories[T];
    if (lazyFactory != null) {
      final created = lazyFactory();
      _instances[T] = created;
      return created as T;
    }

    final factory = _factories[T];
    if (factory != null) return factory() as T;

    throw StateError('Tidak ada registrasi untuk $T.');
  }

  Future<void> reset() async {
    _lazyFactories.clear();
    _factories.clear();
    _instances.clear();
  }
}

Future<void> siapkanLokator({RepositoriTugas? repositori}) async {
  await lokator.reset();

  lokator.registerLazySingleton<RepositoriTugas>(
    () => repositori ?? RepositoriTugasMemori(SumberTugasMemori()),
  );

  lokator.registerLazySingleton<MuatDaftarTugas>(
    () => MuatDaftarTugas(lokator<RepositoriTugas>()),
  );
  lokator.registerLazySingleton<TambahTugas>(
    () => TambahTugas(lokator<RepositoriTugas>()),
  );
  lokator.registerLazySingleton<UbahStatusTugas>(
    () => UbahStatusTugas(lokator<RepositoriTugas>()),
  );
  lokator.registerLazySingleton<HapusTugas>(
    () => HapusTugas(lokator<RepositoriTugas>()),
  );

  lokator.registerFactory<ViewModelTugasPengayaan>(
    () => ViewModelTugasPengayaan(
      muatDaftar: lokator<MuatDaftarTugas>(),
      tambahTugas: lokator<TambahTugas>(),
      ubahStatusTugas: lokator<UbahStatusTugas>(),
      hapusTugas: lokator<HapusTugas>(),
    ),
  );
}

Future<void> bersihkanLokator() async {
  await lokator.reset();
}
