// lib/modul_02/widgets/header_banner.dart
import 'package:flutter/material.dart';

// Banner header profil mahasiswa di bagian atas dashboard
class HeaderBanner extends StatelessWidget {
  final String studentName;
  final String nim;

  const HeaderBanner({
    super.key,
    this.studentName = 'Alvin Candra Winata',
    this.nim = '362558302055',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0284C7), Color(0xFF0369A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4D0284C7), // Transparansi 30% tanpa withOpacity
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF), // Putih transparansi 20%
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Semester 5 (2026/2027)',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.notifications_active_outlined, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Selamat Datang, $studentName ($nim)',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dashboard Akademik & Proyek',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StatPill(icon: Icons.task_alt, label: '4 Matakuliah'),
              _StatPill(icon: Icons.grade, label: 'IPK 3.85'),
              _StatPill(icon: Icons.calendar_month, label: '100% Hadir'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0x33000000), // Hitam transparansi 20%
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
