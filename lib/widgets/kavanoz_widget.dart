import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// KavanozWidget - Ana ekranda gösterilecek kavanoz görseli
/// İçinde kavanozdaki kelime sayısını gösterir.
/// Tema uyumlu renklere sahiptir.
class KavanozWidget extends StatelessWidget {
  // Kavanozdaki kelime sayısı
  final int kelimeSayisi;

  // Koyu tema aktif mi?
  final bool karanlikTema;

  const KavanozWidget({
    super.key,
    required this.kelimeSayisi,
    required this.karanlikTema,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Kavanoz kapağı üst çıkıntı
        Container(
          width: 80,
          height: 12,
          decoration: BoxDecoration(
            color: karanlikTema
                ? const Color(0xFF5D4037)
                : const Color(0xFF6D4C41),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),

        // Kavanoz kapağı ana gövde
        Container(
          width: 150,
          height: 22,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: karanlikTema
                  ? [const Color(0xFF5D4037), const Color(0xFF4E342E)]
                  : [const Color(0xFF8D6E63), const Color(0xFF6D4C41)],
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),

        // Kavanoz boyun kısmı (dar bölge)
        Container(
          width: 130,
          height: 15,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: karanlikTema
                  ? [
                      const Color(0x44546E7A),
                      const Color(0x6690A4AE),
                      const Color(0x44546E7A),
                    ]
                  : [
                      const Color(0x44BBDEFB),
                      const Color(0x77E3F2FD),
                      const Color(0x44BBDEFB),
                    ],
            ),
            border: Border.symmetric(
              vertical: BorderSide(
                color: karanlikTema
                    ? const Color(0xFF546E7A)
                    : const Color(0xFF90CAF9),
                width: 2,
              ),
            ),
          ),
        ),

        // Kavanoz gövdesi
        Container(
          width: 170,
          height: 210,
          decoration: BoxDecoration(
            // Camı temsil eden yarı saydam gradient
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: karanlikTema
                  ? [
                      const Color(0x33546E7A),
                      const Color(0x2278909C),
                      const Color(0x33546E7A),
                    ]
                  : [
                      const Color(0x55BBDEFB),
                      const Color(0x33E3F2FD),
                      const Color(0x55BBDEFB),
                    ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            border: Border.all(
              color: karanlikTema
                  ? const Color(0xFF546E7A)
                  : const Color(0xFF90CAF9),
              width: 2.5,
            ),
            boxShadow: [
              // Dış glow efekti
              BoxShadow(
                color: karanlikTema
                    ? Colors.amber.withValues(alpha: 0.08)
                    : Colors.blue.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 4,
              ),
              // İç gölge efekti
              BoxShadow(
                color: Colors.white.withValues(alpha: karanlikTema ? 0.03 : 0.15),
                blurRadius: 12,
                offset: const Offset(-3, -3),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cam yansıma efekti (sol üst köşe)
              Positioned(
                left: 15,
                top: 20,
                child: Container(
                  width: 8,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: karanlikTema ? 0.06 : 0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // İçerik: ikon ve sayı
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kavanoz ikonu
                  Icon(
                    Icons.auto_stories,
                    size: 44,
                    color: karanlikTema
                        ? Colors.amber.shade300
                        : Colors.amber.shade700,
                  ),
                  const SizedBox(height: 10),

                  // Kelime sayısı
                  Text(
                    '$kelimeSayisi',
                    style: GoogleFonts.lato(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: karanlikTema
                          ? Colors.amber.shade200
                          : Colors.amber.shade800,
                    ),
                  ),
                  Text(
                    'kelime',
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: karanlikTema
                          ? Colors.grey.shade400
                          : Colors.brown.shade400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
