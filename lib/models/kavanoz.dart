import 'package:uuid/uuid.dart';
import 'kelime.dart';

const uuid = Uuid();

/// Kavanoz modeli
/// Birden fazla kelimeyi gruplandırmak için kullanılır.
class Kavanoz {
  // Benzersiz kimlik
  final String id;

  // Kavanoz ismi (Örn: A1 Temel, Özel Kavanozum)
  String isim;

  // Kavanoz tipi ('hazir' veya 'ozel')
  final String tip;

  // Seviye veya kategori ('A1', 'A2', 'ozel')
  final String seviye;

  // Görselde gösterilecek ikon emojisi (📗, 📘, 🏺 vb.)
  final String ikon;

  // İçindeki kelimeler
  List<Kelime> kelimeListesi;

  Kavanoz({
    String? id,
    required this.isim,
    required this.tip,
    required this.seviye,
    required this.ikon,
    List<Kelime>? kelimeListesi,
  })  : id = id ?? uuid.v4(),
        kelimeListesi = kelimeListesi ?? [];

  /// Hazır (sabit) bir kavanoz mu? (Silinemez)
  bool get isHazir => tip == 'hazir';

  /// Özel (kullanıcı yapımı) bir kavanoz mu? (Silinebilir)
  bool get isOzel => tip == 'ozel';

  // ---- JSON Serileştirme (Veri Kaydetme) İşlemleri ----

  /// Nesneyi JSON haritasına dönüştürür
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isim': isim,
      'tip': tip,
      'seviye': seviye,
      'ikon': ikon,
      // Kelimeleri de teker teker JSON'a çevir
      'kelimeler': kelimeListesi.map((k) => k.toJson()).toList(),
    };
  }

  /// JSON haritasından nesne oluşturur
  factory Kavanoz.fromJson(Map<String, dynamic> json) {
    // Kelime listesini JSON listesinden dönüştür
    final kelimelerJson = json['kelimeler'] as List<dynamic>? ?? [];
    final kelimeler = kelimelerJson
        .map((k) => Kelime.fromJson(k as Map<String, dynamic>))
        .toList();

    return Kavanoz(
      id: json['id'] as String,
      isim: json['isim'] as String,
      tip: json['tip'] as String,
      seviye: json['seviye'] as String,
      ikon: json['ikon'] as String,
      kelimeListesi: kelimeler,
    );
  }
}
