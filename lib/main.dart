import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'ust_ekran.dart';

/// Uygulamanın giriş noktası
void main() {
  runApp(const KavanozApp());
}

/// KavanozApp - Ana MaterialApp widget'ı
class KavanozApp extends StatefulWidget {
  const KavanozApp({super.key});

  @override
  State<KavanozApp> createState() => _KavanozAppState();
}

class _KavanozAppState extends State<KavanozApp> {
  // İlk açılışta koyu temanın gelmesi için true
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

      // ---- TÜRKÇE KLAVYE VE LOKALİZASYON DESTEĞİ ----
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'), 
        Locale('en', 'US'),
      ],
      locale: const Locale('tr', 'TR'), 

      // ---- BEYAZ TEMA ----
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        // Premium görünüm için Lato fontunu geri ekledik
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
        // Premium görünüm için Lato fontunu geri ekledik
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
      ),

      // Aktif tema modu
      themeMode: _karanlikTema ? ThemeMode.dark : ThemeMode.light,

      home: UstEkran(
        karanlikTema: _karanlikTema,
        temaDegistir: _temaDegistir,
      ),
    );
  }
}
