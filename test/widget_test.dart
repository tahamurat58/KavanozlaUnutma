// Kavanoz'la Unutma - Temel widget testi
import 'package:flutter_test/flutter_test.dart';

import 'package:kavanozlaunutma/main.dart';

void main() {
  testWidgets('Uygulama açılış testi', (WidgetTester tester) async {
    // Uygulamayı oluştur
    await tester.pumpWidget(const KavanozApp());

    // Ana ekranın yüklendiğini doğrula
    expect(find.text("Kavanoz'la Unutma"), findsOneWidget);
  });
}
