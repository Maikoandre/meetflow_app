import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService;
  final StorageService _storageService;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LoginViewModel(this._apiService, this._storageService);

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Save credentials temporarily
      await _storageService.saveCredentials(username, password);
      
      // Attempt to fetch users to verify credentials
      final response = await _apiService.get('users/');
      
      if (response.statusCode == 200) {
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid credentials';
        await _storageService.clearCredentials();
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Login failed. Please check your credentials and Base URL.';
      await _storageService.clearCredentials();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _storageService.clearCredentials();
    notifyListeners();
  }

  Future<void> updateBaseUrl(String baseUrl) async {
    await _storageService.saveBaseUrl(baseUrl);
    notifyListeners();
  }

  Future<String> getBaseUrl() async {
    return await _storageService.getBaseUrl();
  }
}
