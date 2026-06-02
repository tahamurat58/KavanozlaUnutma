import '../models/kelime.dart';

/// A2 Seviyesi (Ön Orta Düzey) İngilizce - Türkçe Kelimeler
/// Yaklaşık 120 geliştirilmiş kelime içerir.
List<Kelime> getA2Kelimeler() {
  final Map<String, String> sozluk = {
    // Soyut Kavramlar ve İletişim
    'Advice': 'Tavsiye',
    'Information': 'Bilgi',
    'Message': 'Mesaj',
    'Opinion': 'Fikir / Görüş',
    'Reason': 'Neden / Sebep',
    'Success': 'Başarı',
    'Mistake': 'Hata',
    'Problem': 'Problem',
    'Solution': 'Çözüm',
    'Difference': 'Fark',

    // Kariyer ve Eğitim
    'Company': 'Şirket',
    'Office': 'Ofis',
    'Manager': 'Yönetici',
    'Employee': 'Çalışan',
    'Customer': 'Müşteri',
    'Project': 'Proje',
    'Meeting': 'Toplantı',
    'University': 'Üniversite',
    'Science': 'Bilim',
    'History': 'Tarih',

    // Duygular ve Durumlar
    'Angry': 'Sinirli',
    'Bored': 'Sıkılmış',
    'Excited': 'Heyecanlı',
    'Tired': 'Yorgun',
    'Afraid': 'Korkmuş',
    'Surprised': 'Şaşırmış',
    'Worried': 'Endişeli',
    'Relaxed': 'Rahatlamış',
    'Proud': 'Gururlu',
    'Jealous': 'Kıskanç',

    // İleri Fiiller
    'Achieve': 'Başarmak',
    'Agree': 'Katılmak (Aynı fikirde olmak)',
    'Arrive': 'Varmak / Ulaşmak',
    'Believe': 'İnanmak',
    'Borrow': 'Ödünç Almak',
    'Lend': 'Ödünç Vermek',
    'Cancel': 'İptal Etmek',
    'Celebrate': 'Kutlamak',
    'Choose': 'Seçmek',
    'Complain': 'Şikayet Etmek',
    'Create': 'Yaratmak / Oluşturmak',
    'Decide': 'Karar Vermek',
    'Describe': 'Betimlemek / Tarif Etmek',
    'Discover': 'Keşfetmek',
    'Explain': 'Açıklamak',
    'Forget': 'Unutmak',
    'Remember': 'Hatırlamak',
    'Guess': 'Tahmin Etmek',
    'Happen': 'Olmak / Meydana Gelmek',
    'Improve': 'Geliştirmek / İyileştirmek',
    'Invite': 'Davet Etmek',
    'Learn': 'Öğrenmek',
    'Teach': 'Öğretmek',
    'Promise': 'Söz Vermek',
    'Suggest': 'Önermek',
    'Understand': 'Anlamak',

    // Sağlık ve Vücut
    'Health': 'Sağlık',
    'Disease': 'Hastalık',
    'Medicine': 'İlaç',
    'Pain': 'Ağrı / Acı',
    'Brain': 'Beyin',
    'Heart': 'Kalp',
    'Blood': 'Kan',
    'Bone': 'Kemik',
    'Skin': 'Deri / Cilt',

    // Seyahat ve Tatil
    'Journey': 'Yolculuk',
    'Flight': 'Uçuş',
    'Ticket': 'Bilet',
    'Luggage': 'Bagaj',
    'Foreign': 'Yabancı',
    'Tourist': 'Turist',
    'Guide': 'Rehber',
    'Adventure': 'Macera',

    // Teknoloji ve Medya
    'Internet': 'İnternet',
    'Network': 'Ağ / Şebeke',
    'Screen': 'Ekran',
    'Keyboard': 'Klavye',
    'Password': 'Şifre',
    'Magazine': 'Dergi',
    'Newspaper': 'Gazete',
    'News': 'Haberler',

    // Sıfatlar (A2)
    'Awesome': 'Harika',
    'Terrible': 'Berbat',
    'Careful': 'Dikkatli',
    'Careless': 'Dikkatsiz',
    'Cheap': 'Ucuz',
    'Expensive': 'Pahalı',
    'Dangerous': 'Tehlikeli',
    'Safe': 'Güvenli',
    'Difficult': 'Zor',
    'Easy': 'Kolay',
    'Important': 'Önemli',
    'Possible': 'Mümkün',
    'Impossible': 'İmkansız',
    'Strange': 'Tuhaf',
    'Popular': 'Popüler',

    // Zarf ve Bağlaçlar
    'Always': 'Her zaman',
    'Never': 'Asla',
    'Usually': 'Genellikle',
    'Sometimes': 'Bazen',
    'Almost': 'Neredeyse',
    'Already': 'Zaten / Çoktan',
    'Quickly': 'Hızlıca',
    'Suddenly': 'Aniden',
    'Because': 'Çünkü',
    'However': 'Ancak / Bununla birlikte',
    'Although': 'Rağmen',
    'Therefore': 'Bu nedenle',
  };

  return sozluk.entries
      .map((entry) => Kelime(ingilizce: entry.key, turkce: entry.value))
      .toList();
}
