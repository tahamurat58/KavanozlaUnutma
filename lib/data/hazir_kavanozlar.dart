import '../models/kavanoz.dart';
import 'a1_kelimeler.dart';
import 'a2_kelimeler.dart';

/// Uygulamanın varsayılan (hazır) kavanozlarını oluşturur.
/// Bu fonksiyon ilk açılışta veya sıfırlamada çağrılır.
List<Kavanoz> getHazirKavanozlar() {
  return [
    Kavanoz(
      isim: 'Oxford A1 İngilizce Kelimeler',
      tip: 'hazir',
      seviye: 'A1',
      ikon: '🇬🇧',
      kelimeListesi: getA1Kelimeler(),
    ),
    Kavanoz(
      isim: 'Oxford A2 İngilizce Kelimeler',
      tip: 'hazir',
      seviye: 'A2',
      ikon: '🇬🇧',
      kelimeListesi: getA2Kelimeler(),
    ),
  ];
}
