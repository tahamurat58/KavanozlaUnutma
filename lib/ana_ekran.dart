import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kavanoz.dart';
import 'models/kelime.dart';
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

  // Akıllı Mod (Pekiştirmeli Öğrenme) kontrolü
  final bool akilliMod;
  final VoidCallback onAkilliModDegistir;

  const AnaEkran({
    super.key,
    required this.kavanoz,
    required this.ekranDegistir,
    required this.karanlikTema,
    required this.temaDegistir,
    required this.onIstatistikGuncelle,
    required this.akilliMod,
    required this.onAkilliModDegistir,
  });

  // ──────────────────────────────────────────────────────────────
  //  PEKİŞTİRMELİ ÖĞRENME (REINFORCEMENT LEARNING) ALGORİTMASI
  //
  //  Epsilon-Greedy tabanlı Akıllı Kelime Seçimi:
  //
  //  • Ajan (Agent):       Bu kelime seçme algoritması
  //  • Ortam (Environment): Kullanıcının öğrenme durumu (istatistikler)
  //  • Durum (State):       Her kelimenin doğru/yanlış/toplam sayıları
  //  • Eylem (Action):      Hangi kelimeyi sıradaki soruda göstereyim?
  //  • Ödül (Reward):       Kullanıcının doğru/yanlış cevabı
  //
  //  Strateji:
  //  - ε (epsilon) = 0.2 → %20 ihtimalle rastgele keşif (Exploration)
  //  - %80 ihtimalle en yüksek öncelikli kelimeyi seç (Exploitation)
  //
  //  Öncelik Skoru (Priority Score) Formülü:
  //  priority = (1 - başarıOranı) * 0.6          ← Zayıf kelimelere ağırlık
  //           + (1 / (toplamSorulma + 1)) * 0.3  ← Az sorulan kelimelere keşif bonusu
  //           + rastgeleFaktör * 0.1              ← Monotonluğu kırma
  // ──────────────────────────────────────────────────────────────

  /// Epsilon-Greedy RL algoritmasıyla kelime seçer
  Kelime _akilliKelimeSec(List<Kelime> kelimeler) {
    final random = Random();
    const double epsilon = 0.2; // Keşif oranı (%20)

    // Keşif (Exploration): Epsilon olasılığıyla rastgele kelime seç
    if (random.nextDouble() < epsilon) {
      return kelimeler[random.nextInt(kelimeler.length)];
    }

    // Sömürü (Exploitation): En yüksek öncelikli kelimeyi seç
    double enYuksekSkor = -1;
    Kelime enOncelikliKelime = kelimeler.first;

    for (final kelime in kelimeler) {
      // Başarı oranı (0.0 - 1.0 arası)
      final basariOrani = kelime.toplamSorulma > 0
          ? kelime.dogruSayisi / kelime.toplamSorulma
          : 0.0;

      // RL Öncelik Skoru hesaplama
      final oncelikSkoru =
          (1.0 - basariOrani) * 0.6 +                          // Zayıf kelimeler öncelikli
          (1.0 / (kelime.toplamSorulma + 1)) * 0.3 +           // Az sorulanlar keşfedilsin
          random.nextDouble() * 0.1;                            // Stokastik çeşitlendirme

      if (oncelikSkoru > enYuksekSkor) {
        enYuksekSkor = oncelikSkoru;
        enOncelikliKelime = kelime;
      }
    }

    return enOncelikliKelime;
  }

  void _kelimeCek(BuildContext context) {
    if (kavanoz.kelimeListesi.isEmpty) {
      _uyariGoster(context, 'Kavanoz boş! Önce birkaç kelime ekleyin.');
      return;
    }

    // Akıllı Mod açıksa RL algoritması, kapalıysa rastgele seçim
    final Kelime secilenKelime;
    if (akilliMod) {
      secilenKelime = _akilliKelimeSec(kavanoz.kelimeListesi);
    } else {
      final rastgeleIndex = Random().nextInt(kavanoz.kelimeListesi.length);
      secilenKelime = kavanoz.kelimeListesi[rastgeleIndex];
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => KelimeSoruDialogu(
        kelime: secilenKelime,
        kavanozIkon: kavanoz.ikon,
        onSonuc: onIstatistikGuncelle,
      ),
    );
  }

  void _uyariGoster(BuildContext context, String mesaj) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
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
              // Üst bar: Geri dön, Akıllı Mod ve Tema değiştirme
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
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

                    const Spacer(),

                    // ── AKILLI MOD TOGGLE BUTONU ──
                    GestureDetector(
                      onTap: onAkilliModDegistir,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: akilliMod
                              ? LinearGradient(
                                  colors: [Colors.deepPurple.shade400, Colors.purple.shade300],
                                )
                              : null,
                          color: akilliMod
                              ? null
                              : karanlikTema
                                  ? Colors.white.withValues(alpha: 0.08)
                                  : Colors.black.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: akilliMod
                              ? [
                                  BoxShadow(
                                    color: Colors.deepPurple.withValues(alpha: 0.4),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              akilliMod ? Icons.psychology_rounded : Icons.psychology_outlined,
                              color: akilliMod
                                  ? Colors.white
                                  : karanlikTema
                                      ? Colors.grey.shade400
                                      : Colors.brown.shade500,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              akilliMod ? 'AI Açık' : 'AI Kapalı',
                              style: GoogleFonts.lato(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: akilliMod
                                    ? Colors.white
                                    : karanlikTema
                                        ? Colors.grey.shade400
                                        : Colors.brown.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

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

              // Akıllı Mod açıklama etiketi
              if (akilliMod)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.deepPurple.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 14,
                          color: Colors.deepPurple.shade300,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Zayıf kelimeler öncelikli sorulacak',
                          style: GoogleFonts.lato(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple.shade300,
                          ),
                        ),
                      ],
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
                            color: akilliMod
                                ? Colors.deepPurple.withValues(alpha: 0.35)
                                : Colors.amber.withValues(alpha: 0.35),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _kelimeCek(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: akilliMod
                              ? Colors.deepPurple.shade500
                              : Colors.amber.shade600,
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
                            Icon(
                              akilliMod ? Icons.psychology_rounded : Icons.shuffle_rounded,
                              size: 26,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              akilliMod ? 'Akıllı Kelime Çek!' : 'Kelime Çek!',
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
