// lib/modul_02/widgets/matakuliah_card.dart
import 'package:flutter/material.dart';
import '../models/matakuliah.dart';

class MataKuliahCard extends StatelessWidget {
  final MataKuliah mataKuliah;

  const MataKuliahCard({super.key, required this.mataKuliah});

  // Fungsi untuk menampilkan pop-up rincian dari bawah (Modal BottomSheet)
  void _showDetailBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Kode & Nama Mata Kuliah
              Text(
                '${mataKuliah.code} - ${mataKuliah.name}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              const SizedBox(height: 12),
              
              // Info Dosen
              Row(
                children: [
                  const Icon(Icons.person, size: 18, color: Color(0xFF0284C7)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Dosen: ${mataKuliah.lecturer}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Info Ruang & SKS
              Row(
                children: [
                  const Icon(Icons.meeting_room, size: 18, color: Color(0xFF0284C7)),
                  const SizedBox(width: 8),
                  Text('Ruang: ${mataKuliah.room} • ${mataKuliah.sks} SKS'),
                ],
              ),
              const Divider(height: 24),

              // Info Progress Pembelajaran
              Text(
                'Progress Pembelajaran: ${(mataKuliah.progress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: mataKuliah.progress,
                borderRadius: BorderRadius.circular(4),
                minHeight: 8,
              ),
              const SizedBox(height: 20),

              // Tombol Tutup Rincian
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0284C7),
                  ),
                  child: const Text('Tutup Rincian'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // InkWell membuat kartu bisa diklik
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showDetailBottomSheet(context), // Memanggil pop-up saat diklik
        child: Stack(
          children: [
            // Konten utama kartu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mataKuliah.code,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    mataKuliah.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          mataKuliah.lecturer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.meeting_room_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 6),
                      Text(
                        mataKuliah.room,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Progres Sesi', style: theme.textTheme.labelSmall),
                          Text(
                            '${(mataKuliah.progress * 100).toInt()}%',
                            style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: mataKuliah.progress,
                        borderRadius: BorderRadius.circular(4),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Badge SKS di pojok kanan atas
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${mataKuliah.sks} SKS',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}