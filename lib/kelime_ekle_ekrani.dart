import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/kelime.dart';

/// KelimeEkleEkrani - Yeni kelime ekleme formu
/// İngilizce ve Türkçe girdileri alır, doğrulama yapar,
/// ve callback ile üst ekrana bildirir.
class KelimeEkleEkrani extends StatefulWidget {
  // Kelime ekleme callback'i - üst ekrana kelimeyi iletir
  final void Function(Kelime kelime) onKelimeEkle;

  // Ekran değiştirme callback'i - ana ekrana dönmek için
  final void Function(String ekranAdi) ekranDegistir;

  const KelimeEkleEkrani({
    super.key,
    required this.onKelimeEkle,
    required this.ekranDegistir,
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
      _hataDialoguGoster('Lütfen hem İngilizce kelimeyi hem de Türkçe anlamını yazınız.');
      return;
    }

    // Yeni kelime oluştur ve üst ekrana bildir
    final yeniKelime = Kelime(
      ingilizce: ingilizce,
      turkce: turkce,
    );

    widget.onKelimeEkle(yeniKelime);

    // Ana ekrana dön
    widget.ekranDegistir('ana-ekran');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient arka planlı gövde
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.amber.shade50,
              Colors.orange.shade100,
            ],
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
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.brown.shade700,
                      ),
                      onPressed: () => widget.ekranDegistir('ana-ekran'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Başlık
                  Center(
                    child: Text(
                      '📝 Kelime Ekle',
                      style: GoogleFonts.lato(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Yeni bir kelimeyi kavanoza at!',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.brown.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // İngilizce kelime girdi alanı
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _ingilizceController,
                      decoration: InputDecoration(
                        labelText: 'İngilizce Kelime',
                        hintText: 'Örn: Apple',
                        prefixIcon: Icon(
                          Icons.language,
                          color: Colors.amber.shade700,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: GoogleFonts.lato(
                          color: Colors.brown.shade500,
                        ),
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.brown.shade800,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Türkçe anlam girdi alanı
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _turkceController,
                      decoration: InputDecoration(
                        labelText: 'Türkçe Anlamı',
                        hintText: 'Örn: Elma',
                        prefixIcon: Icon(
                          Icons.translate,
                          color: Colors.amber.shade700,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: GoogleFonts.lato(
                          color: Colors.brown.shade500,
                        ),
                      ),
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.brown.shade800,
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Kavanoza At butonu
                  ElevatedButton(
                    onPressed: _kelimeyiKavanozaAt,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_circle_outline, size: 24),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
