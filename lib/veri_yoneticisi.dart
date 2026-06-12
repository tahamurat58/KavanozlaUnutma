import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'models/kavanoz.dart';
import 'data/hazir_kavanozlar.dart';

/// VeriYoneticisi - Tüm verilerin cihaza kaydedilmesi ve okunması
/// Hocanın yapısına sadık kalarak karmaşık SQL veritabanları yerine
/// basit ve profesyonel JSON dosyası üzerinden kalıcılık sağlar.
class VeriYoneticisi {
  static const String _dosyaAdi = 'kavanoz_verileri.json';

  /// Cihazın uygulama dokümanları dizinindeki dosya yolunu alır
  Future<File> get _yerelDosya async {
    final dizin = await getApplicationDocumentsDirectory();
    return File('${dizin.path}/$_dosyaAdi');
  }

  /// Verileri cihaza kaydeder
  Future<void> verileriKaydet(List<Kavanoz> kavanozlar) async {
    try {
      final dosya = await _yerelDosya;

      // Kavanoz listesini JSON listesine çevir
      final List<Map<String, dynamic>> jsonVerisi =
          kavanozlar.map((k) => k.toJson()).toList();

      // JSON'ı stringe çevirip dosyaya yaz
      final stringVeri = jsonEncode(jsonVerisi);
      await dosya.writeAsString(stringVeri);
    } catch (e) {
      // Hata durumunda konsola yazdır (kullanıcıya yansıtma)
      debugPrint('Veri kaydetme hatası: $e');
    }
  }

  /// Verileri cihazdan okur.
  /// Eğer dosya yoksa (ilk açılış) hazır A1/A2 kavanozlarını döndürür.
  Future<List<Kavanoz>> verileriYukle() async {
    try {
      final dosya = await _yerelDosya;

      // Dosya var mı kontrolü
      if (!await dosya.exists()) {
        // İlk açılış: Hazır kavanozları döndür (ve otomatik kaydedilir)
        return getHazirKavanozlar();
      }

      // Dosyadan JSON stringini oku
      final stringVeri = await dosya.readAsString();

      // JSON stringini listeye çevir
      final List<dynamic> jsonListesi = jsonDecode(stringVeri);

      // JSON listesini Kavanoz nesnelerine çevir
      final yuklenenKavanozlar = jsonListesi
          .map((k) => Kavanoz.fromJson(k as Map<String, dynamic>))
          .toList();

      return yuklenenKavanozlar;
    } catch (e) {
      debugPrint('Veri okuma hatası: $e');
      // Hata durumunda uygulamanın çökmemesi için hazır verileri döndür
      return getHazirKavanozlar();
    }
  }
}

// Global olarak kullanılabilecek tek bir instance
final veriYoneticisi = VeriYoneticisi();
