import 'package:flutter/material.dart';
import 'models/kelime.dart';
import 'ana_ekran.dart';
import 'kelime_ekle_ekrani.dart';
import 'kelime_listesi_ekrani.dart';

/// UstEkran - Ana state yöneticisi
/// Tüm ekranları yöneten parent widget.
/// Kelime listesini tutar, ekran geçişlerini kontrol eder.
class UstEkran extends StatefulWidget {
  const UstEkran({super.key});

  @override
  State<UstEkran> createState() => _UstEkranState();
}

class _UstEkranState extends State<UstEkran> {
  // Kavanozdaki tüm kelimeler
  final List<Kelime> _kelimeListesi = [];

  // Aktif ekranı takip eden değişken
  String _aktifEkran = 'ana-ekran';

  /// Ekran değiştirme fonksiyonu
  /// Alt widget'lar bu fonksiyonu callback olarak kullanır.
  void _ekranDegistir(String ekranAdi) {
    setState(() {
      _aktifEkran = ekranAdi;
    });
  }

  /// Yeni kelime ekleme fonksiyonu
  /// KelimeEkleEkrani'ndan callback ile çağrılır.
  void _kelimeEkle(Kelime kelime) {
    setState(() {
      _kelimeListesi.add(kelime);
    });
  }

  /// Kelime silme fonksiyonu
  /// KelimeListesiEkrani'ndan callback ile çağrılır.
  void _kelimeSil(String id) {
    setState(() {
      _kelimeListesi.removeWhere((kelime) => kelime.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aktif ekrana göre widget döndür (if-else blokları)
    if (_aktifEkran == 'kelime-ekle') {
      return KelimeEkleEkrani(
        onKelimeEkle: _kelimeEkle,
        ekranDegistir: _ekranDegistir,
      );
    }

    if (_aktifEkran == 'kelime-listesi') {
      return KelimeListesiEkrani(
        kelimeListesi: _kelimeListesi,
        onKelimeSil: _kelimeSil,
        ekranDegistir: _ekranDegistir,
      );
    }

    // Varsayılan: Ana ekran
    return AnaEkran(
      kelimeListesi: _kelimeListesi,
      ekranDegistir: _ekranDegistir,
    );
  }
}
