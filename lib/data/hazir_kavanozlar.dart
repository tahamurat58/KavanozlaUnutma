import '../models/kavanoz.dart';
import 'a1_kelimeler.dart';
import 'a2_kelimeler.dart';

/// Uygulamanın varsayılan (hazır) kavanozlarını oluşturur.
/// Bu fonksiyon ilk açılışta veya sıfırlamada çağrılır.
List<Kavanoz> getHazirKavanozlar() {
  return [
    Kavanoz(
      isim: 'A1 Temel Kelimeler',
      tip: 'hazir',
      seviye: 'A1',
      ikon: '📗',
      kelimeListesi: getA1Kelimeler(),
    ),
    Kavanoz(
      isim: 'A2 İleri Kelimeler',
      tip: 'hazir',
      seviye: 'A2',
      ikon: '📘',
      kelimeListesi: getA2Kelimeler(),
    ),
  ];
}
