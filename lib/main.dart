import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ust_ekran.dart';

/// Uygulamanın giriş noktası
void main() {
  runApp(const KavanozApp());
}

/// KavanozApp - Ana MaterialApp widget'ı
/// Tema yönetimini (koyu/beyaz) üstlenir.
class KavanozApp extends StatefulWidget {
  const KavanozApp({super.key});

  @override
  State<KavanozApp> createState() => _KavanozAppState();
}

class _KavanozAppState extends State<KavanozApp> {
  // İlk açılışta koyu temanın gelmesi için true yaptık
  bool _karanlikTema = true;

  /// Tema değiştirme fonksiyonu
  void _temaDegistir() {
    setState(() {
      _karanlikTema = !_karanlikTema;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kavanoz'la Unutma",
      debugShowCheckedModeBanner: false,

      // ---- BEYAZ TEMA ----
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8E1),
      ),

      // ---- KOYU TEMA ----
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),

      // Aktif tema modu
      themeMode: _karanlikTema ? ThemeMode.dark : ThemeMode.light,

      // Üst ekran tüm state yönetimini üstlenir
      home: UstEkran(
        karanlikTema: _karanlikTema,
        temaDegistir: _temaDegistir,
      ),
    );
  }
}
