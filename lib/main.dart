import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ust_ekran.dart';

/// Uygulamanın giriş noktası
void main() {
  runApp(const KavanozApp());
}

/// KavanozApp - Ana MaterialApp widget'ı
/// Tema ve yazı tipi ayarlarını yapılandırır.
class KavanozApp extends StatelessWidget {
  const KavanozApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kavanoz'la Unutma",
      debugShowCheckedModeBanner: false,
      // Uygulama teması - sıcak amber/turuncu tonları
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          brightness: Brightness.light,
        ),
        // Google Fonts ile varsayılan yazı tipi
        textTheme: GoogleFonts.latoTextTheme(),
        useMaterial3: true,
      ),
      // Üst ekran tüm state yönetimini üstlenir
      home: const UstEkran(),
    );
  }
}
