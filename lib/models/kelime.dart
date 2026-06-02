import 'package:uuid/uuid.dart';

// UUID nesnesi - benzersiz ID üretmek için kullanılır
const uuid = Uuid();

/// Kelime modeli
/// Kavanoza atılacak her kelimenin bilgilerini tutar.
class Kelime {
  // Benzersiz kimlik (otomatik üretilir)
  final String id;

  // İngilizce kelime
  final String ingilizce;

  // Türkçe anlamı
  final String turkce;

  // Eklenme tarihi
  final DateTime tarih;

  /// Constructor: id otomatik üretilir, tarih şu anki zaman olarak atanır.
  Kelime({
    required this.ingilizce,
    required this.turkce,
  })  : id = uuid.v4(),
        tarih = DateTime.now();
}
