import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';
import 'widgets/kelime_karti.dart';

/// KelimeListesiEkrani - Kavanozdaki tüm kelimeleri listeler
/// Her kelimeyi KelimeKarti widget'ı ile gösterir.
/// İstatistiklere göre sıralama ve kelime silme işlevi içerir.
/// Tema uyumludur.
class KelimeListesiEkrani extends StatefulWidget {
  // Kavanozdaki tüm kelimeler
  final List<Kelime> kelimeListesi;

  // Silme callback'i - üst ekrana kelime id'sini iletir
  final void Function(String id) onKelimeSil;

  // Ekran değiştirme callback'i
  final void Function(String ekranAdi) ekranDegistir;

  // Koyu tema aktif mi?
  final bool karanlikTema;

  const KelimeListesiEkrani({
    super.key,
    required this.kelimeListesi,
    required this.onKelimeSil,
    required this.ekranDegistir,
    required this.karanlikTema,
  });

  @override
  State<KelimeListesiEkrani> createState() => _KelimeListesiEkraniState();
}

class _KelimeListesiEkraniState extends State<KelimeListesiEkrani> {
  // Aktif sıralama kriteri
  String _siralama = 'tarih'; // 'tarih', 'en-cok-yanlis', 'en-cok-dogru', 'basari'

  /// Kelime listesini aktif sıralama kriterine göre sıralar
  /// Orijinal listeyi değiştirmeden yeni bir sıralı liste döndürür.
  List<Kelime> _siraliListe() {
    // Orijinal listeyi kopyala
    final liste = List<Kelime>.from(widget.kelimeListesi);

    if (_siralama == 'en-cok-yanlis') {
      // En çok yanlış yapılandan en aza (zayıf kelimeler önce)
      liste.sort((a, b) => b.yanlisSayisi.compareTo(a.yanlisSayisi));
    } else if (_siralama == 'en-cok-dogru') {
      // En çok doğru yapılandan en aza
      liste.sort((a, b) => b.dogruSayisi.compareTo(a.dogruSayisi));
    } else if (_siralama == 'basari') {
      // Başarı yüzdesine göre (en düşük başarı önce)
      liste.sort((a, b) => a.basariYuzdesi.compareTo(b.basariYuzdesi));
    }
    // 'tarih' → ekleme sırası (varsayılan, sıralama yapmaya gerek yok)

    return liste;
  }

  /// Genel istatistik kartı widget'ı
  Widget _istatistikKarti() {
    final karanlik = widget.karanlikTema;

    // Toplam istatistikleri hesapla
    int toplamDogru = 0;
    int toplamYanlis = 0;
    for (final kelime in widget.kelimeListesi) {
      toplamDogru += kelime.dogruSayisi;
      toplamYanlis += kelime.yanlisSayisi;
    }
    final toplamSoru = toplamDogru + toplamYanlis;
    final genelBasari =
        toplamSoru > 0 ? ((toplamDogru / toplamSoru) * 100).round() : 0;

    return Container(
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
          color: karanlik
              ? Colors.amber.withValues(alpha: 0.12)
              : Colors.amber.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: karanlik
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.amber.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Toplam kelime
          _istatistikItem(
            icon: Icons.menu_book_rounded,
            deger: '${widget.kelimeListesi.length}',
            etiket: 'Kelime',
            renk: karanlik ? Colors.amber.shade300 : Colors.amber.shade700,
            karanlik: karanlik,
          ),
          // Dikey ayırıcı
          Container(
            width: 1,
            height: 40,
            color: karanlik
                ? Colors.grey.shade700
                : Colors.amber.shade200,
          ),
          // Toplam doğru
          _istatistikItem(
            icon: Icons.check_circle_outline_rounded,
            deger: '$toplamDogru',
            etiket: 'Doğru',
            renk: Colors.green.shade500,
            karanlik: karanlik,
          ),
          // Dikey ayırıcı
          Container(
            width: 1,
            height: 40,
            color: karanlik
                ? Colors.grey.shade700
                : Colors.amber.shade200,
          ),
          // Toplam yanlış
          _istatistikItem(
            icon: Icons.cancel_outlined,
            deger: '$toplamYanlis',
            etiket: 'Yanlış',
            renk: Colors.red.shade400,
            karanlik: karanlik,
          ),
          // Dikey ayırıcı
          Container(
            width: 1,
            height: 40,
            color: karanlik
                ? Colors.grey.shade700
                : Colors.amber.shade200,
          ),
          // Genel başarı
          _istatistikItem(
            icon: Icons.trending_up_rounded,
            deger: '%$genelBasari',
            etiket: 'Başarı',
            renk: genelBasari >= 70
                ? Colors.green.shade500
                : genelBasari >= 40
                    ? Colors.orange.shade500
                    : Colors.red.shade400,
            karanlik: karanlik,
          ),
        ],
      ),
    );
  }

  /// Tek bir istatistik öğesi (ikon, değer, etiket)
  Widget _istatistikItem({
    required IconData icon,
    required String deger,
    required String etiket,
    required Color renk,
    required bool karanlik,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: renk, size: 22),
        const SizedBox(height: 4),
        Text(
          deger,
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: renk,
          ),
        ),
        Text(
          etiket,
          style: GoogleFonts.lato(
            fontSize: 11,
            color: karanlik ? Colors.grey.shade500 : Colors.brown.shade400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = widget.karanlikTema;
    final siraliKelimeler = _siraliListe();

    return Scaffold(
      // Gradient arka planlı gövde
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: karanlik
                ? [
                    const Color(0xFF1A1A2E),
                    const Color(0xFF16213E),
                  ]
                : [
                    const Color(0xFFFFF8E1),
                    const Color(0xFFFFE0B2),
                  ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Üst bar: Geri butonu ve başlık
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 10.0,
                ),
                child: Row(
                  children: [
                    // Geri butonu
                    Container(
                      decoration: BoxDecoration(
                        color: karanlik
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: karanlik
                              ? Colors.grey.shade300
                              : Colors.brown.shade700,
                          size: 20,
                        ),
                        onPressed: () =>
                            widget.ekranDegistir('ana-ekran'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Başlık
                    Text(
                      '📋 Kelimelerim',
                      style: GoogleFonts.lato(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: karanlik
                            ? Colors.white
                            : Colors.brown.shade800,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),

              // Genel istatistik kartı
              _istatistikKarti(),

              // Sıralama butonları
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _siralamaChip('tarih', 'Ekleme Sırası', Icons.schedule),
                      const SizedBox(width: 6),
                      _siralamaChip(
                          'en-cok-yanlis', 'En Çok Yanlış', Icons.trending_down_rounded),
                      const SizedBox(width: 6),
                      _siralamaChip(
                          'en-cok-dogru', 'En Çok Doğru', Icons.trending_up_rounded),
                      const SizedBox(width: 6),
                      _siralamaChip('basari', 'Başarı %', Icons.bar_chart_rounded),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Kelime listesi veya boş durum mesajı
              Expanded(
                child: widget.kelimeListesi.isEmpty
                    // Boş kavanoz durumu
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: karanlik
                                    ? Colors.white.withValues(alpha: 0.05)
                                    : Colors.amber.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.inbox_rounded,
                                size: 40,
                                color: karanlik
                                    ? Colors.grey.shade600
                                    : Colors.brown.shade200,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Kavanoz boş!',
                              style: GoogleFonts.lato(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: karanlik
                                    ? Colors.grey.shade400
                                    : Colors.brown.shade400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Henüz hiç kelime eklenmemiş.',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: karanlik
                                    ? Colors.grey.shade600
                                    : Colors.brown.shade300,
                              ),
                            ),
                          ],
                        ),
                      )
                    // Kelime kartları listesi (sıralı)
                    : ListView(
                        padding: const EdgeInsets.only(bottom: 16),
                        children: [
                          ...siraliKelimeler.map(
                            (kelime) => KelimeKarti(
                              kelime: kelime,
                              onSil: widget.onKelimeSil,
                              karanlikTema: karanlik,
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

  /// Sıralama seçim chip'i oluşturur
  Widget _siralamaChip(String deger, String etiket, IconData ikon) {
    final karanlik = widget.karanlikTema;
    final secili = _siralama == deger;

    return GestureDetector(
      onTap: () {
        setState(() {
          _siralama = deger;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: secili
              ? Colors.amber.shade600
              : karanlik
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: secili
                ? Colors.amber.shade600
                : karanlik
                    ? Colors.grey.shade700
                    : Colors.amber.shade200,
            width: 1,
          ),
          boxShadow: secili
              ? [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              ikon,
              size: 15,
              color: secili
                  ? Colors.white
                  : karanlik
                      ? Colors.grey.shade400
                      : Colors.brown.shade500,
            ),
            const SizedBox(width: 5),
            Text(
              etiket,
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: secili ? FontWeight.bold : FontWeight.w500,
                color: secili
                    ? Colors.white
                    : karanlik
                        ? Colors.grey.shade400
                        : Colors.brown.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
