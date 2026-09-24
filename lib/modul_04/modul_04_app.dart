import 'package:flutter/material.dart';

import 'screens/announcement_list_screen.dart';
import 'services/announcement_api.dart';

/// `true` bila dijalankan dengan `--dart-define=SIMULASI=true`.
const bool kModeSimulasi = bool.fromEnvironment('SIMULASI');

class Modul04App extends StatelessWidget {
  const Modul04App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Modul 04 — Future & REST API Dasar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0284C7)),
        useMaterial3: true,
      ),
      home: AnnouncementListScreen(
        api: AnnouncementApi(modeSimulasi: kModeSimulasi),
      ),
    );
  }
}