import 'package:flutter/material.dart';
import 'models/kavanoz.dart';
import 'models/kelime.dart';
import 'veri_yoneticisi.dart';
import 'kavanoz_secim_ekrani.dart';
import 'kavanoz_olustur_ekrani.dart';
import 'ana_ekran.dart';
import 'kelime_ekle_ekrani.dart';
import 'kelime_listesi_ekrani.dart';

/// UstEkran - Ana state yöneticisi
class UstEkran extends StatefulWidget {
  final bool karanlikTema;
  final VoidCallback temaDegistir;

  const UstEkran({
    super.key,
    required this.karanlikTema,
    required this.temaDegistir,
  });

  @override
  State<UstEkran> createState() => _UstEkranState();
}

class _UstEkranState extends State<UstEkran> {
  // Tüm kavanozlarımızın listesi
  List<Kavanoz> _kavanozListesi = [];

  // Seçili kavanozun ID'si
  String? _seciliKavanozId;

  // Aktif ekran (Artık başlangıç ekranımız kavanoz-secim)
  String _aktifEkran = 'kavanoz-secim';

  // Verilerin yüklenip yüklenmediği
  bool _verilerYuklendi = false;

  // Akıllı Mod (Pekiştirmeli Öğrenme) açık mı?
  bool _akilliMod = true;

  @override
  void initState() {
    super.initState();
    _ilkVerileriYukle();
  }

  /// Uygulama açıldığında JSON'dan verileri yükler
  Future<void> _ilkVerileriYukle() async {
    final yuklenen = await veriYoneticisi.verileriYukle();
    setState(() {
      _kavanozListesi = yuklenen;
      _verilerYuklendi = true;
    });
  }

  /// Her değişiklikte verileri JSON'a kaydeder
  void _verileriKaydet() {
    veriYoneticisi.verileriKaydet(_kavanozListesi);
  }

  /// Ekran değiştirme callback'i
  void _ekranDegistir(String ekranAdi) {
    setState(() {
      _aktifEkran = ekranAdi;
      // Eğer seçim ekranına dönüyorsak seçili kavanozu temizle
      if (ekranAdi == 'kavanoz-secim') {
        _seciliKavanozId = null;
      }
    });
  }

  /// Kavanoz seçme callback'i
  void _kavanozSec(String id) {
    setState(() {
      _seciliKavanozId = id;
      _aktifEkran = 'ana-ekran'; // Seçince doğrudan kavanozun içine gir
    });
  }

  /// Yeni özel kavanoz ekleme callback'i
  void _kavanozEkle(String isim, String ikon) {
    final yeniKavanoz = Kavanoz(
      isim: isim,
      tip: 'ozel',
      seviye: 'ozel',
      ikon: ikon,
    );
    setState(() {
      _kavanozListesi.add(yeniKavanoz);
      _verileriKaydet();
    });
  }

  /// Kavanoz silme callback'i
  void _kavanozSil(String id) {
    setState(() {
      _kavanozListesi.removeWhere((k) => k.id == id);
      _verileriKaydet();
    });
  }

  /// Seçili kavanoza kelime ekleme callback'i
  void _kelimeEkle(Kelime kelime) {
    if (_seciliKavanozId == null) return;
    setState(() {
      final k = _kavanozListesi.firstWhere((k) => k.id == _seciliKavanozId);
      k.kelimeListesi.add(kelime);
      _verileriKaydet();
    });
  }

  /// Seçili kavanozdan kelime silme callback'i
  void _kelimeSil(String kelimeId) {
    if (_seciliKavanozId == null) return;
    setState(() {
      final k = _kavanozListesi.firstWhere((k) => k.id == _seciliKavanozId);
      k.kelimeListesi.removeWhere((kel) => kel.id == kelimeId);
      _verileriKaydet();
    });
  }

  /// Seçili kavanozdaki kelimenin istatistiğini güncelleme
  void _istatistikGuncelle(String kelimeId, bool dogruMu) {
    if (_seciliKavanozId == null) return;
    setState(() {
      final kavanoz = _kavanozListesi.firstWhere((k) => k.id == _seciliKavanozId);
      final kelimeIndex = kavanoz.kelimeListesi.indexWhere((k) => k.id == kelimeId);
      
      if (kelimeIndex != -1) {
        final kelime = kavanoz.kelimeListesi[kelimeIndex];

        if (dogruMu) {
          kelime.dogruSayisi++;
          kelime.seri++; // 🔥 Seri artır
        } else {
          kelime.yanlisSayisi++;
          kelime.seri = 0; // 🔥 Seri sıfırla
        }

        // ──────────────────────────────────────────────────────
        //  ARITIMLi Q-DEĞERİ GÜNCELLEMESİ (Incremental RL Update)
        //
        //  Formül: Q(t+1) = Q(t) + α × (r - Q(t))
        //
        //  • α = 0.2  →  öğrenme hızı (learning rate)
        //  • r = 1.0  →  doğru cevap için ödül (reward)
        //  • r = 0.0  →  yanlış cevap için ödül (reward)
        //
        //  Bu formül Q-değerini her adımda anlık ödüle yaklaştırır.
        //  Doğru cevaplar → Q artar (1.0'a yaklaşır)
        //  Yanlış cevaplar → Q azalır (0.0'a yaklaşır)
        // ──────────────────────────────────────────────────────
        const double alfa = 0.2; // Öğrenme hızı
        final double odul = dogruMu ? 1.0 : 0.0; // Ödül sinyali
        kelime.qDegeri = kelime.qDegeri + alfa * (odul - kelime.qDegeri);

        _verileriKaydet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Veriler yüklenene kadar bekleme ekranı
    if (!_verilerYuklendi) {
      return Scaffold(
        backgroundColor: widget.karanlikTema ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
        body: Center(
          child: CircularProgressIndicator(color: Colors.amber.shade600),
        ),
      );
    }

    // Ekran yönlendirmeleri
    if (_aktifEkran == 'kavanoz-secim') {
      return KavanozSecimEkrani(
        kavanozListesi: _kavanozListesi,
        karanlikTema: widget.karanlikTema,
        temaDegistir: widget.temaDegistir,
        onKavanozSec: _kavanozSec,
        onKavanozSil: _kavanozSil,
        ekranDegistir: _ekranDegistir,
      );
    }

    if (_aktifEkran == 'kavanoz-olustur') {
      return KavanozOlusturEkrani(
        karanlikTema: widget.karanlikTema,
        ekranDegistir: _ekranDegistir,
        onKavanozEkle: _kavanozEkle,
      );
    }

    // Bundan sonraki ekranlar seçili bir kavanoz gerektirir
    final seciliKavanoz = _kavanozListesi.firstWhere(
      (k) => k.id == _seciliKavanozId,
      orElse: () => _kavanozListesi.first, // Güvenlik önlemi
    );

    if (_aktifEkran == 'kelime-ekle') {
      return KelimeEkleEkrani(
        onKelimeEkle: _kelimeEkle,
        ekranDegistir: _ekranDegistir,
        karanlikTema: widget.karanlikTema,
      );
    }

    if (_aktifEkran == 'kelime-listesi') {
      return KelimeListesiEkrani(
        kavanoz: seciliKavanoz,
        onKelimeSil: _kelimeSil,
        ekranDegistir: _ekranDegistir,
        karanlikTema: widget.karanlikTema,
      );
    }

    // Varsayılan: Seçili kavanozun ana ekranı
    return AnaEkran(
      kavanoz: seciliKavanoz,
      ekranDegistir: _ekranDegistir,
      karanlikTema: widget.karanlikTema,
      temaDegistir: widget.temaDegistir,
      onIstatistikGuncelle: _istatistikGuncelle,
      akilliMod: _akilliMod,
      onAkilliModDegistir: () {
        setState(() {
          _akilliMod = !_akilliMod;
        });
      },
    );
  }
}
