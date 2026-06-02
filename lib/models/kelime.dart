import 'package:uuid/uuid.dart';

// UUID nesnesi - benzersiz ID üretmek için kullanılır
const uuid = Uuid();

/// Kelime modeli
/// Kavanoza atılacak her kelimenin bilgilerini tutar.
/// İstatistik bilgilerini (doğru/yanlış sayıları) de içerir.
class Kelime {
  // Benzersiz kimlik (otomatik üretilir)
  final String id;

  // İngilizce kelime
  final String ingilizce;

  // Türkçe anlamı
  final String turkce;

  // Eklenme tarihi
  final DateTime tarih;

  // Doğru cevap sayısı (quiz'de kaç kere doğru bildi)
  int dogruSayisi;

  // Yanlış cevap sayısı (quiz'de kaç kere yanlış bildi)
  int yanlisSayisi;

  /// Constructor: id otomatik üretilir, tarih şu anki zaman olarak atanır.
  /// İstatistikler sıfırdan başlar.
  Kelime({
    required this.ingilizce,
    required this.turkce,
  })  : id = uuid.v4(),
        tarih = DateTime.now(),
        dogruSayisi = 0,
        yanlisSayisi = 0;

  /// Toplam sorulma sayısı
  int get toplamSorulma => dogruSayisi + yanlisSayisi;

  /// Başarı yüzdesi (0-100 arası)
  /// Hiç sorulmadıysa 0 döner.
  int get basariYuzdesi {
    if (toplamSorulma == 0) return 0;
    return ((dogruSayisi / toplamSorulma) * 100).round();
  }
}
