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

  // Tepat seperti yang ada di modul Anda
  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String? ?? 'Tanpa Judul',
      content: json['content'] as String? ?? json['body'] as String? ?? '',
      author: json['author'] as String? ?? 'Admin Jurusan',
      category: json['category'] as String? ?? 'Akademik',
      date: json['date'] as String? ?? '2026-09-01',
      readCount: json['readCount'] is int ? json['readCount'] as int : 0,
    );
  }

  // Data tiruan untuk kModeSimulasi
  static List<Announcement> getSampleAnnouncements() {
    return const [
      Announcement(
        id: 1,
        title: 'Pengumuman Pengisian KRS',
        content: 'Diberitahukan kepada seluruh mahasiswa bahwa pengisian KRS semester ganjil sudah dapat dilakukan melalui portal.',
        author: 'Admin Jurusan',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 120,
      ),
      Announcement(
        id: 2,
        title: 'Lomba Pemrograman Nasional',
        content: 'Ayo daftarkan tim terbaikmu di kompetisi hackathon nasional.',
        author: 'Kemahasiswaan',
        category: 'Prestasi',
        date: '2026-09-05',
        readCount: 75,
      ),
    ];
  }
}