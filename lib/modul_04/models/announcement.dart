class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    required this.readCount,
  });

  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Bagian Akademik Poliwangi',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  static List<Announcement> getSampleAnnouncements() {
    return const [
      Announcement(
        id: 1,
        title: 'Jadwal Daftar Ulang Semester Ganjil 2026/2027',
        content: 'Seluruh mahasiswa diharapkan menyelesaikan pembayaran UKT.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 120,
      ),
      Announcement(
        id: 2,
        title: 'Pendaftaran Beasiswa Prestasi D3 & D4',
        content: 'Pembukaan pendaftaran beasiswa prestasi dibuka hingga akhir bulan.',
        author: 'Kemahasiswaan Poliwangi',
        category: 'Beasiswa',
        date: '2026-09-02',
        readCount: 85,
      ),
    ];
  }
}
