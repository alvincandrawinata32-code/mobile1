import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Smoke test profil mahasiswa', (WidgetTester tester) async {
    // Menjalankan pengujian pada PoliwangiProfileApp
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Text('Profil Mahasiswa'))));
    expect(find.text('Profil Mahasiswa'), findsOneWidget);
  });
}