import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// KavanozWidget - Ana ekranda gösterilecek kavanoz görseli
/// İçinde kavanozdaki kelime sayısını gösterir.
class KavanozWidget extends StatelessWidget {
  // Kavanozdaki kelime sayısı
  final int kelimeSayisi;

  const KavanozWidget({
    super.key,
    required this.kelimeSayisi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Kavanoz kapağı
        Container(
          width: 140,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF8D6E63),
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),

        // Kavanoz gövdesi
        Container(
          width: 160,
          height: 200,
          decoration: BoxDecoration(
            // Camı temsil eden yarı saydam gradient
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0x55BBDEFB), // Açık mavi (cam efekti)
                Color(0x33E3F2FD),
                Color(0x55BBDEFB),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            border: Border.all(
              color: const Color(0xFF90CAF9),
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.1),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kavanoz ikonu
              Icon(
                Icons.auto_stories,
                size: 48,
                color: Colors.amber.shade700,
              ),
              const SizedBox(height: 12),

              // Kelime sayısı
              Text(
                '$kelimeSayisi',
                style: GoogleFonts.lato(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade800,
                ),
              ),
              Text(
                'kelime',
                style: GoogleFonts.lato(
                  fontSize: 14,
                  color: Colors.brown.shade400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
