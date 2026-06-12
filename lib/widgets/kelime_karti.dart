import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/kelime.dart';

/// KelimeKarti - Bir kelimeyi gösteren özel kart widget'ı
/// İngilizce kelime, Türkçe anlamı ve istatistikleri gösterir.
/// Opsiyonel silme butonu içerir. Tema uyumludur.
class KelimeKarti extends StatelessWidget {
  // Gösterilecek kelime
  final Kelime kelime;

  // Silme callback'i (opsiyonel - null ise silme butonu gösterilmez)
  final void Function(String id)? onSil;

  // Koyu tema aktif mi?
  final bool karanlikTema;

  const KelimeKarti({
    super.key,
    required this.kelime,
    required this.karanlikTema,
    this.onSil,
  });

  /// Başarı yüzdesine göre renk döndürür
  Color _basariRengi() {
    if (kelime.toplamSorulma == 0) {
      return karanlikTema ? Colors.grey.shade600 : Colors.grey.shade400;
    }
    if (kelime.basariYuzdesi >= 70) {
      return Colors.green.shade500;
    }
    if (kelime.basariYuzdesi >= 40) {
      return Colors.orange.shade500;
    }
    return Colors.red.shade400;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        // Tema uyumlu kart arka planı
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: karanlikTema
              ? [
                  const Color(0xFF1E293B).withValues(alpha: 0.6),
                  const Color(0xFF0F172A).withValues(alpha: 0.7),
                ]
              : [
                  Colors.white.withValues(alpha: 0.8),
                  Colors.white.withValues(alpha: 0.5),
                ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: karanlikTema
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.white,
          width: karanlikTema ? 1.0 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: karanlikTema
                ? Colors.black.withValues(alpha: 0.3)
                : const Color(0xFFE2E8F0).withValues(alpha: 0.6),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Sol taraf: Kelime ikonu ve başarı göstergesi
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: karanlikTema
                      ? [const Color(0xFF3D3D5C), const Color(0xFF2D2D44)]
                      : [Colors.amber.shade50, Colors.amber.shade100],
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: karanlikTema
                      ? Colors.amber.withValues(alpha: 0.15)
                      : Colors.amber.shade200,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.translate,
                color: karanlikTema
                    ? Colors.amber.shade300
                    : Colors.amber.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),

            // Orta kısım: İngilizce ve Türkçe kelime
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // İngilizce kelime (büyük ve kalın)
                  Text(
                    kelime.ingilizce,
                    style: GoogleFonts.outfit(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: karanlikTema
                          ? Colors.white
                          : Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  // Türkçe anlamı (daha küçük, açık renk)
                  Text(
                    kelime.turkce,
                    style: GoogleFonts.outfit(
                      fontSize: 13,
                      color: karanlikTema
                          ? Colors.grey.shade400
                          : Colors.brown.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // İstatistik satırı
                  Row(
                    children: [
                      // Doğru sayısı
                      Icon(
                        Icons.check_circle_outline,
                        size: 14,
                        color: Colors.green.shade500,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${kelime.dogruSayisi}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade500,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Yanlış sayısı
                      Icon(
                        Icons.cancel_outlined,
                        size: 14,
                        color: Colors.red.shade400,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${kelime.yanlisSayisi}',
                        style: GoogleFonts.outfit(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade400,
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Başarı yüzdesi
                      if (kelime.toplamSorulma > 0) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _basariRengi().withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '%${kelime.basariYuzdesi}',
                            style: GoogleFonts.outfit(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: _basariRengi(),
                            ),
                          ),
                        ),
                      ],

                      // 🔥 Seri göstergesi
                      if (kelime.seri > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('🔥', style: TextStyle(fontSize: 10)),
                              const SizedBox(width: 2),
                              Text(
                                '${kelime.seri}',
                                style: GoogleFonts.outfit(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Sağ taraf: Silme butonu (eğer onSil callback'i varsa)
            if (onSil != null)
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: karanlikTema
                      ? Colors.red.shade300
                      : Colors.red.shade300,
                ),
                onPressed: () => onSil!(kelime.id),
                tooltip: 'Kelimeyi sil',
              ),
          ],
        ),
      ),
    );
  }
}
