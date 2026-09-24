import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  /// Dapat disuntikkan dari luar (widget test atau demo offline).
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();
  late Future<List<Announcement>> _futurePengumuman;
  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru = _api.ambilPengumuman();
    setState(() {
      _futurePengumuman = futureBaru;
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error sudah ditangani FutureBuilder lewat `snapshot.hasError`.
    }
  }

  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) return;
    setState(() => _kategoriTerpilih = kategori);
  }

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // ── Keadaan 1: LOADING ────────────────────────────────
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }
                // ── Keadaan 2: ERROR ─────────────────────────────────
                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }
                // ── Keadaan 3 & 4: KOSONG / BERHASIL ─────────────────
                final List<Announcement> semua =
                    snapshot.data ?? const <Announcement>[];

                final List<Announcement> tampil = _kategoriTerpilih == 'Semua'
                    ? semua
                    : semua
                        .where(
                          (Announcement item) =>
                              item.category.toLowerCase() ==
                              _kategoriTerpilih.toLowerCase(),
                        )
                        .toList(growable: false);

                if (tampil.isEmpty) return _buildKosong();
                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── WIDGET BUILDERS ──

  Widget _buildBarisFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: _kategori.map((String kategori) {
          final bool isSelected = _kategoriTerpilih == kategori;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(kategori),
              selected: isSelected,
              onSelected: (_) => _pilihKategori(kategori),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMemuat() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildGagal(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(error.toString(), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _muatUlang, child: const Text('Coba Lagi')),
          ],
        ),
      ),
    );
  }

  Widget _buildKosong() {
    return const Center(child: Text('Tidak ada pengumuman tersedia.'));
  }

  Widget _buildDaftar(List<Announcement> daftar) {
    return RefreshIndicator(
      onRefresh: _muatUlang,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 12),
        itemCount: daftar.length,
        itemBuilder: (context, index) {
          return AnnouncementCard(
            announcement: daftar[index],
            onTap: () => _bukaDetail(daftar[index]),
          );
        },
      ),
    );
  }
}