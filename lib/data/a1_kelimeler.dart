import '../models/kelime.dart';

/// A1 Seviyesi (Temel Düzey) İngilizce - Türkçe Kelimeler
/// Yaklaşık 120 temel kelime içerir.
List<Kelime> getA1Kelimeler() {
  final Map<String, String> sozluk = {
    // Sayılar
    'One': 'Bir',
    'Two': 'İki',
    'Three': 'Üç',
    'Four': 'Dört',
    'Five': 'Beş',
    'Ten': 'On',
    'Twenty': 'Yirmi',
    'Hundred': 'Yüz',

    // Renkler
    'Red': 'Kırmızı',
    'Blue': 'Mavi',
    'Green': 'Yeşil',
    'Yellow': 'Sarı',
    'Black': 'Siyah',
    'White': 'Beyaz',
    'Brown': 'Kahverengi',
    'Orange': 'Turuncu',

    // Aile ve Kişiler
    'Family': 'Aile',
    'Mother': 'Anne',
    'Father': 'Baba',
    'Brother': 'Erkek Kardeş',
    'Sister': 'Kız Kardeş',
    'Child': 'Çocuk',
    'Friend': 'Arkadaş',
    'Person': 'Kişi',
    'Man': 'Adam',
    'Woman': 'Kadın',

    // Günlük Hayat & Ev
    'House': 'Ev',
    'Room': 'Oda',
    'Door': 'Kapı',
    'Window': 'Pencere',
    'Table': 'Masa',
    'Chair': 'Sandalye',
    'Bed': 'Yatak',
    'Book': 'Kitap',
    'Pen': 'Tükenmez Kalem',
    'Pencil': 'Kurşun Kalem',
    'Phone': 'Telefon',
    'Computer': 'Bilgisayar',

    // Zaman
    'Time': 'Zaman',
    'Day': 'Gün',
    'Night': 'Gece',
    'Morning': 'Sabah',
    'Evening': 'Akşam',
    'Week': 'Hafta',
    'Month': 'Ay',
    'Year': 'Yıl',
    'Today': 'Bugün',
    'Tomorrow': 'Yarın',
    'Yesterday': 'Dün',

    // Yiyecek ve İçecekler
    'Water': 'Su',
    'Food': 'Yiyecek',
    'Bread': 'Ekmek',
    'Meat': 'Et',
    'Fish': 'Balık',
    'Apple': 'Elma',
    'Milk': 'Süt',
    'Coffee': 'Kahve',
    'Tea': 'Çay',
    'Sugar': 'Şeker',

    // Doğa
    'Sun': 'Güneş',
    'Moon': 'Ay (Gökyüzü)',
    'Tree': 'Ağaç',
    'Flower': 'Çiçek',
    'Animal': 'Hayvan',
    'Dog': 'Köpek',
    'Cat': 'Kedi',
    'Bird': 'Kuş',

    // Temel Fiiller
    'Be': 'Olmak',
    'Have': 'Sahip Olmak',
    'Do': 'Yapmak',
    'Say': 'Söylemek',
    'Go': 'Gitmek',
    'Get': 'Almak / Elde Etmek',
    'Make': 'Yapmak / Üretmek',
    'Know': 'Bilmek',
    'Think': 'Düşünmek',
    'Take': 'Almak',
    'See': 'Görmek',
    'Come': 'Gelmek',
    'Want': 'İstemek',
    'Look': 'Bakmak',
    'Use': 'Kullanmak',
    'Find': 'Bulmak',
    'Give': 'Vermek',
    'Tell': 'Anlatmak',
    'Work': 'Çalışmak',
    'Call': 'Aramak',

    // Temel Sıfatlar
    'Good': 'İyi',
    'Bad': 'Kötü',
    'Big': 'Büyük',
    'Small': 'Küçük',
    'Hot': 'Sıcak',
    'Cold': 'Soğuk',
    'New': 'Yeni',
    'Old': 'Eski',
    'Happy': 'Mutlu',
    'Sad': 'Üzgün',
    'Beautiful': 'Güzel',
    'Ugly': 'Çirkin',
    'Fast': 'Hızlı',
    'Slow': 'Yavaş',

    // Taşıtlar ve Yerler
    'Car': 'Araba',
    'Bus': 'Otobüs',
    'Train': 'Tren',
    'School': 'Okul',
    'Hospital': 'Hastane',
    'Shop': 'Dükkan',
    'City': 'Şehir',
    'Street': 'Sokak',

    // Selamlaşma ve Nezaket
    'Hello': 'Merhaba',
    'Goodbye': 'Hoşça kal',
    'Please': 'Lütfen',
    'Thanks': 'Teşekkürler',
    'Sorry': 'Özür Dilerim',
    'Yes': 'Evet',
    'No': 'Hayır',
    'Help': 'Yardım',
  };

  return sozluk.entries
      .map((entry) => Kelime(ingilizce: entry.key, turkce: entry.value))
      .toList();
}
