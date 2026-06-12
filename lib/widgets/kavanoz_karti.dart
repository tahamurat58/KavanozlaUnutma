import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/kavanoz.dart';

/// KavanozKarti - Seçim ekranında bir kavanozu temsil eden kart
class KavanozKarti extends StatelessWidget {
  final Kavanoz kavanoz;
  final bool karanlikTema;
  final VoidCallback onSec;
  final VoidCallback? onSil;

  const KavanozKarti({
    super.key,
    required this.kavanoz,
    required this.karanlikTema,
    required this.onSec,
    this.onSil,
  });

  @override
  Widget build(BuildContext context) {
    // İstatistik hesaplama (Tüm kelimelerin ortalaması)
    int toplamDogru = 0;
    int toplamYanlis = 0;
    for (var k in kavanoz.kelimeListesi) {
      toplamDogru += k.dogruSayisi;
      toplamYanlis += k.yanlisSayisi;
    }
    final toplamSoru = toplamDogru + toplamYanlis;
    final basari =
        toplamSoru > 0 ? ((toplamDogru / toplamSoru) * 100).round() : 0;

    return GestureDetector(
      onTap: onSec,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: karanlikTema
                ? [
                    const Color(0xFF1E293B).withValues(alpha: 0.7),
                    const Color(0xFF0F172A).withValues(alpha: 0.8),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.6),
                  ],
          ),
          borderRadius: BorderRadius.circular(24), // Daha kavisli hatlar
          border: Border.all(
            color: karanlikTema
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.white,
            width: karanlikTema ? 1.0 : 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: karanlikTema
                  ? Colors.black.withValues(alpha: 0.4)
                  : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // İkon Kutusu
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: karanlikTema
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    kavanoz.ikon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Bilgiler
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            kavanoz.isim,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: karanlikTema
                                  ? Colors.white
                                  : Colors.brown.shade800,
                            ),
                          ),
                        ),
                        // Hazır etiket
                        if (kavanoz.isHazir)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Hazır',
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: karanlikTema
                                    ? Colors.blue.shade300
                                    : Colors.blue.shade700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        // Kelime Sayısı
                        Icon(
                          Icons.menu_book_rounded,
                          size: 14,
                          color: karanlikTema
                              ? Colors.grey.shade400
                              : Colors.brown.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${kavanoz.kelimeListesi.length} kelime',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: karanlikTema
                                ? Colors.grey.shade400
                                : Colors.brown.shade500,
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Başarı Yüzdesi
                        Icon(
                          Icons.trending_up_rounded,
                          size: 14,
                          color: karanlikTema
                              ? Colors.grey.shade400
                              : Colors.brown.shade400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '%$basari başarı',
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: karanlikTema
                                ? Colors.grey.shade400
                                : Colors.brown.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Silme butonu (sadece özel kavanozlar)
              if (kavanoz.isOzel && onSil != null)
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red.shade300,
                  ),
                  onPressed: onSil,
                  tooltip: 'Kavanozu Sil',
                )
              else
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: karanlikTema
                      ? Colors.grey.shade600
                      : Colors.brown.shade300,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
