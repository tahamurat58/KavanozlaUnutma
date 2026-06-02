import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kavanoz.dart';
import 'widgets/kavanoz_widget.dart';
import 'widgets/kelime_soru_dialogu.dart';

/// AnaEkran - Seçilen kavanozun içine girildiğinde gösterilen ekran
class AnaEkran extends StatelessWidget {
  // Aktif kavanoz
  final Kavanoz kavanoz;
  final void Function(String ekranAdi) ekranDegistir;
  final bool karanlikTema;
  final VoidCallback temaDegistir;
  final void Function(String id, bool dogruMu) onIstatistikGuncelle;

  const AnaEkran({
    super.key,
    required this.kavanoz,
    required this.ekranDegistir,
    required this.karanlikTema,
    required this.temaDegistir,
    required this.onIstatistikGuncelle,
  });

  void _kelimeCek(BuildContext context) {
    if (kavanoz.kelimeListesi.isEmpty) {
      _uyariGoster(context, 'Kavanoz boş! Önce birkaç kelime ekleyin.');
      return;
    }

    final rastgeleIndex = Random().nextInt(kavanoz.kelimeListesi.length);
    final secilenKelime = kavanoz.kelimeListesi[rastgeleIndex];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => KelimeSoruDialogu(
        kelime: secilenKelime,
        onSonuc: onIstatistikGuncelle,
      ),
    );
  }

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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: karanlikTema
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                : [const Color(0xFFFFF8E1), const Color(0xFFFFE0B2), const Color(0xFFFFCCBC)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar: Geri dön ve Tema değiştirme
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Geri butonu (Kavanoz seçime döner)
                    Container(
                      decoration: BoxDecoration(
                        color: karanlikTema
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: karanlikTema ? Colors.grey.shade300 : Colors.brown.shade700,
                          size: 20,
                        ),
                        onPressed: () => ekranDegistir('kavanoz-secim'),
                      ),
                    ),

                    // Tema butonu
                    Container(
                      decoration: BoxDecoration(
                        color: karanlikTema
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        icon: Icon(
                          karanlikTema ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: karanlikTema ? Colors.amber.shade300 : Colors.brown.shade600,
                          size: 24,
                        ),
                        onPressed: temaDegistir,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Kavanoz Başlığı (Dinamik)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kavanoz.ikon,
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    kavanoz.isim,
                    style: GoogleFonts.lato(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: karanlikTema ? Colors.white : Colors.brown.shade800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: karanlikTema
                      ? Colors.amber.withValues(alpha: 0.08)
                      : Colors.amber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  kavanoz.isHazir 
                    ? 'Hazır ${kavanoz.seviye} kelimelerini çek ve ezberle!'
                    : 'Kendi eklediğin kelimeleri çek ve ezberle!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: karanlikTema ? Colors.grey.shade400 : Colors.brown.shade500,
                  ),
                ),
              ),

              const Spacer(flex: 1),

              // Kavanoz widget'ı
              KavanozWidget(
                kelimeSayisi: kavanoz.kelimeListesi.length,
                karanlikTema: karanlikTema,
              ),

              const Spacer(flex: 1),

              // Butonlar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Kelime Çek
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
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Alt butonlar
                    Row(
                      children: [
                        // Kelime Ekle Butonu (Sadece Özel Kavanozlar İçin)
                        if (kavanoz.isOzel) ...[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => ekranDegistir('kelime-ekle'),
                              style: _altButonStili(),
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
                        ],

                        // Liste Butonu
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => ekranDegistir('kelime-listesi'),
                            style: _altButonStili(),
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

  ButtonStyle _altButonStili() {
    return ElevatedButton.styleFrom(
      backgroundColor: karanlikTema ? const Color(0xFF2D2D44) : Colors.white,
      foregroundColor: karanlikTema ? Colors.amber.shade300 : Colors.amber.shade700,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: karanlikTema ? Colors.amber.withValues(alpha: 0.2) : Colors.amber.shade300,
          width: 1.5,
        ),
      ),
      elevation: karanlikTema ? 4 : 2,
    );
  }
}
