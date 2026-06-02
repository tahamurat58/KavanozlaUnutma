import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kavanoz.dart';
import 'widgets/kavanoz_karti.dart';

/// KavanozSecimEkrani - Uygulamanın yeni ana sayfası
class KavanozSecimEkrani extends StatelessWidget {
  final List<Kavanoz> kavanozListesi;
  final bool karanlikTema;
  final VoidCallback temaDegistir;
  final void Function(String id) onKavanozSec;
  final void Function(String id) onKavanozSil;
  final void Function(String ekranAdi) ekranDegistir;

  const KavanozSecimEkrani({
    super.key,
    required this.kavanozListesi,
    required this.karanlikTema,
    required this.temaDegistir,
    required this.onKavanozSec,
    required this.onKavanozSil,
    required this.ekranDegistir,
  });

  /// Kavanoz silmeden önce onay dialogu
  void _silmeOnayi(BuildContext context, String id, String isim) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Kavanozu Sil'),
          content: Text('"$isim" kavanozunu ve içindeki tüm kelimeleri silmek istediğinize emin misiniz?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.of(ctx).pop();
                onKavanozSil(id);
              },
              child: const Text('Sil'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Kavanozu Sil'),
          content: Text('"$isim" kavanozunu ve içindeki tüm kelimeleri silmek istediğinize emin misiniz?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                onKavanozSil(id);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sil'),
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
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFFFFF8E1), const Color(0xFFFFE0B2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst bar: Tema butonu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: karanlikTema
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        icon: Icon(
                          karanlikTema ? Icons.light_mode : Icons.dark_mode,
                          color: karanlikTema ? Colors.amber.shade300 : Colors.brown.shade600,
                        ),
                        onPressed: temaDegistir,
                      ),
                    ),
                  ],
                ),
              ),

              // Başlık
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kavanozlarım",
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: karanlikTema ? Colors.white : Colors.brown.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Çalışmak istediğin kavanozu seç veya yeni bir tane oluştur.",
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: karanlikTema ? Colors.grey.shade400 : Colors.brown.shade500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kavanoz Listesi
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: kavanozListesi.length,
                  itemBuilder: (context, index) {
                    final kavanoz = kavanozListesi[index];
                    return KavanozKarti(
                      kavanoz: kavanoz,
                      karanlikTema: karanlikTema,
                      onSec: () => onKavanozSec(kavanoz.id),
                      onSil: () => _silmeOnayi(context, kavanoz.id, kavanoz.isim),
                    );
                  },
                ),
              ),

              // Yeni Kavanoz Butonu
              Padding(
                padding: const EdgeInsets.all(24),
                child: ElevatedButton(
                  onPressed: () => ekranDegistir('kavanoz-olustur'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outline, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Yeni Kavanoz Oluştur',
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
