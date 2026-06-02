import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/kelime.dart';

/// KelimeSoruDialogu - Kavanozdan çekilen kelimeyi quiz formatında gösterir.
/// Rastgele İngilizce veya Türkçe gösterir, kullanıcıdan karşılığını ister.
/// Doğru/yanlış geri bildirimi verir ve sonucu callback ile üst ekrana bildirir.
class KelimeSoruDialogu extends StatefulWidget {
  // Sorulan kelime
  final Kelime kelime;

  // Sonuç callback'i - doğru/yanlış bilgisini üst ekrana iletir
  final void Function(String id, bool dogruMu) onSonuc;

  const KelimeSoruDialogu({
    super.key,
    required this.kelime,
    required this.onSonuc,
  });

  @override
  State<KelimeSoruDialogu> createState() => _KelimeSoruDialoguState();
}

class _KelimeSoruDialoguState extends State<KelimeSoruDialogu> {
  // Cevap giriş controller'ı
  final _cevapController = TextEditingController();

  // Rastgele yön: true ise İngilizce göster → Türkçe iste,
  //               false ise Türkçe göster → İngilizce iste
  late final bool _ingilizceSor;

  // Kullanıcı cevap verdi mi?
  bool _cevapVerildi = false;

  // Cevap doğru mu?
  bool _dogruMu = false;

  @override
  void initState() {
    super.initState();
    // Rastgele yön belirle: İngilizce mi Türkçe mi gösterilecek
    _ingilizceSor = Random().nextBool();
  }

  @override
  void dispose() {
    _cevapController.dispose();
    super.dispose();
  }

  /// Gösterilen kelime (soru)
  String get _soruKelime =>
      _ingilizceSor ? widget.kelime.ingilizce : widget.kelime.turkce;

  /// Beklenen doğru cevap
  String get _dogruCevap =>
      _ingilizceSor ? widget.kelime.turkce : widget.kelime.ingilizce;

  /// Soru dilini gösteren etiket
  String get _soruDili => _ingilizceSor ? '🇬🇧 İngilizce' : '🇹🇷 Türkçe';

  /// İstenen cevap dilini gösteren etiket
  String get _cevapDili => _ingilizceSor ? 'Türkçe' : 'İngilizce';

  /// Kullanıcının cevabını kontrol eder ve sonucu callback ile bildirir
  void _cevapKontrol() {
    final kullaniciCevabi = _cevapController.text.trim().toLowerCase();
    final beklenenCevap = _dogruCevap.trim().toLowerCase();

    if (kullaniciCevabi.isEmpty) {
      return; // Boş cevap gönderilmesin
    }

    final sonuc = kullaniciCevabi == beklenenCevap;

    // Sonucu üst ekrana bildir (istatistik güncelleme için)
    widget.onSonuc(widget.kelime.id, sonuc);

    setState(() {
      _cevapVerildi = true;
      _dogruMu = sonuc;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Tema bilgisini al
    final karanlik = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
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
                  gradient: LinearGradient(
                    colors: [Colors.amber.shade400, Colors.orange.shade400],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),

              // Başlık metni
              Text(
                'Kavanozdan Çıkan',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: karanlik ? Colors.grey.shade300 : Colors.brown.shade600,
                ),
              ),
              const SizedBox(height: 8),

              // Hangi dilde gösterildiğini belirten etiket
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: karanlik
                      ? Colors.amber.withValues(alpha: 0.1)
                      : Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: karanlik
                        ? Colors.amber.withValues(alpha: 0.2)
                        : Colors.amber.shade200,
                  ),
                ),
                child: Text(
                  _soruDili,
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: karanlik
                        ? Colors.amber.shade300
                        : Colors.brown.shade500,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Gösterilen kelime (soru)
              Text(
                _soruKelime,
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: karanlik
                      ? Colors.amber.shade200
                      : Colors.amber.shade800,
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
                      karanlik
                          ? Colors.amber.shade400
                          : Colors.amber.shade300,
                      Colors.amber.shade200.withValues(alpha: 0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(height: 20),

              // Cevap henüz verilmedi ise → giriş alanı göster
              if (!_cevapVerildi) ...[
                // Cevap girdi alanı
                TextField(
                  controller: _cevapController,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '$_cevapDili karşılığını yazın...',
                    hintStyle: GoogleFonts.lato(
                      fontSize: 14,
                      color: karanlik
                          ? Colors.grey.shade500
                          : Colors.brown.shade300,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: karanlik
                            ? Colors.grey.shade700
                            : Colors.amber.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: karanlik
                            ? Colors.grey.shade700
                            : Colors.amber.shade200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: Colors.amber.shade600,
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    filled: true,
                    fillColor: karanlik
                        ? const Color(0xFF1A1A2E)
                        : Colors.amber.shade50.withValues(alpha: 0.5),
                  ),
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: karanlik ? Colors.white : Colors.brown.shade800,
                  ),
                  // Enter tuşuna basınca kontrol et
                  onSubmitted: (_) => _cevapKontrol(),
                ),
                const SizedBox(height: 18),

                // Kontrol Et butonu
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _cevapKontrol,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                      shadowColor: Colors.amber.shade200,
                    ),
                    child: Text(
                      'Kontrol Et',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],

              // Cevap verildiyse → sonuç göster
              if (_cevapVerildi) ...[
                // Sonuç ikonu (daire arka plan ile)
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _dogruMu
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.red.withValues(alpha: 0.1),
                  ),
                  child: Icon(
                    _dogruMu ? Icons.check_circle : Icons.cancel,
                    size: 52,
                    color: _dogruMu
                        ? Colors.green.shade500
                        : Colors.red.shade400,
                  ),
                ),
                const SizedBox(height: 12),

                // Doğru/Yanlış mesajı
                Text(
                  _dogruMu ? 'Doğru! 🎉' : 'Yanlış! 😔',
                  style: GoogleFonts.lato(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _dogruMu
                        ? Colors.green.shade600
                        : Colors.red.shade500,
                  ),
                ),
                const SizedBox(height: 14),

                // Yanlışsa doğru cevabı göster
                if (!_dogruMu) ...[
                  // Doğru cevap kutusu
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: karanlik
                          ? Colors.green.withValues(alpha: 0.08)
                          : Colors.green.shade50,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.green.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Doğru cevap:',
                          style: GoogleFonts.lato(
                            fontSize: 12,
                            color: karanlik
                                ? Colors.grey.shade400
                                : Colors.brown.shade400,
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

                  // Kullanıcının verdiği cevap
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

                // Tamam butonu
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: karanlik
                          ? Colors.amber.shade300
                          : Colors.amber.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      side: BorderSide(
                        color: karanlik
                            ? Colors.amber.shade600
                            : Colors.amber.shade400,
                      ),
                    ),
                    child: Text(
                      'Tamam',
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
