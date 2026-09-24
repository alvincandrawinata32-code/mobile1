import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  static const String kunciTugas = 'modul_05_tugas';
  static const String kunciVersi = 'modul_05_versi_skema';
  static const int versiSkema = 1;

  final Duration tunda;
  const TaskStorage({this.tunda = Duration.zero});

  Future<List<Task>> muat() async {
    if (tunda > Duration.zero) {
      await Future<void>.delayed(tunda);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? mentah = prefs.getString(kunciTugas);

    // Kunjungan pertama: belum ada apa pun di disk.
    if (mentah == null) {
      return List<Task>.of(Task.getSampleTasks());
    }

    final List<dynamic> baris;
    try {
      baris = jsonDecode(mentah) as List<dynamic>;
    } on FormatException {
      throw const FormatException(
        'Data tugas tersimpan rusak dan tidak dapat dibaca sebagai JSON.',
      );
    } on TypeError {
      throw const FormatException('Data tugas tersimpan bukan berbentuk daftar.');
    }

    return List<Task>.generate(
      baris.length,
      (int i) => Task.fromJson(baris[i] as Map<String, dynamic>),
      growable: true,
    );
  }

  Future<void> simpan(List<Task> tugas) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String mentah = jsonEncode(
      tugas.map((Task t) => t.toJson()).toList(growable: false),
    );

    final bool berhasil = await prefs.setString(kunciTugas, mentah);
    if (!berhasil) {
      throw Exception('Penyimpanan perangkat menolak penulisan data tugas.');
    }
    await prefs.setInt(kunciVersi, versiSkema);
  }

  Future<void> hapusSemua() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(kunciTugas);
    await prefs.remove(kunciVersi);
  }

  /// Hanya untuk praktikum: menulis data yang sengaja rusak.
  Future<void> rusakkanUntukDemo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(kunciTugas, '{ini sengaja bukan JSON yang sah');
  }
}