import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';
import 'widgets/kelime_karti.dart';

/// KelimeListesiEkrani - Kavanozdaki tüm kelimeleri listeler
/// Her kelimeyi KelimeKarti widget'ı ile gösterir.
/// Kelime silme işlevi içerir.
class KelimeListesiEkrani extends StatelessWidget {
  // Kavanozdaki tüm kelimeler
  final List<Kelime> kelimeListesi;

  // Silme callback'i - üst ekrana kelime id'sini iletir
  final void Function(String id) onKelimeSil;

  // Ekran değiştirme callback'i
  final void Function(String ekranAdi) ekranDegistir;

  const KelimeListesiEkrani({
    super.key,
    required this.kelimeListesi,
    required this.onKelimeSil,
    required this.ekranDegistir,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient arka planlı gövde
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber.shade50,
              Colors.orange.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar: Geri butonu ve başlık
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.brown.shade700,
                      ),
                      onPressed: () => ekranDegistir('ana-ekran'),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '📋 Tüm Kelimeler',
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                    const Spacer(),
                    // Kelime sayısı etiketi
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${kelimeListesi.length} kelime',
                        style: GoogleFonts.lato(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                ),
              ),

              // Kelime listesi veya boş durum mesajı
              Expanded(
                child: kelimeListesi.isEmpty
                    // Boş kavanoz durumu
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 72,
                              color: Colors.brown.shade200,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Kavanoz boş!',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown.shade400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Henüz hiç kelime eklenmemiş.',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.brown.shade300,
                              ),
                            ),
                          ],
                        ),
                      )
                    // Kelime kartları listesi
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 16),
                        children: [
                          ...kelimeListesi.map(
                            (kelime) => KelimeKarti(
                              kelime: kelime,
                              onSil: onKelimeSil,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
