import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/kelime.dart';

/// KelimeSoruDialogu - Kavanozdan çekilen kelimeyi quiz formatında gösterir.
class KelimeSoruDialogu extends StatefulWidget {
  final Kelime kelime;
  final String kavanozIkon;
  final void Function(String id, bool dogruMu) onSonuc;

  const KelimeSoruDialogu({
    super.key,
    required this.kelime,
    required this.kavanozIkon,
    required this.onSonuc,
  });

  @override
  State<KelimeSoruDialogu> createState() => _KelimeSoruDialoguState();
}

class _KelimeSoruDialoguState extends State<KelimeSoruDialogu> {
  final _cevapController = TextEditingController();
  late final bool _ingilizceSor;
  bool _cevapVerildi = false;
  bool _dogruMu = false;

  @override
  void initState() {
    super.initState();
    _ingilizceSor = Random().nextBool();
  }

  @override
  void dispose() {
    _cevapController.dispose();
    super.dispose();
  }

  String get _soruKelime => _ingilizceSor ? widget.kelime.ingilizce : widget.kelime.turkce;
  String get _dogruCevap => _ingilizceSor ? widget.kelime.turkce : widget.kelime.ingilizce;
  String get _soruDili => _ingilizceSor ? '🌐 Yabancı Kelime' : '🇹🇷 Türkçe';
  String get _cevapDili => _ingilizceSor ? 'Türkçe' : 'Yabancı Kelime';

  /// Türkçe karakterlere (I, İ, Ğ, Ü, Ş, Ö, Ç) tam duyarlı küçük harf çevirici
  String _turkceKucukHarf(String metin) {
    return metin
        .trim()
        .replaceAll('I', 'ı')
        .replaceAll('İ', 'i')
        .replaceAll('Ğ', 'ğ')
        .replaceAll('Ü', 'ü')
        .replaceAll('Ş', 'ş')
        .replaceAll('Ö', 'ö')
        .replaceAll('Ç', 'ç')
        .toLowerCase();
  }

  void _cevapKontrol() {
    final kullaniciCevabi = _turkceKucukHarf(_cevapController.text);
    final beklenenCevap = _turkceKucukHarf(_dogruCevap);

    if (kullaniciCevabi.isEmpty) return;

    final sonuc = kullaniciCevabi == beklenenCevap;
    widget.onSonuc(widget.kelime.id, sonuc);

    setState(() {
      _cevapVerildi = true;
      _dogruMu = sonuc;
    });
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: karanlik ? const Color(0xFF2D2D44) : Colors.white,
      elevation: 16,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: karanlik
                ? Colors.amber.withValues(alpha: 0.15)
                : Colors.amber.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Başlık ikonu
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.amber.shade400, Colors.orange.shade400]),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.amber.withValues(alpha: 0.3), blurRadius: 12, spreadRadius: 2),
                  ],
                ),
                child: Center(
                  child: Text(
                    widget.kavanozIkon,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Kavanozdan Çıkan',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: karanlik ? Colors.grey.shade300 : Colors.brown.shade600,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: karanlik ? Colors.amber.withValues(alpha: 0.1) : Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: karanlik ? Colors.amber.withValues(alpha: 0.2) : Colors.amber.shade200,
                  ),
                ),
                child: Text(
                  _soruDili,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: karanlik ? Colors.amber.shade300 : Colors.brown.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                _soruKelime,
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: karanlik ? Colors.amber.shade200 : Colors.amber.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Ayırıcı çizgi
              Container(
                width: 80,
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.shade200.withValues(alpha: 0),
                      karanlik ? Colors.amber.shade400 : Colors.amber.shade300,
                      Colors.amber.shade200.withValues(alpha: 0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(height: 20),

              if (!_cevapVerildi) ...[
                TextField(
                  controller: _cevapController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '$_cevapDili karşılığını yazın...',
                    // DİKKAT: HİÇBİR FONT ZORLAMASI YOK
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: karanlik ? Colors.grey.shade500 : Colors.brown.shade300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: karanlik ? Colors.grey.shade700 : Colors.amber.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: karanlik ? Colors.grey.shade700 : Colors.amber.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Colors.amber.shade600, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    fillColor: karanlik ? const Color(0xFF1A1A2E) : Colors.amber.shade50.withValues(alpha: 0.5),
                  ),
                  // DİKKAT: HİÇBİR FONT ZORLAMASI YOK
                  style: TextStyle(
                    fontSize: 16,
                    color: karanlik ? Colors.white : Colors.brown.shade800,
                  ),
                  onSubmitted: (_) => _cevapKontrol(),
                ),
                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _cevapKontrol,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      shadowColor: Colors.amber.shade200,
                    ),
                    child: Text('Kontrol Et', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],

              if (_cevapVerildi) ...[
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _dogruMu ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                    ),
                    child: Icon(
                      _dogruMu ? Icons.check_circle : Icons.cancel,
                      size: 52,
                      color: _dogruMu ? Colors.green.shade500 : Colors.red.shade400,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  _dogruMu ? 'Doğru! 🎉' : 'Yanlış! 😔',
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _dogruMu ? Colors.green.shade600 : Colors.red.shade500,
                  ),
                ),
                const SizedBox(height: 14),

                if (!_dogruMu) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: karanlik ? Colors.green.withValues(alpha: 0.08) : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Doğru cevap:',
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: karanlik ? Colors.grey.shade400 : Colors.brown.shade400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _dogruCevap,
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Senin cevabın: ${_cevapController.text.trim()}',
                    style: GoogleFonts.lato(
                      fontSize: 13,
                      color: Colors.red.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: karanlik ? Colors.amber.shade300 : Colors.amber.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      side: BorderSide(color: karanlik ? Colors.amber.shade600 : Colors.amber.shade400),
                    ),
                    child: Text('Tamam', style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
