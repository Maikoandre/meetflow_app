import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/event_list_viewmodel.dart';
import 'views/login_view.dart';
import 'views/event_list_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final storageService = StorageService();
  final apiService = ApiService(storageService);
  
  // Check if user is already logged in
  final username = await storageService.getUsername();
  final password = await storageService.getPassword();
  final isLoggedIn = username != null && password != null;

  runApp(MyApp(
    storageService: storageService,
    apiService: apiService,
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;
  final ApiService apiService;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.storageService,
    required this.apiService,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(apiService, storageService),
        ),
        ChangeNotifierProvider(
          create: (_) => EventListViewModel(apiService),
        ),
      ],
      child: MaterialApp(
        title: 'MeetFlow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn ? const EventListView() : const LoginView(),
      ),
    );
  }
}
