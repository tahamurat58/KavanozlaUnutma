import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/kelime.dart';

/// KelimeKarti - Bir kelimeyi gösteren özel kart widget'ı
/// İngilizce kelime ve Türkçe anlamını güzel bir kart tasarımıyla gösterir.
/// Opsiyonel silme butonu içerir.
class KelimeKarti extends StatelessWidget {
  // Gösterilecek kelime
  final Kelime kelime;

  // Silme callback'i (opsiyonel - null ise silme butonu gösterilmez)
  final void Function(String id)? onSil;

  const KelimeKarti({
    super.key,
    required this.kelime,
    this.onSil,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        // Kart arka planı: beyazdan hafif ambere geçiş
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.amber.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Sol taraf: Kelime ikonu
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.translate,
                color: Colors.amber.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Orta kısım: İngilizce ve Türkçe kelime
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // İngilizce kelime (büyük ve kalın)
                  Text(
                    kelime.ingilizce,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Türkçe anlamı (daha küçük, açık renk)
                  Text(
                    kelime.turkce,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.brown.shade500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Sağ taraf: Silme butonu (eğer onSil callback'i varsa)
            if (onSil != null)
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade300,
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
