import 'package:flutter_test/flutter_test.dart';
import 'package:meetflow_app/main.dart';
import 'package:meetflow_app/services/api_service.dart';
import 'package:meetflow_app/services/storage_service.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    final storageService = StorageService();
    final apiService = ApiService(storageService);
    
    await tester.pumpWidget(MyApp(
      storageService: storageService,
      apiService: apiService,
      isLoggedIn: false,
    ));

    expect(find.text('MeetFlow Login'), findsOneWidget);
  });
}
