class MataKuliah {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress; // progres silabus (0.0 - 1.0)
  final String room;

  const MataKuliah({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.room = 'Lab Komputer 3',
  });

  // Data dummy untuk bahan praktikum [4]
  static List<MataKuliah> getSampleCourses() {
    return const [
      MataKuliah(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Galih Hendra Wibowo, S.Tr.Kom., M.T.',
        sks: 4,
        progress: 0.25,
        room: 'Lab TUK',
      ),
      MataKuliah(
        code: 'TRPL502',
        name: 'Rekayasa Kebutuhan Perangkat Lunak',
        lecturer: 'Bu Eka Novita Sari, S.ST., M.T.',
        sks: 3,
        progress: 0.40,
        room: 'G4.01',
      ),
      MataKuliah(
        code: 'TRPL503',
        name: 'Metode pengembangan Perangkat Lunak',
        lecturer: 'Ruth Ema Febrita, S.Pd., M.Kom.',
        sks: 3,
        progress: 0.60,
        room: 'G6.04',
      ),
      MataKuliah(
        code: 'TRPL504',
        name: 'Basis data Lanjut',
        lecturer: 'Ibu Eka Mistiko Rini, S.Kom., M.Kom.,',
        sks: 2,
        progress: 0.15,
        room: 'Lab Basis Data',
      ),
    ];
  }
}
