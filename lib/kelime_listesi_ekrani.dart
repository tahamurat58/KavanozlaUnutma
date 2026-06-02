import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kavanoz.dart';
import 'models/kelime.dart';
import 'widgets/kelime_karti.dart';

/// KelimeListesiEkrani - Seçili kavanozdaki kelimeleri listeler
class KelimeListesiEkrani extends StatefulWidget {
  final Kavanoz kavanoz;
  final void Function(String id) onKelimeSil;
  final void Function(String ekranAdi) ekranDegistir;
  final bool karanlikTema;

  const KelimeListesiEkrani({
    super.key,
    required this.kavanoz,
    required this.onKelimeSil,
    required this.ekranDegistir,
    required this.karanlikTema,
  });

  @override
  State<KelimeListesiEkrani> createState() => _KelimeListesiEkraniState();
}

class _KelimeListesiEkraniState extends State<KelimeListesiEkrani> {
  String _siralama = 'tarih'; 
  String _aramaMetni = '';

  List<Kelime> _siraliListe() {
    var liste = widget.kavanoz.kelimeListesi.where((k) {
      final metin = _aramaMetni.toLowerCase();
      return metin.isEmpty ||
             k.ingilizce.toLowerCase().contains(metin) ||
             k.turkce.toLowerCase().contains(metin);
    }).toList();

    if (_siralama == 'en-cok-yanlis') {
      // Zayıflar: Hiç sorulmamışlar en alta, hata yapanlar en üste
      liste.sort((a, b) {
        // Hiç sorulmamışları en alta at
        if (a.toplamSorulma == 0 && b.toplamSorulma > 0) return 1;
        if (b.toplamSorulma == 0 && a.toplamSorulma > 0) return -1;
        if (a.toplamSorulma == 0 && b.toplamSorulma == 0) return 0;
        // Sorulanlar arasında başarı yüzdesine göre artan sıra
        return a.basariYuzdesi.compareTo(b.basariYuzdesi);
      });
    } else if (_siralama == 'en-cok-dogru') {
      // Güçlüler: Başarı yüzdesine göre azalan sıra (en güçlü en üstte)
      liste.sort((a, b) => b.basariYuzdesi.compareTo(a.basariYuzdesi));
    } else if (_siralama == 'seri') {
      // 🔥 Seri: En yüksek seri en üstte
      liste.sort((a, b) => b.seri.compareTo(a.seri));
    }
    return liste;
  }

  Widget _istatistikKarti() {
    final karanlik = widget.karanlikTema;
    int toplamDogru = 0;
    int toplamYanlis = 0;
    for (final kelime in widget.kavanoz.kelimeListesi) {
      toplamDogru += kelime.dogruSayisi;
      toplamYanlis += kelime.yanlisSayisi;
    }
    final toplamSoru = toplamDogru + toplamYanlis;
    final genelBasari = toplamSoru > 0 ? ((toplamDogru / toplamSoru) * 100).round() : 0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + (0.1 * value),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: karanlik
                ? [const Color(0xFF2D2D44), const Color(0xFF1A1A2E)]
                : [Colors.amber.shade50, Colors.orange.shade50],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: karanlik ? Colors.amber.withValues(alpha: 0.12) : Colors.amber.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: karanlik ? Colors.black.withValues(alpha: 0.3) : Colors.amber.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _istatistikItem(icon: Icons.menu_book_rounded, deger: '${widget.kavanoz.kelimeListesi.length}', etiket: 'Kelime', renk: karanlik ? Colors.amber.shade300 : Colors.amber.shade700, karanlik: karanlik),
            Container(width: 1, height: 40, color: karanlik ? Colors.grey.shade700 : Colors.amber.shade200),
            _istatistikItem(icon: Icons.check_circle_outline_rounded, deger: '$toplamDogru', etiket: 'Doğru', renk: Colors.green.shade500, karanlik: karanlik),
            Container(width: 1, height: 40, color: karanlik ? Colors.grey.shade700 : Colors.amber.shade200),
            _istatistikItem(icon: Icons.cancel_outlined, deger: '$toplamYanlis', etiket: 'Yanlış', renk: Colors.red.shade400, karanlik: karanlik),
            Container(width: 1, height: 40, color: karanlik ? Colors.grey.shade700 : Colors.amber.shade200),
            _istatistikItem(icon: Icons.trending_up_rounded, deger: '%$genelBasari', etiket: 'Başarı', renk: genelBasari >= 70 ? Colors.green.shade500 : genelBasari >= 40 ? Colors.orange.shade500 : Colors.red.shade400, karanlik: karanlik),
          ],
        ),
      ),
    );
  }

  Widget _istatistikItem({required IconData icon, required String deger, required String etiket, required Color renk, required bool karanlik}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: renk, size: 22),
        const SizedBox(height: 4),
        Text(deger, style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w900, color: renk)),
        Text(etiket, style: GoogleFonts.lato(fontSize: 11, color: karanlik ? Colors.grey.shade500 : Colors.brown.shade400)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = widget.karanlikTema;
    final siraliKelimeler = _siraliListe();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: karanlik
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFFFFF8E1), const Color(0xFFFFE0B2)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: karanlik ? Colors.white.withValues(alpha: 0.08) : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: karanlik ? Colors.grey.shade300 : Colors.brown.shade700, size: 20),
                        onPressed: () => widget.ekranDegistir('ana-ekran'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '📋 Kelimelerim',
                      style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.w900, color: karanlik ? Colors.white : Colors.brown.shade800),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              _istatistikKarti(),

              // Arama Çubuğu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  onChanged: (deger) {
                    setState(() {
                      _aramaMetni = deger;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Kelime veya anlam ara...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: widget.karanlikTema
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.black.withValues(alpha: 0.03),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _siralamaChip('tarih', 'Sıra', Icons.schedule),
                      const SizedBox(width: 6),
                      _siralamaChip('en-cok-yanlis', 'Zayıflar', Icons.trending_down_rounded),
                      const SizedBox(width: 6),
                      _siralamaChip('en-cok-dogru', 'Güçlüler', Icons.trending_up_rounded),
                      const SizedBox(width: 6),
                      _siralamaChip('seri', '🔥 Seri', Icons.local_fire_department_rounded),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),

              Expanded(
                child: widget.kavanoz.kelimeListesi.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_rounded, size: 60, color: karanlik ? Colors.grey.shade600 : Colors.brown.shade200),
                            const SizedBox(height: 16),
                            Text('Kavanoz boş!', style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600, color: karanlik ? Colors.grey.shade400 : Colors.brown.shade400)),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: siraliKelimeler.length,
                        itemBuilder: (context, index) {
                          final kelime = siraliKelimeler[index];
                          // Basit bir staggered animasyon (Listeye giriş için)
                          return TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.0, end: 1.0),
                            duration: Duration(milliseconds: 300 + (index * 50).clamp(0, 500)),
                            curve: Curves.easeOut,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, 20 * (1 - value)),
                                child: Opacity(opacity: value, child: child),
                              );
                            },
                            child: KelimeKarti(
                              kelime: kelime,
                              onSil: widget.kavanoz.isOzel ? widget.onKelimeSil : null,
                              karanlikTema: karanlik,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _siralamaChip(String deger, String etiket, IconData ikon) {
    final karanlik = widget.karanlikTema;
    final secili = _siralama == deger;
    return GestureDetector(
      onTap: () {
        setState(() {
          _siralama = deger;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: secili ? Colors.amber.shade600 : karanlik ? Colors.white.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: secili ? Colors.amber.shade600 : karanlik ? Colors.grey.shade700 : Colors.amber.shade200,
            width: 1,
          ),
          boxShadow: secili ? [BoxShadow(color: Colors.amber.withValues(alpha: 0.3), blurRadius: 8)] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, size: 15, color: secili ? Colors.white : karanlik ? Colors.grey.shade400 : Colors.brown.shade500),
            const SizedBox(width: 5),
            Text(etiket, style: GoogleFonts.lato(fontSize: 12, fontWeight: secili ? FontWeight.bold : FontWeight.w500, color: secili ? Colors.white : karanlik ? Colors.grey.shade400 : Colors.brown.shade600)),
          ],
        ),
      ),
    );
  }
}
