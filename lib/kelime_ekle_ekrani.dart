import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';

/// KelimeEkleEkrani - Yeni kelime ekleme formu
/// İngilizce ve Türkçe girdileri alır, doğrulama yapar,
/// ve callback ile üst ekrana bildirir. Tema uyumludur.
class KelimeEkleEkrani extends StatefulWidget {
  // Kelime ekleme callback'i - üst ekrana kelimeyi iletir
  final void Function(Kelime kelime) onKelimeEkle;

  // Ekran değiştirme callback'i - ana ekrana dönmek için
  final void Function(String ekranAdi) ekranDegistir;

  // Koyu tema aktif mi?
  final bool karanlikTema;

  const KelimeEkleEkrani({
    super.key,
    required this.onKelimeEkle,
    required this.ekranDegistir,
    required this.karanlikTema,
  });

  @override
  State<KelimeEkleEkrani> createState() => _KelimeEkleEkraniState();
}

class _KelimeEkleEkraniState extends State<KelimeEkleEkrani> {
  // Form kontrolleri
  final _ingilizceController = TextEditingController();
  final _turkceController = TextEditingController();

  /// Controller'ları temizle (bellek sızıntısını önlemek için)
  @override
  void dispose() {
    _ingilizceController.dispose();
    _turkceController.dispose();
    super.dispose();
  }

  /// Platform uyumlu hata dialogu gösterir.
  /// iOS'ta CupertinoAlertDialog, Android'de AlertDialog kullanır.
  void _hataDialoguGoster(String mesaj) {
    // iOS platformu kontrolü
    if (Platform.isIOS) {
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
      // Android ve diğer platformlar
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
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

  /// Kelimeyi kavanoza ekleme işlemi
  void _kelimeyiKavanozaAt() {
    // Girdi doğrulaması - boş alan kontrolü
    final ingilizce = _ingilizceController.text.trim();
    final turkce = _turkceController.text.trim();

    if (ingilizce.isEmpty || turkce.isEmpty) {
      _hataDialoguGoster(
        'Lütfen hem İngilizce kelimeyi hem de Türkçe anlamını yazınız.',
      );
      return;
    }

    // Yeni kelime oluştur ve üst ekrana bildir
    final yeniKelime = Kelime(ingilizce: ingilizce, turkce: turkce);

    widget.onKelimeEkle(yeniKelime);

    // Ana ekrana dön
    widget.ekranDegistir('ana-ekran');
  }

  @override
  Widget build(BuildContext context) {
    final karanlik = widget.karanlikTema;

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
                ? [const Color(0xFF1A1A2E), const Color(0xFF16213E)]
                : [const Color(0xFFFFF8E1), const Color(0xFFFFE0B2)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Geri butonu
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
                          Icons.arrow_back_ios_new_rounded,
                          color: karanlik
                              ? Colors.grey.shade300
                              : Colors.brown.shade700,
                          size: 20,
                        ),
                        onPressed: () => widget.ekranDegistir('ana-ekran'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Başlık ikonu
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade400,
                            Colors.orange.shade400,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.3),
                            blurRadius: 16,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_note_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Başlık metni
                  Center(
                    child: Text(
                      'Kelime Ekle',
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: karanlik ? Colors.white : Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Yeni bir kelimeyi kavanoza at!',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: karanlik
                            ? Colors.grey.shade500
                            : Colors.brown.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // İngilizce kelime girdi alanı
                  Container(
                    decoration: BoxDecoration(
                      color: karanlik ? const Color(0xFF2D2D44) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: karanlik
                            ? Colors.amber.withValues(alpha: 0.1)
                            : Colors.amber.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: karanlik
                              ? Colors.black.withValues(alpha: 0.2)
                              : Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _ingilizceController,
                      decoration: InputDecoration(
                        labelText: 'İngilizce Kelime',
                        hintText: 'Örn: Apple',
                        prefixIcon: Icon(
                          Icons.language_rounded,
                          color: Colors.amber.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: GoogleFonts.lato(
                          color: karanlik
                              ? Colors.grey.shade400
                              : Colors.brown.shade500,
                        ),
                        hintStyle: GoogleFonts.lato(
                          color: karanlik
                              ? Colors.grey.shade600
                              : Colors.brown.shade300,
                        ),
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: karanlik ? Colors.white : Colors.brown.shade800,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Türkçe anlam girdi alanı
                  Container(
                    decoration: BoxDecoration(
                      color: karanlik ? const Color(0xFF2D2D44) : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: karanlik
                            ? Colors.amber.withValues(alpha: 0.1)
                            : Colors.amber.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: karanlik
                              ? Colors.black.withValues(alpha: 0.2)
                              : Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _turkceController,
                      decoration: InputDecoration(
                        labelText: 'Türkçe Anlamı',
                        hintText: 'Örn: Elma',
                        prefixIcon: Icon(
                          Icons.translate_rounded,
                          color: Colors.amber.shade600,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                        labelStyle: GoogleFonts.lato(
                          color: karanlik
                              ? Colors.grey.shade400
                              : Colors.brown.shade500,
                        ),
                        hintStyle: GoogleFonts.lato(
                          color: karanlik
                              ? Colors.grey.shade600
                              : Colors.brown.shade300,
                        ),
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: karanlik ? Colors.white : Colors.brown.shade800,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Kavanoza At butonu
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.3),
                          blurRadius: 14,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _kelimeyiKavanozaAt,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_circle_outline_rounded,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Kavanoza At!',
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
