import 'package:uuid/uuid.dart';

// UUID nesnesi - benzersiz ID üretmek için kullanılır
const uuid = Uuid();

/// Kelime modeli
/// Kavanoza atılacak her kelimenin bilgilerini tutar.
/// İstatistik bilgilerini (doğru/yanlış sayıları) de içerir.
class Kelime {
  // Benzersiz kimlik
  final String id;

  // İngilizce kelime
  final String ingilizce;

  // Türkçe anlamı
  final String turkce;

  // Eklenme tarihi
  final DateTime tarih;

  // Doğru cevap sayısı
  int dogruSayisi;

  // Yanlış cevap sayısı
  int yanlisSayisi;

  // Ardı ardına doğru cevap serisi (🔥 streak)
  int seri;

  // ──────────────────────────────────────────────────────────────
  //  Q-DEĞERİ (Q-Value) — Pekiştirmeli Öğrenme (RL)
  //
  //  Her kelimenin "öğrenilmişlik kalitesini" temsil eder.
  //  0.0 → Hiç bilinmiyor / çok zayıf
  //  1.0 → Tam öğrenilmiş
  //
  //  Arıtımlı (Incremental) Güncelleme Formülü:
  //    Q(t+1) = Q(t) + α × (r - Q(t))
  //
  //  • α (alfa) = öğrenme hızı = 0.2
  //  • r = ödül: doğru cevap → 1.0, yanlış cevap → 0.0
  //  • Q(t) = mevcut Q-değeri
  //
  //  Başlangıç değeri: 0.5 (nötr — ne iyi ne kötü bilinmiyor)
  // ──────────────────────────────────────────────────────────────
  double qDegeri;

  Kelime({
    String? id, // ID verilirse kullan (JSON'dan okurken), yoksa yeni üret
    required this.ingilizce,
    required this.turkce,
    DateTime? tarih,
    this.dogruSayisi = 0,
    this.yanlisSayisi = 0,
    this.seri = 0,
    this.qDegeri = 0.5, // Başlangıçta nötr (ne iyi ne kötü bilinmiyor)
  })  : id = id ?? uuid.v4(),
        tarih = tarih ?? DateTime.now();

  /// Toplam sorulma sayısı
  int get toplamSorulma => dogruSayisi + yanlisSayisi;

  /// Başarı yüzdesi (0-100 arası)
  int get basariYuzdesi {
    if (toplamSorulma == 0) return 0;
    return ((dogruSayisi / toplamSorulma) * 100).round();
  }

  // ---- JSON Serileştirme (Veri Kaydetme) İşlemleri ----

  /// Nesneyi JSON haritasına dönüştürür (Kaydetmek için)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingilizce': ingilizce,
      'turkce': turkce,
      'tarih': tarih.toIso8601String(),
      'dogruSayisi': dogruSayisi,
      'yanlisSayisi': yanlisSayisi,
      'seri': seri,
      'qDegeri': qDegeri,
    };
  }

  /// JSON haritasından nesne oluşturur (Okumak için)
  factory Kelime.fromJson(Map<String, dynamic> json) {
    return Kelime(
      id: json['id'] as String,
      ingilizce: json['ingilizce'] as String,
      turkce: json['turkce'] as String,
      tarih: DateTime.parse(json['tarih'] as String),
      dogruSayisi: json['dogruSayisi'] as int? ?? 0,
      yanlisSayisi: json['yanlisSayisi'] as int? ?? 0,
      seri: json['seri'] as int? ?? 0,
      qDegeri: (json['qDegeri'] as num?)?.toDouble() ?? 0.5,
    );
  }
}
