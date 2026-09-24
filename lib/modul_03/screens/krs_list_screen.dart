import 'package:flutter/material.dart';

import '../models/krs_course.dart';
import '../widgets/krs_course_tile.dart';
import 'add_krs_screen.dart';
import 'course_detail_screen.dart';

const int batasSksSemester = 24;
const int ambangPeringatanSks = 21;

class KrsListScreen extends StatefulWidget {
  const KrsListScreen({super.key});

  @override
  State<KrsListScreen> createState() => _KrsListScreenState();
}

class _KrsListScreenState extends State<KrsListScreen> {
  final List<KrsCourse> _courses = List<KrsCourse>.of(
    KrsCourse.getInitialCourses(),
  );

  int get _totalSks =>
      _courses.fold(0, (jumlah, course) => jumlah + course.sks);

  void _tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(pesan)));
  }

  void _bukaDetail(KrsCourse course) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => CourseDetailScreen(course: course),
      ),
    );
  }

  Future<void> _bukaFormTambah() async {
    final KrsCourse? courseBaru = await Navigator.push<KrsCourse>(
      context,
      MaterialPageRoute<KrsCourse>(builder: (_) => const AddKrsScreen()),
    );

    if (!mounted || courseBaru == null) return;

    final bool duplikat = _courses.any(
      (course) => course.code.toUpperCase() == courseBaru.code.toUpperCase(),
    );
    if (duplikat) {
      _tampilkanPesan('Kode ${courseBaru.code} sudah ada di rencana studi.');
      return;
    }

    final int totalBaru = _totalSks + courseBaru.sks;
    if (totalBaru > batasSksSemester) {
      _tampilkanPesan(
        'Total SKS akan menjadi $totalBaru, melebihi batas '
        '$batasSksSemester SKS.',
      );
      return;
    }

    setState(() => _courses.add(courseBaru));
    _tampilkanPesan('${courseBaru.name} ditambahkan ke rencana studi.');
  }

  Future<void> _konfirmasiHapus(KrsCourse course) async {
    final Color errorColor = Theme.of(context).colorScheme.error;

    final bool? dikonfirmasi = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus mata kuliah?'),
        content: Text(
          'Yakin ingin membatalkan pengambilan "${course.name}" '
          '(${course.sks} SKS)?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: errorColor),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted || dikonfirmasi != true) return;

    setState(() => _courses.removeWhere((item) => item.code == course.code));
    _tampilkanPesan('${course.name} dihapus dari rencana studi.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Studi (KRS)'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Chip(
                label: Text('Total SKS: $_totalSks / $batasSksSemester'),
                backgroundColor: _totalSks >= ambangPeringatanSks
                    ? Colors.orange.shade200
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: _courses.isEmpty
          ? const Center(child: Text('Belum ada mata kuliah yang diambil.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _courses.length,
              itemBuilder: (context, index) {
                final course = _courses[index];
                return KrsCourseTile(
                  course: course,
                  onTap: () => _bukaDetail(course),
                  onDelete: () => _konfirmasiHapus(course),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaFormTambah,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Matkul'),
      ),
    );
  }
}
