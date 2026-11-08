class Announcement {
  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    required this.readCount,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      readCount: json['readCount'] as int,
    );
  }

  static List<Announcement> getSampleAnnouncements() {
    return const [
      Announcement(
        id: 1,
        title: 'Pendaftaran Beasiswa PPA 2026 Dibuka',
        content: 'Mahasiswa aktif dapat mendaftar beasiswa PPA mulai minggu ini.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Beasiswa',
        date: '2026-09-01',
        readCount: 120,
      ),
      Announcement(
        id: 2,
        title: 'Jadwal UTS Semester Ganjil',
        content: 'Jadwal Ujian Tengah Semester telah dirilis, cek di portal akademik.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-05',
        readCount: 89,
      ),
    ];
  }
}