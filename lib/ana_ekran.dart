import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';
import 'widgets/kavanoz_widget.dart';

/// AnaEkran - Uygulamanın ana sayfası
/// Kavanoz görseli, kelime çekme, kelime ekleme ve listeleme butonları içerir.
class AnaEkran extends StatelessWidget {
  // Kavanozdaki kelimeler
  final List<Kelime> kelimeListesi;

  // Ekran değiştirme callback'i
  final void Function(String ekranAdi) ekranDegistir;

  const AnaEkran({
    super.key,
    required this.kelimeListesi,
    required this.ekranDegistir,
  });

  /// Kavanozdan rastgele bir kelime çeker ve dialog ile gösterir
  void _kelimeCek(BuildContext context) {
    // Boş kavanoz kontrolü
    if (kelimeListesi.isEmpty) {
      _uyariGoster(context, 'Kavanoz boş! Önce birkaç kelime ekleyin.');
      return;
    }

    // Rastgele bir kelime seç
    final rastgeleIndex = Random().nextInt(kelimeListesi.length);
    final secilenKelime = kelimeListesi[rastgeleIndex];

    // Platform uyumlu dialog ile göster
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('🎲 Kavanozdan Çıkan Kelime'),
          content: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                secilenKelime.ingilizce,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                secilenKelime.turkce,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Tamam'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.amber.shade600),
              const SizedBox(width: 8),
              const Text('Kavanozdan Çıkan'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              // İngilizce kelime
              Text(
                secilenKelime.ingilizce,
                style: GoogleFonts.lato(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
              const SizedBox(height: 12),
              // Ayırıcı çizgi
              Container(
                width: 60,
                height: 2,
                color: Colors.amber.shade200,
              ),
              const SizedBox(height: 12),
              // Türkçe anlamı
              Text(
                secilenKelime.turkce,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.brown.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(
                'Tamam',
                style: TextStyle(color: Colors.amber.shade700),
              ),
            ),
          ],
        ),
      );
    }
  }

  /// Platform uyumlu uyarı dialogu gösterir
  void _uyariGoster(BuildContext context, String mesaj) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Uyarı'),
          content: Text(mesaj),
          actions: [
            CupertinoDialogAction(
              child: const Text('Tamam'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Uyarı'),
          content: Text(mesaj),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Gradient arka plan
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber.shade50,
              Colors.orange.shade100,
              Colors.deepOrange.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 1),

              // Uygulama başlığı
              Text(
                "🏺 Kavanoz'la Unutma",
                style: GoogleFonts.lato(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'İngilizce kelimelerini kavanoza at,\nrastgele çek ve ezberle!',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.brown.shade400,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 1),

              // Kavanoz widget'ı
              KavanozWidget(kelimeSayisi: kelimeListesi.length),

              const Spacer(flex: 1),

              // Butonlar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Kelime Çek butonu (ana buton - büyük)
                    ElevatedButton(
                      onPressed: () => _kelimeCek(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 6,
                        shadowColor: Colors.amber.shade200,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.shuffle, size: 26),
                          const SizedBox(width: 10),
                          Text(
                            'Kelime Çek!',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Alt butonlar (Kelime Ekle ve Tüm Kelimeler)
                    Row(
                      children: [
                        // Kelime Ekle butonu
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ekranDegistir('kelime-ekle'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.amber.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Colors.amber.shade300,
                                  width: 1.5,
                                ),
                              ),
                              elevation: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  'Ekle',
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Tüm Kelimeler butonu
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ekranDegistir('kelime-listesi'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.amber.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: Colors.amber.shade300,
                                  width: 1.5,
                                ),
                              ),
                              elevation: 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.list_alt, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  'Liste',
                                  style: GoogleFonts.lato(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
