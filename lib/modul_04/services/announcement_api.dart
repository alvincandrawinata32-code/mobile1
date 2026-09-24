import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/announcement.dart';

class AnnouncementApi {
  AnnouncementApi({http.Client? client, this.modeSimulasi = false})
      : _client = client ?? http.Client(),
        _milikSendiri = client == null;

  final http.Client _client;
  final bool _milikSendiri;

  /// `true`  → data lokal yang sengaja ditunda 1 detik (uji konsep).
  /// `false` → request HTTP GET sungguhan.
  final bool modeSimulasi;

  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration batasWaktu = Duration(seconds: 10);

  static const List<String> daftarKategori = <String>[
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  Future<List<Announcement>> ambilPengumuman() async {
    // ── Mode simulasi: tidak menyentuh jaringan sama sekali ──────────────
    if (modeSimulasi) {
      await Future<void>.delayed(const Duration(seconds: 1));
      return Announcement.getSampleAnnouncements();
    }

    // ── Mode nyata: satu request HTTP GET ───────────────────────────────
    final http.Response response;
    try {
      response = await _client
          .get(Uri.parse('$baseUrl/posts?_limit=10'))
          .timeout(batasWaktu);
    } on TimeoutException {
      throw Exception(
        'Koneksi ke server timeout. Periksa sambungan internet Anda.',
      );
    } on http.ClientException {
      throw Exception(
        'Gagal terhubung ke server. Periksa koneksi data atau Wi-Fi Anda.',
      );
    }

    if (response.statusCode != 200) {
      throw Exception('Server merespons dengan status ${response.statusCode}.');
    }

    final List<dynamic> baris;
    try {
      baris = jsonDecode(response.body) as List<dynamic>;
    } on FormatException {
      throw Exception('Respons server bukan JSON yang valid.');
    }

    return List<Announcement>.generate(
      baris.length,
      (int i) {
        final Map<String, dynamic> mentah = baris[i] as Map<String, dynamic>;

        // jsonplaceholder hanya menyediakan `id`, `title`, dan `body`.
        // Empat field sisanya kita lengkapi agar model tetap utuh.
        return Announcement.fromJson(<String, dynamic>{
          'id': mentah['id'],
          'title': mentah['title'],
          'content': mentah['body'],
          'author': 'Bagian Akademik Poliwangi',
          'category': daftarKategori[i % daftarKategori.length],
          'date': '2026-09-${(i % 28 + 1).toString().padLeft(2, '0')}',
          'readCount': (i + 1) * 37,
        });
      },
      growable: false,
    );
  }

  void tutup() {
    if (_milikSendiri) _client.close();
  }
}