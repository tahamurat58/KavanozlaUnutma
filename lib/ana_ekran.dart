import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';
import 'widgets/kavanoz_widget.dart';
import 'widgets/kelime_soru_dialogu.dart';

/// AnaEkran - Uygulamanın ana sayfası
/// Kavanoz görseli, kelime çekme, kelime ekleme ve listeleme butonları içerir.
/// Tema değiştirme seçeneği sunar.
class AnaEkran extends StatelessWidget {
  // Kavanozdaki kelimeler
  final List<Kelime> kelimeListesi;

  // Ekran değiştirme callback'i
  final void Function(String ekranAdi) ekranDegistir;

  // Koyu tema aktif mi?
  final bool karanlikTema;

  // Tema değiştirme callback'i
  final VoidCallback temaDegistir;

  // İstatistik güncelleme callback'i
  final void Function(String id, bool dogruMu) onIstatistikGuncelle;

  const AnaEkran({
    super.key,
    required this.kelimeListesi,
    required this.ekranDegistir,
    required this.karanlikTema,
    required this.temaDegistir,
    required this.onIstatistikGuncelle,
  });

  /// Kavanozdan rastgele bir kelime çeker ve quiz dialogu gösterir.
  /// Rastgele İngilizce veya Türkçe gösterir, kullanıcıdan karşılığını ister.
  void _kelimeCek(BuildContext context) {
    // Boş kavanoz kontrolü
    if (kelimeListesi.isEmpty) {
      _uyariGoster(context, 'Kavanoz boş! Önce birkaç kelime ekleyin.');
      return;
    }

    // Rastgele bir kelime seç
    final rastgeleIndex = Random().nextInt(kelimeListesi.length);
    final secilenKelime = kelimeListesi[rastgeleIndex];

    // Quiz formatında dialog göster (KelimeSoruDialogu custom widget)
    showDialog(
      context: context,
      barrierDismissible: false, // Dışına tıklayarak kapatmayı engelle
      builder: (ctx) => KelimeSoruDialogu(
        kelime: secilenKelime,
        onSonuc: onIstatistikGuncelle,
      ),
    );
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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
        // Tema uyumlu gradient arka plan
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: karanlikTema
                ? [
                    const Color(0xFF1A1A2E),
                    const Color(0xFF16213E),
                    const Color(0xFF0F3460),
                  ]
                : [
                    const Color(0xFFFFF8E1),
                    const Color(0xFFFFE0B2),
                    const Color(0xFFFFCCBC),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar: Tema değiştirme butonu
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Tema değiştirme butonu
                    Container(
                      decoration: BoxDecoration(
                        color: karanlikTema
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        icon: Icon(
                          karanlikTema
                              ? Icons.light_mode_rounded
                              : Icons.dark_mode_rounded,
                          color: karanlikTema
                              ? Colors.amber.shade300
                              : Colors.brown.shade600,
                          size: 24,
                        ),
                        onPressed: temaDegistir,
                        tooltip: karanlikTema
                            ? 'Beyaz temaya geç'
                            : 'Koyu temaya geç',
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Uygulama başlığı
              Text(
                "🏺 Kavanoz'la Unutma",
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: karanlikTema
                      ? Colors.white
                      : Colors.brown.shade800,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: karanlikTema
                      ? Colors.amber.withValues(alpha: 0.08)
                      : Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'İngilizce kelimelerini kavanoza at,\nrastgele çek ve ezberle!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: karanlikTema
                        ? Colors.grey.shade400
                        : Colors.brown.shade500,
                    height: 1.5,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // Kavanoz widget'ı
              KavanozWidget(
                kelimeSayisi: kelimeListesi.length,
                karanlikTema: karanlikTema,
              ),

              const Spacer(flex: 1),

              // Butonlar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Kelime Çek butonu (ana buton - büyük ve dikkat çekici)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _kelimeCek(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shuffle_rounded, size: 26),
                            const SizedBox(width: 10),
                            Text(
                              'Kelime Çek!',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Alt butonlar (Kelime Ekle ve Tüm Kelimeler)
                    Row(
                      children: [
                        // Kelime Ekle butonu
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ekranDegistir('kelime-ekle'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: karanlikTema
                                  ? const Color(0xFF2D2D44)
                                  : Colors.white,
                              foregroundColor: karanlikTema
                                  ? Colors.amber.shade300
                                  : Colors.amber.shade700,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: karanlikTema
                                      ? Colors.amber.withValues(alpha: 0.2)
                                      : Colors.amber.shade300,
                                  width: 1.5,
                                ),
                              ),
                              elevation: karanlikTema ? 4 : 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add_rounded, size: 20),
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
                              backgroundColor: karanlikTema
                                  ? const Color(0xFF2D2D44)
                                  : Colors.white,
                              foregroundColor: karanlikTema
                                  ? Colors.amber.shade300
                                  : Colors.amber.shade700,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: karanlikTema
                                      ? Colors.amber.withValues(alpha: 0.2)
                                      : Colors.amber.shade300,
                                  width: 1.5,
                                ),
                              ),
                              elevation: karanlikTema ? 4 : 2,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.list_alt_rounded, size: 20),
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
