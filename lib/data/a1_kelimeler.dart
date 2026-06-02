import '../models/kelime.dart';

/// A1 Seviyesi (Temel Düzey) İngilizce - Türkçe Kelimeler
/// Yaklaşık 120 temel kelime içerir.
List<Kelime> getA1Kelimeler() {
  final Map<String, String> sozluk = <String, String>{
    'About': 'Aşağı Yukarı, Yaklaşık, Hemen Hemen', // [cite: 1]
    'Above': 'Yukarıda, Yukarısında, Üzerine', // [cite: 1]
    'Across': 'Karşıya, Karşı Karşıya, (Deniz/Okyanus) Aşırı', // [cite: 1]
    'Action': 'Aksiyon, Davranış, Çalışma', // [cite: 1]
    'Activity': 'Meşguliyet, Faaliyet, Etkinlik', // [cite: 1]
    'Actor': 'Artist, Erkek Oyuncu, Oyuncu', // [cite: 1]
    'Actress': 'Aktris, Artist, Oyuncu', // [cite: 1]
    'Add': 'Toplamak, İlave Etmek, Eklemek', // [cite: 1]
    'Address': 'Hitap Etmek, Adres, Söylev', // [cite: 1]
    'Adult': 'Yetişkin Kişi, Er Kişi, Yetişkin', // [cite: 1]
    'Advice': 'Öğüt, Tavsiye, Nasihat', // [cite: 1]
    'Afraid': 'Ürkmüş, Korkan, Korkmuş', // [cite: 1]
    'After': 'Sonra Gelen, Sonra', // [cite: 1]
    'Afternoon':
        'Öğleden Sonra, Son Kısım, Bir Şeyin Orta Ve Son Bölümü', // [cite: 1]
    'Again': 'Tekrar, Daha, Bir Daha', // [cite: 1]
    'Age': 'Çağ, Yaş, Devir', // [cite: 1]
    'Ago': 'Evvel, Önce', // [cite: 1]
    'Agree': 'Anlaşmak, Razı Olmak, Aynı Fikirde Olmak', // [cite: 1]
    'Air': 'Hava, Yayına Girmek, Havalandırmak', // [cite: 1]
    'Airport': 'Havaalanı, Havalimanı, Hava Limanı', // [cite: 1]
    'All': 'Tüm, Bütün, Hepsi', // [cite: 1]
    'Also': 'Yine, Ayrıca, Da', // [cite: 1]
    'Always': 'Hep, Daima, Her Zaman', // [cite: 1]
    'Amazing': 'Şaşırtıcı, Şaşırtma, Hayrete Düşürücü', // [cite: 1]
    'And': 'İle, Ve', // [cite: 1]
    'Angry': 'Sinirli, Kızmış, Hiddetli', // [cite: 1]
    'Animal': 'Hayvan, Hayvani', // [cite: 1]
    'Another': 'Başka, Öbür, İkinci Bir', // [cite: 1]
    'Answer': 'Vermek, Cevaplamak, Yanıt, Cevap Vermek', // [cite: 1]
    'Any': 'Lalettayin, Bazı, Her, Herhangi Bir Kimse', // [cite: 1]
    'Anyone': 'Hiç Kimse, Kimse, Herhangi Bir Kimse', // [cite: 1]
    'Anything': 'Hiçbir Şey, Her Şey, Bir Şey', // [cite: 1]
    'Apartment': 'Daire, Apartman Katı, Apartman Dairesi', // [cite: 1]
    'Apple': 'Elma', // [cite: 1]
    'April': 'Nisan, Yılın Dördüncü Ayı, Nisan Ayı', // [cite: 1]
    'Area': 'Bölge, Alan, Saha', // [cite: 1]
    'Arm': 'Sarılmak, Destek Olmak', // [cite: 1]
    'Around': 'Çevrede, Etrafında', // [cite: 1]
    'Arrive': 'Gelip Çatmak, Ulaşmak', // [cite: 1]
    'Art': 'Maharet, Beceri', // [cite: 1]
    'Article': 'Madde, Bent', // [cite: 1]
    'Artist': 'Sanatçı, Artist, Sanatkar', // [cite: 1]
    'As': 'Dahi, Gibi, Olarak', // [cite: 1]
    'Ask': 'Soru Sormak, Çağırmak, İstemek', // [cite: 1]
    'At': 'Haliyle, Üzere, Nezdinde', // [cite: 1]
    'August': 'Ağustos Ayı, Ağustos, Yılın Sekizinci Ayı', // [cite: 1]
    'Aunt': 'Yenge, Hala, Teyze', // [cite: 1]
    'Autumn': 'Hazan, Sonbahar, Güz', // [cite: 1]
    'Away': 'Uzak, Uzakta, Uzağa', // [cite: 1]
    'Baby': 'Yavru, Şımartmak, Bebek', // [cite: 4]
    'Back': 'Art, Arkalık, Sırt', // [cite: 4]
    'Bad': 'Bozuk, Fena, Kötü', // [cite: 4]
    'Bag': 'Torba, Poşet, Çanta', // [cite: 4]
    'Ball': 'Yumak, Balo, Bilye', // [cite: 4]
    'Banana': 'Muz', // [cite: 4]
    'Band': 'Bando, Şerit, Bant', // [cite: 4]
    'Bank': 'Banka, Kümelenmek, Önlemek', // [cite: 4]
    'Bath': 'Banyo, Banyo Yapmak, Yıkanmak', // [cite: 4]
    'Bathroom': 'Banyo, Banyo Odası, Tuvalet', // [cite: 4]
    'Be': 'Olmak, Bulunmak, Var Olmak', // [cite: 4]
    'Beach': 'Kumsal, Sahil, Plaj', // [cite: 4]
    'Beautiful': 'Güzel, Tatlı, Ahım Şahım', // [cite: 4]
    'Because': 'Çünkü, -Dığı İçin, Zira', // [cite: 4]
    'Become': 'Olmak, Haline Gelmek, Dönüşmek', // [cite: 4]
    'Bed': 'Yatak, Gömmek, Oturtmak', // [cite: 4]
    'Bedroom': 'Yatak Odası, Şebistan', // [cite: 4]
    'Beer': 'Bira, Arpasuyu', // [cite: 4]
    'Before': 'Evvel, Daha Önce, Aşağıdaki', // [cite: 4]
    'Begin': 'Başlamak, Başlatmak', // [cite: 4]
    'Beginning': 'İlk Adım, Başlangıç', // [cite: 4]
    'Behind': 'Arkaya, Ardındaki, Geriye', // [cite: 4]
    'Believe': 'Kanmak, İnanmak', // [cite: 4]
    'Below': 'Altta, Alttaki', // [cite: 4]
    'Best': 'Baskın Çıkmak, Geçmek, En İyi', // [cite: 4]
    'Better': 'İyileştirmek, Islah Etmek, Daha İyi', // [cite: 4]
    'Between': 'Ortada, Arasında, Arasına', // [cite: 4]
    'Bicycle': 'Gezmek, Bisiklet', // [cite: 4]
    'Big': 'Kapı Gibi, İri', // [cite: 4]
    'Bike':
        'Bisiklet Sürmek, Bisiklete Binmek, Bisiklet Kullanarak Gitmek', // [cite: 4]
    'Bill': 'Senet, Fatura, İlan', // [cite: 4]
    'Bird': 'Kuş', // [cite: 4]
    'Birthday': 'Doğum Günü, Yaş Günü', // [cite: 4]
    'Black': 'Siyah, Kara, Siyahi', // [cite: 4]
    'Blog': 'İnternet Günlüğü, Web Günlüğü', // [cite: 4]
    'Blonde': 'Sarı, Sarışın, Sarışın Kız', // [cite: 4]
    'Blue': 'Mavi', // [cite: 4]
    'Boat': 'Bot, Tekne, Kayık', // [cite: 4]
    'Body': 'Ceset, Gövde, Vücut', // [cite: 4]
    'Book': 'Ayırtmak, Deftere İşlemek, Kitap', // [cite: 4]
    'Boot': 'Bot, Çizme, Kovmak', // [cite: 4]
    'Bored': 'Sıkılmış, Delinmiş, Bıkkın', // [cite: 4]
    'Boring': 'Bıktırıcı, Bıktıran, Sıkıcı', // [cite: 4]
    'Born': 'Doğan, Doğuştan, Doğmuş', // [cite: 4]
    'Both': 'Her İkisi De, Her İki', // [cite: 4]
    'Bottle': 'Şişelemek, Susturmak, Şişe', // [cite: 4]
    'Box': 'Kutu, Boks Etmek, Yumruk Atmak', // [cite: 4]
    'Boy': 'Oğlan, Erkek Çocuk, Delikanlı', // [cite: 7]
    'Boyfriend': 'Erkek Arkadaş, Sevgili, Flört', // [cite: 7]
    'Bread': 'Geçim, Pane Etmek, Ekmek', // [cite: 7]
    'Break': 'Bozmak, Kopmak, Kırmak', // [cite: 7]
    'Breakfast': 'Kahvaltı, Kahvaltı Etmek', // [cite: 7]
    'Bring': 'Neden Olmak, Getirmek', // [cite: 7]
    'Brother': 'Erkek Kardeş, Kardeş', // [cite: 7]
    'Brown': 'Karartmak, Kahverengi, Kızarmak', // [cite: 7]
    'Build': 'Bina Etmek, İnşa Etmek', // [cite: 7]
    'Building': 'Yapma, Bina, İnşaat', // [cite: 7]
    'Bus': 'Otobüsle Gitmek, Otobüs, Otobüsle Taşımak', // [cite: 7]
    'Business': 'İş Kuruluşu, İşletme, İş', // [cite: 7]
    'Busy': 'İşlek, Faal, Meşgul', // [cite: 7]
    'But': 'Ancak, Fakat, İtiraz', // [cite: 7]
    'Butter': 'Yağ Sürmek, Tereyağı, Tereyağı Sürmek', // [cite: 7]
    'Buy': 'Almak, Satın Almak, Ismarlamak', // [cite: 7]
    'By': 'Geçecek Biçimde, Yakın, Evde', // [cite: 7]
    'Bye': 'Hoşçakal', // [cite: 7]
    'Cafe': 'Kafe', // [cite: 7]
    'Cake': 'Kek, Pasta', // [cite: 7]
    'Call': 'Telefon Etmek, Telefon Açmak, Çağırmak', // [cite: 7]
    'Camera': 'Fotoğraf Makinesi, Kamera', // [cite: 7]
    'Can': 'Konservelemek, Olabilmek', // [cite: 7]
    'Cannot': 'Edememek', // [cite: 7]
    'Capital': 'Sermaye, Kapital', // [cite: 7]
    'Car': 'Otomobil, Kabin', // [cite: 7]
    'Card': 'Fişlemek, Kart', // [cite: 7]
    'Career': 'Kariyer, Son Hızda Gitmek', // [cite: 7]
    'Carrot': 'Kızıl, Ödül/Teşvik', // [cite: 7]
    'Carry': 'Elde Etmek, Taşımak', // [cite: 7]
    'Cat': 'Kedi', // [cite: 7]
    'CD': 'Compact Disk', // [cite: 7]
    'Cent': 'Sent, Metelik', // [cite: 7]
    'Centre': 'Merkezde Toplanmak, Konsantre Olmak', // [cite: 7]
    'Century': 'Yüzyıl, Asır', // [cite: 7]
    'Chair': 'Sandalye, İskemle', // [cite: 7]
    'Change': 'Değiştirmek, Değişmek, Değişiklik', // [cite: 7]
    'Chart': 'Haritaya Almak, Göstermek, Çizelge', // [cite: 7]
    'Cheap': 'Değersiz, Ucuz, Ucuzlatmak', // [cite: 7]
    'Check': 'Kontrol, Denetlemek, Kontrol Etmek', // [cite: 7]
    'Cheese': 'Peynir Kalıbı, Peynir, Meyve Konservesi', // [cite: 7]
    'Chicken': 'Korkak Davranmak, Tavuk, Piliç', // [cite: 7]
    'Child': 'Ürün, Evlat, Çocuk', // [cite: 7]
    'Chocolate':
        'Çikolata, Çikolatalı Şekerleme, Çikolatadan Yapılmış', // [cite: 7]
    'Choose': 'Ayırmak, Seçmek', // [cite: 7]
    'Cinema': 'Sinema Salonu, Sinema', // [cite: 7]
    'City': 'Şehir, Metropol, Kent', // [cite: 7]
    'Class': 'Saymak, Sınıf, Ders', // [cite: 7]
    'Classroom': 'Derslik, Dershane, Sınıf', // [cite: 7]
    'Clean': 'Temizlenmek, Temiz, Temizlemek', // [cite: 9]
    'Climb': 'Çıkmak, Tırmanış, Tırmanmak', // [cite: 9]
    'Clock': 'Ölçmek, Saat, Saat Tutmak', // [cite: 9]
    'Close': 'Kapamak, Kapatmak, Yakın', // [cite: 9]
    'Clothes': 'Giysi, Esvap, Elbise', // [cite: 9]
    'Club': 'Sopa İle Dövmek, Kulüp, Ortakça Yatırmak', // [cite: 9]
    'Coat': 'Kaplamak, Kaban, Mont', // [cite: 9]
    'Coffee': 'Kıraathane, Kahve, Kahvehane', // [cite: 9]
    'Cold': 'Soğukkanlı, Soğukluk, Soğuk', // [cite: 9]
    'College': 'Yüksekokul, Üniversite, Kolej', // [cite: 9]
    'Colour': 'Renk, Yüzü Kızarmak, Boya', // [cite: 9]
    'Come': 'Gelip Dayanmak, Gelmek', // [cite: 9]
    'Common': 'Yaygın, Alelade, Alışılmış', // [cite: 9]
    'Company': 'Bölük, Şirket, Firma', // [cite: 9]
    'Compare': 'Mukayese Etmek, Kıyaslamak, Karşılaştırmak', // [cite: 9]
    'Complete': 'Bütün, Tam, Tamamlamak', // [cite: 9]
    'Computer': 'Kompüter, Elektronik Beyin, Bilgisayar', // [cite: 9]
    'Concert': 'Konser, Anlaşmak, Birlikte Hareket Etmek', // [cite: 9]
    'Conversation': 'Muhabbet, Konuşma, Sohbet', // [cite: 9]
    'Cook': 'Aşçı, Yemek Pişirmek, Pişirmek', // [cite: 9]
    'Cooking': 'Mutfak, Yemek Pişirme, Pişim', // [cite: 9]
    'Cool': 'Soğutmak, Serinlik, Serin', // [cite: 9]
    'Correct': 'Düzeltmek, Doğru, Haddini Bildirmek', // [cite: 9]
    'Cost': 'Masraf, Mal, Ücret', // [cite: 9]
    'Could': 'Olmak, -Ebilirdi, -Abilirdi', // [cite: 9]
    'Country': 'Memleket, Ülke, Yurt', // [cite: 9]
    'Course': 'Kurs, İzlenen Yol, Rota', // [cite: 9]
    'Cousin': 'Teyze Oğlu/Kızı, Amca Oğlu, Kuzen', // [cite: 9]
    'Cow': 'İnek, Korkutmak, Posta Koymak', // [cite: 9]
    'Cream': 'Kaymak, Krema, Krem', // [cite: 9]
    'Create': 'Meydana Getirmek, Oluşturmak, Yaratmak', // [cite: 9]
    'Culture': 'Kültür, Terbiye', // [cite: 9]
    'Cup': 'Kupa, Fincan, Kavramak', // [cite: 9]
    'Customer': 'Müşteri, Alıcı, Tip', // [cite: 9]
    'Cut': 'Kesmek, Pay, Kesik', // [cite: 9]
    'Dad': 'Babacığım, Babacık, Baba', // [cite: 9]
    'Dance': 'Sıçramak, Dans Etmek, Dans', // [cite: 9]
    'Dancer': 'Dansçı, Rakkase, Dansöz', // [cite: 9]
    'Dancing': 'Dans, Oynama, Dans Etme', // [cite: 9]
    'Dangerous': 'Tehlikeli, Riskli, Çekinceli', // [cite: 9]
    'Dark': 'Koyu, Karanlık, Belirsizlik', // [cite: 9]
    'Date': 'Randevuya Çıkmak, Zaman, (Biriyle) Çıkmak', // [cite: 9]
    'Daughter': 'Kız Evlat, Kız Çocuk', // [cite: 9]
    'Day': 'Dönem, Gündüz, Gün', // [cite: 9]
    'Dear': 'Tatlı Kimse, Sevgili, Canım', // [cite: 9]
    'December': 'Aralık (Ayı), Aralık Ayı', // [cite: 9]
    'Decide': 'Karar Vermek, Belirlemek, Azmetmek', // [cite: 9]
    'Delicious': 'Lezzetli, Nefis, Leziz', // [cite: 9]
    'Describe': 'Tarif Etmek, Tanımlamak, Betimlemek', // [cite: 9]
    'Description': 'Tasvir, Betimleme, Tarif', // [cite: 11]
    'Design': 'Dizayn Etmek, Tasarlamak, Tasarım', // [cite: 11]
    'Desk': 'Çalışma Masası, Okul Sırası, Kürsü', // [cite: 11]
    'Detail': 'Detay, Ayrıntı, Ayrıntılı Anlatmak', // [cite: 11]
    'Dialogue': 'Diyalog, Karşılıklı Konuşma, Konuşma', // [cite: 11]
    'Dictionary': 'Sözlük, Ansiklopedik Sözlük, Kamus', // [cite: 11]
    'Die': 'Ölmek, Çenesi Atmak, Kandilin Yağı Tükenmek', // [cite: 11]
    'Diet': 'Diyet, Perhiz, Perhiz Vermek', // [cite: 11]
    'Difference': 'Ayrım, Fark, Dava', // [cite: 11]
    'Different': 'Farklı, Değişik, Başka', // [cite: 11]
    'Difficult': 'Çetin, Zor, Zorlu', // [cite: 11]
    'Dinner': 'Akşam Yemeği, Yemek, Günün Esas Yemeği', // [cite: 11]
    'Dirty': 'Pisletmek, Pis, Kirli', // [cite: 11]
    'Discuss': 'Görüşmek, Tartışmak, Müzakere Etmek', // [cite: 11]
    'Dish': 'Tabak, Mahvetmek, Oymak', // [cite: 11]
    'Do': 'Etmek, Yapmak', // [cite: 11]
    'Doctor':
        'Doktor, Değiştirmek (Kötü Bir Amaçla), Tahrif Etmek', // [cite: 11]
    'Dog': 'İt, Köpek, Bozulmak', // [cite: 11]
    'Dollar': 'Amerikan Parası, Dolar', // [cite: 11]
    'Door': 'Kapı, Eşik', // [cite: 11]
    'Down': 'Aşağıya Doğru, Aşağı, Alaşağı Etmek', // [cite: 11]
    'Downstairs': 'Aşağı Katta, Altkat, Alt Kat', // [cite: 11]
    'Draw': 'Karalamak, Çekmek, Çizmek', // [cite: 11]
    'Dress': 'Giyinmek, Giymek, Giysi', // [cite: 11]
    'Drink': 'İçmek, İçki', // [cite: 11]
    'Drive': 'Sürmek, Araba Sürmek, Dürtü', // [cite: 11]
    'Driver': 'Sürücü, Makinist', // [cite: 11]
    'During': 'Zarfında, Sırasında', // [cite: 11]
    'DVD': 'Dvd', // [cite: 11]
    'Each': 'Her Biri, Beher', // [cite: 11]
    'Ear': 'Kulak, Başaklanmak', // [cite: 11]
    'Early': 'Erken, İlkel', // [cite: 11]
    'East': 'Doğu, Doğudaki Bölüm, Gündoğusu', // [cite: 11]
    'Easy': 'Rahat, Kolay, Basit', // [cite: 11]
    'Eat': 'Yemek Yemek, Yemek', // [cite: 11]
    'Egg': 'Yumurta, Teşvik Etmek, Tahrik Etmek', // [cite: 11]
    'Eight': 'Sekiz, Ambar, Sekiz Rakamı', // [cite: 11]
    'Eighteen': 'Onsekiz, Onsekiz Sayısı, On Sekiz', // [cite: 11]
    'Eighty': 'Seksen, Seksen Sayısı, 80', // [cite: 11]
    'Elephant': 'Fil', // [cite: 11]
    'Eleven': 'Onbir, On Bir Sayısı, On Bir', // [cite: 11]
    'Else': 'Başka, Başka Türlü, Daha', // [cite: 11]
    'Email': 'Email Göndermek, Eposta, Elektronik Posta', // [cite: 11]
    'End': 'Sona Ermek, Son Vermek, Son Bulmak', // [cite: 11]
    'Enjoy': 'Tadını Çıkarmak, Zevk Almak, Anlamak', // [cite: 11]
    'Enough': 'Kafi, Yeterli, Yeter', // [cite: 11]
    'Euro': 'Euro, Avro', // [cite: 11]
    'Even': 'Düzgün, Düz, Pürüzsüz', // [cite: 11]
    'Evening': 'Akşam, Son Evreler', // [cite: 11]
    'Event': 'Olay, Aksiyon, Yarışma', // [cite: 11]
    'Ever': 'Durmadan, Her Zaman, Daima', // [cite: 11]
    'Every': 'Bütün, Her, Alışılmış',
    'Everybody': 'Dost Düşman, Cümle Alem, Herkes',
    'Everyone': 'Herkes, Elalem',
    'Everything': 'Her Şey',
    'Exam': 'Muayene, Sınav, İmtihan',
    'Example': 'Numune, Örnek, İbret',
    'Excited': 'Hararetli, Coşkulu, Heyecanlı',
    'Exciting': 'Heyecanlı, Heyecan Verici, Heyecanlandırma',
    'Exercise': 'Egzersiz, Alıştırma Yapmak',
    'Expensive': 'Pahalı, Pahalıya Mal Olan, Masraflı',
    'Explain': 'İzah Etmek, Açıklamak',
    'Extra': 'Ekstra, İlave Gazete, İlave',
    'Eye': 'Göz, Dikkatle Bakmak, Süzmek',
    'Face': 'Yüzleşmek, Yüz Yüze Gelmek, Yönelmek, Gerçek Durum, Vak\'a, Vaka',
    'Fact': 'Gerçek Durum, Vak\'a, Vaka',
    'Fall': 'Düşmek, İnmek, Güz',
    'False': 'Takma Düzmece, Sahte',
    'Family': 'Aile, Hamile, Sülale',
    'Famous': 'Ünlü, Meşhur',
    'Fantastic': 'Fantastik, Harika, Şahane',
    'Far': 'Çok Fazla, Öteki, Uzak',
    'Farm': 'Ekmek, Ekip Biçmek, Çiftlik',
    'Farmer': 'Çiftlik Sahibi, Rençper, Çiftçi',
    'Fast': 'Hızlı, Çabuk, Süratli',
    'Fat': 'Yağ, Şişmanlatmak, Semirtmek',
    'Father': 'Peder, Papaz, Baba',
    'Favourite': 'Gözde, Favori',
    'February': 'Yılın İkinci Ayı, Şubat, Gücük Ay',
    'Feel': 'Sezmek, Hissetmek',
    'Feeling': 'Şefkat, Duygu, His',
    'Festival': 'Şenlik, Festival, Bayram',
    'Few': 'Az, Birkaç, Az Miktar',
    'Fifteen': 'On Beş, On Beş Sayısı, Onbeş',
    'Fifth': 'Beşte Bir, Beşi, Beşinci',
    'Fifty': '50, Elli',
    'Fill': 'Kaplamak, Şişirmek, Zar Vb Kaplamak',
    'Film': 'Filme Almak, Film',
    'Final': 'Nihai, Kesin, Final',
    'Find': 'Rastlamak, Bulmak',
    'Fine': 'Ceza Kesmek, Para Cezası, Hoş',
    'Finish': 'Sona Ermek, Bitirmek, Bitmek',
    'Fire': 'Ateşlemek, Kovmak, Yangın',
    'First': 'İlk, Önce, Birinci',
    'Fish': 'Balığa Çıkmak, Balık, Avlamak',
    'Five': 'İskambilde Beşli, Beş, Beş Rakamı',
    'Flat': 'Yassı, Daire, Düz Yüzey',
    'Flight': 'Yağmur, Uçmak, Uçuş',
    'Floor': 'Kat, Yeri Kaplamak, Yer',
    'Flower': 'Çiçeklenmek, Gelişmek, Çiçek',
    'Fly': 'Uçmak, Sinek',
    'Follow': 'Kollamak, İzlemek, Takip Etmek',
    'Food': 'Besin, Yiyecek, Gıda',
    'Foot': 'Ayak, Hesaplamak',
    'Football': 'Futbol, Futbol Topu, Amerikan Futbolu',
    'For': 'İçin, Yönünden, Zarfında',
    'Forget': 'Unutmak, İhmal Etmek',
    'Form': 'Biçimlendirmek, Şekillendirmek, Oluşturmak',
    'Forty': 'Kırk Sayısı, 40, Kırk',
    'Four': 'Dört, Kare, Dört Rakamı',
    'Fourteen': 'On Dört Sayısı',
    'Fourth': 'Dörtte Bir, Dördüncü',
    'Free': 'Bağımsız, Muaf, Beleş',
    'Friday': 'Cuma, Cuma Günü',
    'Friend': 'Ahbap, Dost, Arkadaş',
    'Friendly': 'Arkadaş Canlısı, Cana Yakın, Arkadaşça',
    'From': 'İtibaren, Beri, -Den',
    'Front': 'Yönelmek, Cephe, Ön',
    'Fruit': 'Meyve Vermek, Meyve, Meyvelenmek',
    'Full': 'Tok, Dolu, Tam',
    'Fun': 'Eğlence, Şaka Yapmak, Eğlenme',
    'Funny': 'Komik, Gırgır, Güldürücü',
    'Future': 'İstikbal, Gelecek, Gelecek Zaman',
    'Game': 'Oyun, Kumar Oynamak, Maç',
    'Garden': 'Bahçe, Çiçeklerle Uğraşmak, Bahçede Çalışmak',
    'Geography': 'Coğrafya',
    'Get': 'Elde Etmek, Almak, Kazanmak',
    'Girl': 'Kız, Kız Çocuğu',
    'Girlfriend': 'Kız Arkadaş, Manita, Flört',
    'Give': 'Vermek, Bahşetmek',
    'Glass': 'Kadeh, Bardak, Cam',
    'Go': 'Hareket Etmek, Gitmek',
    'Good': 'Güzel, Hayırlı, İyi',
    'Goodbye': 'Güle Güle, Hoşçakal, Elveda',
    'Grandfather': 'Dede, Büyükbaba, Cet',
    'Grandmother': 'Babaanne, Anneanne, Nine',
    'Grandparent': 'Büyükbaba, Büyük Ebeveyn',
    'Great': 'Mükemmel, Müthiş, Harika',
    'Green': 'Yeşil, Yeşermek, Yeşile Boyamak',
    'Grey': 'Ağartmak, Ağarmak, Gri',
    'Group': 'Grup, Gruplandırmak, Toplanmak',
    'Grow': 'Yetişmek, Büyümek',
    'Guess': 'Tahmin, Sanmak, Tahmin Etmek',
    'Guitar': 'Kitara, Gitar, Gitarist',
    'Gym': 'Spor Salonu, Jimnastik, Beden Eğitimi',
    'Hair': 'Tüy, Kıl, Saç',
    'Half': 'Yarım, Yarı, Devre',
    'Hand': 'El, Yakalamak, Uzatmak',
    'Happen': 'Meydana Gelmek, Olmak, Başından Geçmek',
    'Happy': 'Sevinçli, Mutlu, Çakırkeyif',
    'Hard': 'Çetin, Sert, Zahmetli',
    'Hat': 'Şapka, Başlık',
    'Hate': 'Nefret Etmek, Nefret, Kin Beslemek',
    'Have': 'Sahip Olmak, Elinde Tutmak',
    'Have to': 'Mecburiyetinde Kalmak, Gerekmek, Mecbur Olmak',
    'He': 'O, Eril O, Kendileri',
    'Head': 'Baş, Kafa, Kelle',
    'Health': 'Sağlık, Afiyet, Sıhhat',
    'Healthy': 'Sağlığa Yararlı, Sağlıklı, Sıhhatli',
    'Hear': 'İşitmek, Duymak',
    'Hello': 'Merhaba, Selam',
    'Help': 'Yardım, Yardım Etmek, Muavenet Etmek',
    'Her': 'Dişil Onu, Ondan, Ona',
    'Here': 'Burada, Buraya, Burda',
    'Hey': 'Selam, Merhaba, Merhabalar',
    'Hi': 'Öfkelenmek, Direnmek, Selam',
    'High': 'Yüksek',
    'Him': 'Onu, Ona',
    'His': 'Onunki, Onun, Eril Onunki',
    'History': 'Tarih, Geçmiş, Kayıtlar',
    'Hobby': 'Şahin, Merak, Hobi',
    'Holiday': 'Tatil Yapmak, Tatil, Bayram',
    'Home': 'Yuvasına Dönmek, Ev, Kendi Evine Almak',
    'Homework': 'Ödev, Ev Ödevi',
    'Hope': 'Umut Etmek, Ümit Etmek, Ummak',
    'Horse': 'Oynamak, At, Beygir',
    'Hospital': 'Darüşşifa, Hastane, Darülaceze',
    'Hot': 'Ateşli, Acı, Kızgın',
    'Hotel': 'Otel',
    'Hour': 'Vakit, Saat, Zaman',
    'House': 'Konut, Ev',
    'How': 'Yapma Yöntemi, Nasıl, Yapma Tarzı',
    'However': 'Birlikte, Yine De, Her Nasılsa, Bununla',
    'Hundred': 'Yüzlük, Yüz Sayısı, Yüz',
    'Hungry': 'Aç, İstekli, Acıkmış',
    'Husband': 'Eş, Koca',
    'I':
        'İngiliz Alfabesinin Dokuzuncu Harfi, Ben, Romen Rakamları Dizisinde 1 Sayısı',
    'Internet': 'Ağlararası Ağ, İnternet, Sanaldalyan',
    'Ice': 'Öldürmek, Buzda Soğutmak, Buz',
    'Ice cream': 'Dondurma',
    'Idea': 'Sanı, Fikir, Düşünce',
    'If': 'Eğer, Şart, Belirsizlik',
    'Imagine': 'Kafasında Canlandırmak, Hayal Etmek, Sanmak',
    'Important': 'Önemli, Gururlu, Mühim',
    'Improve': 'Gelişmek, İlerletmek, Geliştirmek',
    'In': 'İçeri, İçinde, İç',
    'Include': 'Kapsamak, Katmak, İçermek',
    'Information': 'İlmi Vukuf, Bilgi, İddia',
    'Interest': 'İlgilendirmek, Faiz, Çıkar',
    'Interested': 'İlgili, Alakalı, Hissedar',
    'Interesting': 'İlgi Çekici, İlgilenme, İlginç',
    'Interview': 'Görüşmek, Görüşme, Mülakat',
    'Into': 'İçine, Şekline, Biçimine',
    'Introduce': 'Tanıtmak, Tanıştırmak, İçeri Sokmak',
    'Island': 'Ada, Adacık',
    'It': 'Ebe, Ona, İlişki',
    'Its': '-İn, Onun',
    'Jacket': 'Zarf, Ceket, Kaplamak',
    'January': 'Ocak, Ocak Ayı',
    'Jeans': 'Kot, Blucin, Kot Pantolon',
    'Job': 'Görev, Kiraya Vermek, İş',
    'Join': 'Birleştirmek, Katmak, Katılmak',
    'Journey': 'Yolculuk, Seyahat, Yolculuk Etmek',
    'Juice': 'Meyve Suyu, Benzin, Özsu',
    'July': 'Temmuz Ayı, Temmuz, Yılın Yedinci Ayı',
    'June': 'Haziran, Haziran Ayı, Yılın Altıncı Ayı',
    'Just': 'Sadece, Adil, Yalnızca',
    'Keep': 'Tutmak, Saklamak',
    'Key': 'Anahtar, Tuş, Girmek',
    'Kilometre': 'Kilometre, Bin Metre',
    'Kind': 'Cins, Çeşit, Tür',
    'Kitchen': 'Mutfak, Nevale, Kuzine',
    'Know': 'Tanımak, Bilmek',
    'Land': 'Ayak Basmak, Kıyıya Çıkmak, Karaya Çıkmak',
    'Language': 'Dil, Lisan, Edebiyat',
    'Large': 'Geniş, Büyük, İri',
    'Last': 'Son, Sonuncu, Tutunmak',
    'Late': 'Geç, Gecikmiş, Her Zamanki',
    'Later': 'Sonra, Sonraki, Sonradan',
    'Laugh': 'Gülüş, Gülmek',
    'Learn': 'İşitmek, Öğrenmek',
    'Leave': 'Ayrılmak, Terk Etmek, Bırakmak',
    'Left': 'Sol Kanat, Sol',
    'Leg': 'Bacak, Ayak, Koşmak',
    'Lesson': 'Azar, Ders, Hisse',
    'Let': 'Vermek, İzin Vermek',
    'Letter': 'Harf, Basmak, Mektup',
    'Library': 'Kütüphane, Kitaplık, Kütüphane Binası',
    'Lie': 'Uzanmak, Yatmak, Yalan Söylemek',
    'Life': 'Hayat, Yaşam, Can',
    'Light': 'Işık, Aydınlık, Nur',
    'Like': 'Beğenmek, Sevmek, Hoşlanmak',
    'Line': 'Astarlamak, Satır, Hat',
    'Lion': 'Başarılı Ve Aranan Kimse, Aslan, Arslan',
    'List': 'Kaydetmek, Listelemek, Liste',
    'Listen': 'Kulak Asmak, Dinlemek, Dinlenmek',
    'Little': 'Ufak, Az, Küçük',
    'Live': 'Yaşamak, Naklen, İkamet Etmek',
    'Local': 'Yerel, Lokal, Yerli',
    'Long': 'Hasretini Çekmek, Susamak, Uzun',
    'Look': 'Bakmak, Görünüş, Bakış',
    'Lose': 'Kaybetmek, Yitirmek',
    'Lot': 'Bölüştürmek, Pay, Taksim Etmek',
    'Love': 'Sevmek, Sevda, Aşk',
    'Lunch': 'Öğle Yemeği Yemek, Öğle Yemeği, Tümsek',
    'Machine': 'Makine İle Yapmak Veya Şekil Vermek, Makine, Makine İle Yapmak',
    'Magazine': 'Fişek Haznesi, Dergi, Mecmua',
    'Main': 'Ana, Esas, Baş',
    'Make': 'Yapmak, Katetmek',
    'Man': 'Adam, İnsan, Erkek',
    'Many': 'Birçok, Çok, Çoğu',
    'Map': 'Planlamak, Harita, Saptamak',
    'March': 'Yürüyüş Yapmak, Yürüyüş, Mart Ayı',
    'Market': 'Çarşı, Pazar, Piyasa',
    'Married': 'Evli, Evliliğe Özgü, Başı Bağlı',
    'Match': 'Eşleştirmek, Eşlemek, Eş',
    'May': 'Mayıs, Mayıs Ayı, Mümkün Olmak',
    'Maybe': 'Belki, Belki De',
    'Me': 'Ben, Beni',
    'Meal': 'Yemek, Öğün, Sofra',
    'Mean': 'Demek İstemek, Kastetmek, Anlamına Gelmek',
    'Meaning': 'Mana, Meal, Anlam',
    'Meat': 'Yenecek Et, Et, Öz',
    'Meet': 'Karşılaşmak, Buluşmak, Görüşme Yapmak',
    'Meeting': 'Buluşma, Toplantı, Miting',
    'Member': 'Organ, Üye, Mensup',
    'Menu': 'Mönü, Menü, Restoranda Mevcut Yiyecek Listesi',
    'Message': 'İleti, Resmi Bildiri',
    'Metre': 'Metre, Vezin',
    'Midnight': 'Geceyarısı',
    'Mile': 'Mil Uzaklık Ölçü Birimi, Mil, Faydalanmak',
    'Milk': 'Süt, Süt Vermek',
    'Million': 'Milyon',
    'Minute': 'Zabıt Tutmak, Dakika, Tutanak Tutmak',
    'Miss': 'Iska, Özlemek, Kaçırmak',
    'Mistake': 'Hata, Yanılgı, Yanlış',
    'Model': 'Manken, Modellik Etmek',
    'Modern': 'Modern, Modern Kimse',
    'Moment': 'Önem, Cevher',
    'Monday': 'Pazartesi',
    'Money': 'Para, Para Kırmak',
    'Month': 'Ay, Yılın On İki Bölümünden Her Biri',
    'More': 'Daha, Daha Fazla, Fazla Şey',
    'Morning': 'Sabah Vakti, Sabah, Başlama',
    'Most': 'En Çok, En, En Fazlası',
    'Mother': 'Anne, Ana, Anne Gibi Davranmak',
    'Mountain': 'Yığın, Dağ, Cebel',
    'Mouse': 'Fare Avlamak, Fare, Fare Tutmak',
    'Mouth': 'Tane Tane Söylemek, Ağız, Dudaklarını Oynatarak Konuşmak',
    'Move': 'Kımıldamak, Kıpırdamak, Hareket Etmek',
    'Movie': 'Film, Sinema',
    'Much': 'Çok, Fazla, Çok Şey',
    'Mum': 'Maske İle Oynamak, Kasımpatı, Hanımefendi',
    'Museum': 'Müze',
    'Music': 'Müzik, Ahenk, Nağme',
    'Must': '-Malı, Gerekmek, -Meli',
    'My': 'Benim, Bana Ait',
    'Name': 'Ad, İsim, İsmiyle Çağırmak',
    'Natural': 'Tabii, Doğuştan, Natürel',
    'Near': 'Yakın, Yakınlaşmak, Yaklaşmak',
    'Need': 'İhtiyaç Duymak, Gerek, Gereksinim',
    'Negative': 'Negatif, Olumsuz, Etkisiz Hale Getirmek',
    'Neighbour': 'Komşu, Komşu Olmak, Yaklaşmak',
    'Never': 'Hiç, Asla, Katiyen',
    'New': 'Yeni, Keşfedilmemiş, Değişik',
    'News': 'Haber, Havadis, Bilgi',
    'Newspaper': 'Gazete',
    'Next': 'Sonraki, Bundan Sonraki, En Bitişik',
    'Next to': 'Bitişik, Yanında, Hemen Yanındaki',
    'Nice': 'Güzel, Sevimli, Hoş',
    'Night': 'Tün, Gece, Karanlık',
    'Nine': 'Dokuz, Dokuzu, 9',
    'Nineteen': 'On Dokuz, On Dokuz Sayısı',
    'Ninety': 'Doksan Sayısı, Doksan, 90',
    'No': 'Hayır, Aleyhte Oy, Red',
    'No one': 'Hiç Kimse, Önemsiz Biri, Bir Hiç',
    'Nobody': 'Hiç Kimse',
    'North': 'Kuzey, Kuzeye Bakan',
    'Nose': 'Burun, Yavaş İlerlemek',
    'Not': 'Gayri, Asla',
    'Note': 'Not Etmek, Nota',
    'Nothing': 'Hiç, Önemsiz Şey',
    'November': 'Kasım, Teşrin-i Sani',
    'Now': 'Şimdi, Halen, Derhal',
    'Number': 'Numaralamak, Saymak, Sayı',
    'Nurse': 'Hemşirelik Yapmak, Meme Vermek, Bakıcılık Yapmak',
    'Object': 'İtiraz Etmek, Razı Olmamak, Karşı Çıkmak',
    'O\'clock': 'Saat, Saate Göre',
    'October': 'Ekim, Teşrin-i Evvel',
    'Of': 'Karşı, Olan, Hakkında',
    'Off': 'Kapalı, Dışında, Kalkmak',
    'Office': 'Ofis, Makam, Büro',
    'Often': 'Sık Sık, Çoğu Kez, Sık',
    'Oh': 'Ey, Ha',
    'OK': 'Onaylamak, Okeylemek, Kabul Etmek',
    'Old': 'Yaşlı, Eskimiş, Eski',
    'On': 'Üstünde, Üzerinde, Yanmak',
    'Once': 'Bir Kere, Bir Kez, Birkez',
    'One': 'Bir, Tek, Biri',
    'Onion': 'Soğan, Soğancık, Kuru Soğan',
    'Online': 'Bağlantılı, Online Olarak, Çevrim İçi',
    'Only': 'Sırf, Tek, Yalnızca',
    'Open': 'Açılmak, Açmak, Açık',
    'Opinion': 'Kanaat, Kanı, Düşünce',
    'Opposite': 'Zıt, Aksi, Karşıt',
    'Or': 'Ya Da, Veya, Altın Sarısı',
    'Orange': 'Portakal, Portakal Rengi, Portakalrengi',
    'Order': 'Sipariş Vermek, Emretmek, Buyurmak',
    'Other': 'Öbür, Öteki, Başka',
    'Our': 'Bizim',
    'Out': 'Çıkış, Dışarıda, Dışarı',
    'Outside': 'Dıştan, Dışarı, Dışarısı',
    'Over': 'Bitmiş, Üzerine, Üstüne',
    'Own': 'Sahip Olmak, Kendi, İtiraf Etmek',
    'Page': 'Sayfa, Otelde Birini Komiyle Çağırttırmak, Sayfaları Numaralamak',
    'Paint': 'Boyamak, Boya, Portresini Yapmak',
    'Painting': 'Tablo, Resim, Ressamlık',
    'Pair': 'Çift, Eşleştirmek, Eşlemek',
    'Paper': 'Kağıt, Duvar Kağıdı Kaplamak, Örtbas Etmek',
    'Paragraph': 'Fıkra, Paragraf, Makale',
    'Parent': 'Ebeveynlik Etmek, Ata, Soy',
    'Park': 'Park Etmek, Park, Park Yapmak',
    'Part': 'Parça, Kısım, Taraf',
    'Partner': 'Eş, Ortak, Ortak Etmek',
    'Party': 'Taraf, Parti, Kutlamak',
    'Passport': 'Geçiş Belgesi, Pasaport',
    'Past': 'Geçmiş, Geçmiş Zaman, Bir Kimsenin Geçmişi',
    'Pay': 'Ödemek, Ödeme, Ücret',
    'Pen': 'Kalem, Hapsetmek, Kaleme Almak',
    'Pencil': 'Kalem, Kurşunkalem, Kurşunkalemle Çizmek',
    'People': 'İnsanlar, Ulus, Halk',
    'Pepper': 'Biber, Üzerine Biber Ekmek, Pul Biber Koymak',
    'Perfect': 'Kusursuz, Mükemmel, Mükemmelleştirmek',
    'Period': 'Devir, Dönem, Çağ',
    'Person': 'Kişi, Şahıs, Kimse',
    'Personal': 'Kişisel, Özel, Şahsi',
    'Phone': 'Telefon Etmek, Telefon Açmak, Telefonlamak',
    'Photo': 'Foto, Fotoğraflamak, Resim Vermek',
    'Photograph': 'Fotoğraflamak, Fotoğrafını Çekmek, Resim Vermek',
    'Phrase': 'İfade Etmek, Cümleyle Anlatmak',
    'Piano': 'Piyano Çalgı, Piyano, Hafif',
    'Picture': 'Resim, Yansıtmak, Resmetmek',
    'Piece': 'Tane, Parça, Yamamak',
    'Pig': 'Domuz, Pislik İçinde Yaşamak, Yavrulamak',
    'Pink': 'Pembe, Delmek, Süngü İle Delmek',
    'Place': 'Koymak, Oturtmak, Yerleştirmek',
    'Plan': 'Planlamak, Tasarlamak, Plan',
    'Plane': 'Düzlemek, Düz Yüzey, Düzlem',
    'Plant': 'Dikmek, Ekmek, Tesis',
    'Play': 'Oynamak, Çalmak, Piyes',
    'Player': 'Oyuncu, Çalgıcı, Sporcu',
    'Please': 'Memnun Etmek, Lütfen, Gönlünü Hoş Etmek',
    'Point': 'Nokta, Puan, Uç',
    'Police': 'Polis, İnzibat Altına Almak, Güvenliği Sağlamak',
    'Policeman': 'Polis, Zabıta Memuru, Polis Memuru',
    'Pool': 'Havuz, Toplamak, Karı Paylaşmak',
    'Poor': 'Kötü, Fakir, Zavallı',
    'Popular': 'Popüler, Halkın Kesesine Elverişli, Halka Hitap Eden',
    'Positive': 'Pozitif, Artı, Olumlu',
    'Possible': 'Olabilir, Olanaklı, Muhtemel',
    'Post': 'Postalamak, Makam, Direk',
    'Potato': 'Patates, Baş, Kafa',
    'Pound': 'Yumruklamak, Çakmak, Dalgaya Çarpmak',
    'Practice': 'Uygulamak, Alıştırma Yapmak, Yapmak',
    'Practise': 'Pratik Yapmak, Alıştırma Yapmak, Etmek',
    'Prefer': 'Tercih Etmek, Yeğlemek, Yeğ Tutmak',
    'Prepare': 'Hazırlamak, Düzmek, Pişirmek',
    'Present': 'Sunmak, Takdim Etmek, Şimdiki Zaman',
    'Pretty': 'Şirin, Tatlı, Güzel',
    'Price': 'Bedel, Fiyat, Ücret',
    'Probably': 'Galiba, Muhtemelen, Muhtemel Olarak',
    'Problem': 'Problem, Mesele, Sorun',
    'Product': 'Ürün, Mahsul, Meyve',
    'Programme': 'Program, Programlamak, Planlamak',
    'Project': 'Proje, İz Düşürmek, Planını Çizmek',
    'Purple': 'Mor, Mora Boyamak, Erguvan Rengi',
    'Put': 'Koymak, Hamletmek',
    'Quarter': 'Çeyrek, Yerleştirmek',
    'Question': 'Soru, Sorular Sormak, Sorgulamak',
    'Quick': 'Süratli, Hızlı, Çabuk',
    'Quickly': 'Hızla, Aceleyle, Süratle',
    'Quiet': 'Sessizlik, Sakin, Sessiz',
    'Quite': 'Epeyce, Pek, Epey',
    'Radio': 'Radyo, Telsiz, Telsizle Haber Vermek',
    'Rain': 'Yağmur, Yağmur Gibi Yağdırmak',
    'Read': 'Okumak, Çözmek',
    'Reader': 'Okur, Okuyucu, Eleştirmen',
    'Reading': 'Okuma, Mana, Yorum',
    'Ready': 'Hazır, Hazırlamak, Peşin Para',
    'Real': 'Hakiki, Gerçek, Taşınmaz',
    'Really': 'Hakikaten, Gerçekten, Cidden',
    'Reason': 'Sebep, Akıl, Gerekçe',
    'Red': 'Al, Kızıl, Kırmızı',
    'Relax': 'Rahatlamak, Rahatlatmak, Dinlenmek',
    'Remember': 'Hatırlamak, Anımsamak, Anmak',
    'Repeat': 'Yinelemek, Tekrarlamak, Tekerrür Etmek',
    'Report': 'Haber Vermek, Rapor Etmek, İhbar Etmek',
    'Restaurant': 'Restoran, Lokanta, Doyumevi',
    'Shopping': 'Çarşı Pazar Dolaşma, Çarşıya Çıkma, Alışveriş',
    'Result': 'Sonuç, Sonucu Olmak, Netice',
    'Return': 'Geri Dönmek, Dönmek, İade Etmek',
    'Rice': 'Çeltik, Pirinç, Pilav',
    'Rich': 'Zengin, Varsıl, Bol Bol',
    'Ride': 'Binmek, Gezinti',
    'Right': 'Haklı, Hak, Sağ',
    'River': 'Akış, Nehir',
    'Road': 'Yöntem, İlke, Yol',
    'Room': 'Oda, Oturmak, Kalmak',
    'Routine': 'Adet, Rutin, Hergünkü İşler',
    'Rule': 'Hüküm Sürmek, Hükmetmek, Kural',
    'Run': 'Koşmak, Çalıştırmak, İşletmek',
    'Sad': 'Hüzünlü, Üzücü, Mahzun',
    'Salad': 'Salata',
    'Salt': 'Tuzlayarak Saklamak, Tuz, Biriktirmek',
    'Same': 'Eşit, Farksız, Aynı',
    'Sandwich': 'Sıkıştırmak, Arasına Sıkıştırmak, Sandviç',
    'Saturday': 'Cumartesi',
    'Say': 'Söylemek, Demek',
    'School': 'Okul, Yetiştirmek, Mektep',
    'Science': 'İlim, Bilim, Beceri',
    'Scientist': 'Bilim Adamı, Bilim İnsanı, Bilgin',
    'Sea': 'Deniz, Okyanus, Dalga',
    'Second': 'Saniye, İkinci, Destek',
    'Section': 'Bölüm, Kesit, Kısım',
    'See': 'Bakmak, Görmek',
    'Sell': 'Satılmak',
    'Send': 'Yollamak',
    'Sentence': 'Cümle, Hüküm Giydirmek, Mahkum Etmek',
    'September': 'Eylül',
    'Seven': '7, Yedi Rakamı, Yedi',
    'Seventeen': 'XVII, On Yedi Sayısı, On Yedi',
    'Seventy': 'LXX, Yetmiş, Yetmiş Sayısı',
    'Share': 'Hisse, Paylaşmak, Pay',
    'She': 'Hayvan, Kadın, Dişi',
    'Sheep': 'Dişi, Koyun Gibi Tip, Ezik Kimse',
    'Shirt': 'Mintan, Gömlek',
    'Shoe': 'Pabuç, Ayakkabı',
    'Shop': 'Ele Vermek, Mağaza, Dükkan',
    'Short': 'Az, Kısa, Alçak',
    'Should': '-Malı, Gerekmek, -Meli',
    'Show': 'Gösteri, Göstermek',
    'Shower': 'Duş, Sağanak, Duş Almak',
    'Sick': 'Yakalatmak, Hasta, Kusmak',
    'Similar': 'Eş, Benzeş, Benzer',
    'Sing': 'Ötmek, Söylemek, Şarkı Söylemek',
    'Singer': 'Hanende, Şair, Şarkıcı',
    'Sister': 'Kardeş, Abla, Kız Kardeş',
    'Sit': 'Tünemek, Oturmak',
    'Situation': 'Hal, Durum, Ekmek Kapısı',
    'Six': 'Şeş, Altı Rakamı, Altı',
    'Sixteen': 'Onaltı, XVI, On Altı Sayısı',
    'Sixty': 'Altmış, LX, Altmış Sayısı',
    'Skill': 'Maharet, Beceri, Hüner',
    'Skirt': 'Etek, Kenarından Geçmek, Uzak Durmak',
    'Sleep': 'Uyumak, Uyku',
    'Slow': 'Yavaşlatmak, Yavaş, Ağır',
    'Small': 'Az, Küçük, Ufak',
    'Snake': 'Yılan, Yılan Gibi Gitmek, Kıvrılmak',
    'Snow': 'Kar, Yağmak, Kaplamak',
    'So': 'Bu Yüzden, Öyle, Böyle',
    'Some': 'Biraz, Bazı, Birkaç',
    'Somebody': 'Biri, Birisi, Şahsiyet',
    'Someone': 'Birisi, Kimse, Bir',
    'Something': 'Bir Şey, Falan',
    'Sometimes': 'Bazen, Ara Sıra, Ara Sıra',
    'Son': 'Oğul, Evlat, Mahdum',
    'Song': 'Şarkı, Şakıma, Güfte',
    'Soon': 'Birazdan, Sonra',
    'Sorry': 'Üzgün, Esef Etmek, Eseflenmek',
    'Sound': 'Ses, Derine Dalmak, Ses Çıkarmak',
    'Soup': 'Çorba, Nitrogliserin, Yoğun Sis',
    'South': 'Güney, Cenup, Lodos',
    'Space': 'Aralık, Açıklık, Mekan',
    'Speak': 'Konuşmak, Söylemek',
    'Special': 'Özel, Kısa Süre İçinde',
    'Spell': 'Hecelemek, Büyü',
    'Spelling': 'Yazım, Yazılış, İmla',
    'Spend': 'Geçirmek, Harcamak',
    'Sport': 'Spor, Şaka Söylemek, Oynamak',
    'Spring': 'Memba, İlkbahar, Bahar',
    'Stand': 'Geçerli Olmak, Katlanmak, Ayakta Durmak',
    'Star': 'Yıldız, Yıldızlarla Süslemek, Başrolde Oynatmak',
    'Start': 'Başlamak, Başlatmak, Başlangıç',
    'Statement': 'İfade, Söz, Beyan',
    'Station': 'Terminal, İstasyon, Görevlendirmek',
    'Stay': 'Kalmak, Kalma Süresi, Kalma',
    'Still': 'Durgun, Hareketsiz, Hala',
    'Stop': 'Durmak, Durdurmak, Dinmek',
    'Story': 'Hikaye, Anlatı, Tarih',
    'Street': 'Cadde, Sokak, Mahalle',
    'Strong': 'Güçlü, Kuvvetli, Domuz Gibi',
    'Student': 'Öğrenci, Talebe, Mektepli',
    'Study': 'İncelemek, Çalışmak, Çalışma',
    'Style': 'Biçim, Tarz, Biçem',
    'Subject': 'Ders, Özne, Konu',
    'Success': 'Muvaffakiyet, Başarı, Başarılmış İş',
    'Sugar': 'Şeker, Kompliman Yapmak, Şeker Katmak',
    'Summer': 'Yaz, Yazı Geçirmek, Hayatın Baharı',
    'Sun': 'Güneş, Güneşte Bırakmak, Güneşlenmek',
    'Sunday': 'Pazar, Pazar Günü, Bayramlık',
    'Supermarket': 'Süpermarket, Market',
    'Sure': 'Emin, Elbette, Soruşturmak',
    'Sweater': 'Süveter, Hırka, Sömüren İşveren',
    'Swim': 'Yüzmek, Yüzme',
    'Swimming': 'Yüzme, Yüzücülük, Yüzme Sporu',
    'Table': 'Masa, Tablo, Sofra',
    'Take': 'Almak, Çekmek, Götürmek',
    'Talk': 'Konuşmak, Sohbet, Konuşma',
    'Tall': 'Uzun, Yüksek, Uzun Boylu',
    'Taxi': 'Taksi, Taksiyle Gitmek, Taksiyle Götürmek',
    'Tea': 'Çay, Çeşitli Bitkilerin Demlenmesi',
    'Teach': 'Ders Vermek, Öğretmek',
    'Teacher': 'Öğretmen, Hoca',
    'Team': 'Takım, Ekip, Takım Halinde Yapmak',
    'Teenager': 'On Üç İle On Dokuz Yaşlar Arası, Delikanlı, Yeniyetme',
    'Telephone': 'Telefon, Telefon Etmek, Telefon Açmak',
    'Television': 'Televizyon',
    'Tell': 'Haber Vermek, Söylemek, Anlatmak',
    'Ten': 'On, Onluk, Onlu',
    'Tennis': 'Tenis, Alantopu',
    'Terrible': 'Müthiş, Berbat, Korkunç',
    'Test': 'Sınamak, Deneme, Test',
    'Text': 'Metin, Mesaj Atmak, Parça',
    'Than': '-Den, Hariç, -Mektense',
    'Thank': 'Teşekkür Etmek, Teşekkür',
    'Thanks': 'Teşekkür, Teşekkürler, Sağ Ol',
    'That': 'Şu, O, O Kadar',
    'The':
        'Belirli Durumlarda İsimden Önce Kullanılır, Nitelemek İçin Kullanılır',
    'Theatre': 'Tiyatro, Amfi, Alan',
    'Their': 'Onların',
    'Them': 'Onlara, Onları',
    'Then': 'O Zamanlar, O Zamanki, O Zamanın',
    'There': 'Oraya, Orada, Ora',
    'They': 'Onlar, Kendileri',
    'Thing': 'Şey, Nesne, Olay',
    'Think': 'Sanmak, Düşünmek',
    'Third': 'Üçte Bir, Üçüncü, Üçüncü Olarak',
    'Thirsty': 'Susuz, Susamış, Kurak',
    'Thirteen': 'On Üç Sayısı, Onüç, On Üç',
    'Thirty': 'Otuz Sayısı, Otuz, 30',
    'This': 'Bu, Böylesine, Bu Kadar',
    'Thousand': 'Bin, Bin Sayısı, Binlik',
    'Three': 'İskambilde Üçlü, Üç Rakamı, Üç',
    'Through': 'Başından Sonuna Kadar, Yoluyla, Üzerinden',
    'Thursday': 'Perşembe',
    'Ticket': 'Bilet, Etiket Koymak, Etiketlemek',
    'Time': 'Kez, Kere, Müddet',
    'Tired': 'Argın, Yorgun, Yorgun Düşmüş',
    'Title': 'Unvan, Başlık, İsimlendirmek',
    'To': 'Karşı, -Mek/-Mak, Kadar',
    'Today': 'Bugün, Şimdi, Bu Günlerde',
    'Together': 'Birlikte, Beraber, Kuyruk',
    'Toilet': 'Hela, Tuvalet, Makyaj',
    'Tomato': 'Domates',
    'Tomorrow': 'Yarın',
    'Tonight': 'Akşama, Bu Akşam, Bu Gece',
    'Too': 'Gereğinden Çok, Çok, Aşırı',
    'Tooth': 'Diş, Dişle Kaplamak, Dişlemek',
    'Topic': 'Konu, Bahis',
    'Tourist': 'Turist, Seyyah',
    'Town': 'Şehir, Kasaba, Şehir Merkezi',
    'Traffic': 'Gidiş Geliş, Trafik, İş Yapmak',
    'Train': 'Eğitim Vermek, Eğitmek, Tren',
    'Travel': 'Gezmek, Seyahat Etmek, Yolculuk Etmek',
    'Tree': 'Ağaç, Ağaca Çıkarmak',
    'Trip': 'Seyahat, Yolculuk',
    'Trousers': 'Pantolon',
    'True': 'Hakiki, Gerçek, Doğru',
    'Try': 'Denemek, Deneme, Yoklamak',
    'T-shirt': 'Tişört, Yarım Kollu Fanila',
    'Tuesday': 'Salı',
    'Turn': 'Dönmek, Çevirmek, Döndürmek',
    'TV': 'Televizyon',
    'Twelve': 'Oniki, On İki Sayısı, On İki',
    'Twenty': 'Yirmi, Yirmi Sayısı, 20',
    'Twice': 'İki Kez, İki Sefer, Kere',
    'Two': 'İki, İskambilde İkili, İki Rakamı',
    'Type': 'Yazmak, Tür, Tip',
    'Umbrella': 'Şemsiye, Şemsiyelik, Koruyucu',
    'Uncle': 'Dayı, Amca, Enişte',
    'Under': 'Altında, Alt, Az',
    'Understand': 'Anlayış Göstermek, Anlamak',
    'University': 'Üniversite, Bilimyurt',
    'Until': 'İla, Değin, Dek',
    'Up': 'Yukarı, Yükseltmek, Artırmak',
    'Upstairs': 'Üst Kat, Yukarı Kat',
    'Us': 'Biz, Abd, Bizi',
    'Use': 'Kullanmak, Kullanım, Kullanma',
    'Useful': 'Faydalı, Yararlı, Kullanışlı',
    'Usually': 'Genellikle, Çoğunlukla, Çoğu Zaman',
    'Vacation': 'Tatil, Tatil Yapmak, İzin',
    'Vegetable': 'Sebze, Bitkisel, Göveri',
    'Very': 'Çok, Hatta, Bile',
    'Video': 'Video Terminal, Ekran, Video Filmi',
    'Village': 'Köy, Köy Halkı, Küçük Kalıcı Yerleşim Birimi',
    'Visit': 'Ziyaret Etmek, Ziyaret, Gezmek',
    'Visitor': 'Ziyaretçi, Ziyarete Giden Kimse, Zair',
    'Wait': 'Beklemek, Bekleyiş, Bekleme',
    'Waiter': 'Garson, Erkek Garson',
    'Wake': 'Canlanmak, Uyanmak',
    'Walk': 'Dolaşmak, Yürümek, Yürüyerek Gitmek',
    'Wall': 'Duvar, Tecrit Etmek, Ayırmak',
    'Want': 'İstek, İstemek, İsteklenmek',
    'Warm': 'Isınmak, Isıtmak, Ilık',
    'Wash': 'Yıkanmak, Aşındırmak, Yıkamak',
    'Watch': 'Seyretmek, Gözlemek',
    'Water': 'Sulamak, Su, Islatmak',
    'Way': 'Yol, Taraf, Tarz',
    'We': 'Biz',
    'Wear': 'Giymek, Takmak, Aşındırmak',
    'Weather': 'Hava, Hava Durumu, Yalpalamak',
    'Website': 'İnternet Sitesi, Ağ Sitesi',
    'Wednesday': 'Çarşamba',
    'Week': 'Hafta, Yedi Günlük Süre',
    'Weekend': 'Hafta Sonunu Geçirmek, Hafta Sonu, Haftasonu',
    'Welcome': 'Hoş Geldiniz, Hoş Karşılamak',
    'Well': 'Kuyu, Fışkırmak, İyi',
    'West': 'Batı, Batıdaki, Batıya Doğru',
    'What': 'Ne, Neyi, Hangi',
    'When': 'Ne Zaman, Zaman, Ne Vakit',
    'Where': 'Nereye, Nerede, Nere',
    'Which': 'Hangi, Kaçıncı',
    'White': 'Beyaz, Ak, Solgun',
    'Who': 'Kim, Kimi, Kime',
    'Why': 'Niçin, Neden, Niye',
    'Wife': 'Hanım, Kocanın Eşi, Karı',
    'Will': 'Vasiyet, İrade, Dilemek',
    'Win': 'Kazanmak, Galip Gelmek, Zafer',
    'Window': 'Pencere, Camekan, Vitrin',
    'Wine': 'Şarap Sunmak, Şarap, Şarap Rengi',
    'Winter': 'Kışlık, Kış, Kışlamak',
    'With': '-Lı, İle, Beraberinde',
    'Without': 'Dıştan, Dış, Dışarıda',
    'Woman': 'Kadın, Hanım',
    'Wonderful': 'Harikulade, Harika',
    'Word': 'Laf, Söz, Sözcük',
    'Work': 'Çalışmak, İşe Yaramak, İş Yapmak',
    'Worker': 'Adam, İşçi, Amele',
    'World': 'Dünya, Alem, Evren',
    'Would': 'İstemek, -Ecekti, -Cekti',
    'Write': 'Yazmak, Kaydetmek',
    'Writer': 'Yazar, Müellif, Muharrir',
    'Writing': 'Yazma, Yazım, Yazı',
    'Wrong': 'Yanlış, Gadretmek, Haksızlık Etmek',
    'Yeah': 'Tamam, He, Evet',
    'Year': 'Yıl, Sene, İhtiyarlık',
    'Yellow': 'Sarı, Sararmak, Sarartmak',
    'Yes': 'Evet, Olumlu Cevap, Olumlu Oy',
    'Yesterday': 'Dün',
    'You': 'Siz, Sen, Seni',
    'Young': 'Genç, Hayvan Yavrusu, Döl',
    'Your': 'Senin, Sizin',
    'Yourself': 'Kendiniz, Kendin, Kendini',
  };

  return sozluk.entries
      .map((entry) => Kelime(ingilizce: entry.key, turkce: entry.value))
      .toList();
}
