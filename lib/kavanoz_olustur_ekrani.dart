import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// KavanozOlusturEkrani - Yeni özel kavanoz oluşturma formu
class KavanozOlusturEkrani extends StatefulWidget {
  final bool karanlikTema;
  final void Function(String ekranAdi) ekranDegistir;
  final void Function(String isim, String ikon) onKavanozEkle;

  const KavanozOlusturEkrani({
    super.key,
    required this.karanlikTema,
    required this.ekranDegistir,
    required this.onKavanozEkle,
  });

  @override
  State<KavanozOlusturEkrani> createState() => _KavanozOlusturEkraniState();
}

class _KavanozOlusturEkraniState extends State<KavanozOlusturEkrani> {
  final _isimController = TextEditingController();
  String _seciliIkon = '🏺';

  final List<String> _ikonlar = [
    '🇬🇧',
    '🇩🇪',
    '🇪🇸',
    '🇫🇷',
    '🇮🇹',
    '🇷🇺',
    '🇨🇳',
    '🇯🇵',
    '🏺',
    '📚',
    '🚀',
    '⭐',
    '🔥',
    '🧠',
    '💼',
    '✈️',
    '🎮',
    '🍎',
  ];

  @override
  void dispose() {
    _isimController.dispose();
    super.dispose();
  }

  void _hataGoster(String mesaj) {
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

  void _olustur() {
    final isim = _isimController.text.trim();
    if (isim.isEmpty) {
      _hataGoster('Lütfen kavanoz için bir isim girin.');
      return;
    }

    widget.onKavanozEkle(isim, _seciliIkon);
    widget.ekranDegistir('kavanoz-secim');
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = widget.karanlikTema;

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Geri Butonu
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: karanlik
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: karanlik
                              ? Colors.grey.shade300
                              : Colors.brown.shade700,
                          size: 20,
                        ),
                        onPressed: () => widget.ekranDegistir('kavanoz-secim'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Başlık
                  Center(
                    child: Text(
                      'Yeni Kavanoz',
                      style: GoogleFonts.lato(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: karanlik ? Colors.white : Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // İsim Alanı
                  TextField(
                    controller: _isimController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Kavanoz İsmi',
                      hintText: 'Örn: IELTS Kelimelerim',
                      filled: true,
                      fillColor: karanlik
                          ? const Color(0xFF2D2D44)
                          : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      // DİKKAT: HİÇBİR FONT ZORLAMASI YOK
                      labelStyle: TextStyle(
                        color: karanlik
                            ? Colors.grey.shade400
                            : Colors.brown.shade500,
                      ),
                    ),
                    // DİKKAT: HİÇBİR FONT ZORLAMASI YOK
                    style: TextStyle(
                      color: karanlik ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // İkon Seçimi
                  Text(
                    'Kavanoz İkonu Seçin',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: karanlik
                          ? Colors.grey.shade300
                          : Colors.brown.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: _ikonlar.map((ikon) {
                      final secili = ikon == _seciliIkon;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _seciliIkon = ikon;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.all(secili ? 16 : 12),
                          decoration: BoxDecoration(
                            color: secili
                                ? Colors.amber.shade500
                                : karanlik
                                ? const Color(0xFF2D2D44)
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: secili
                                  ? Colors.amber.shade600
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: secili
                                ? [
                                    BoxShadow(
                                      color: Colors.amber.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 8,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            ikon,
                            style: const TextStyle(fontSize: 28),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 48),

                  // Oluştur Butonu
                  ElevatedButton(
                    onPressed: _olustur,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'Kavanozu Oluştur',
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
