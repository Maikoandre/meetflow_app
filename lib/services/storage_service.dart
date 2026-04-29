import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';
  static const String _keyBaseUrl = 'base_url';

  Future<void> saveCredentials(String username, String password) async {
    await _storage.write(key: _keyUsername, value: username);
    await _storage.write(key: _keyPassword, value: password);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: _keyUsername);
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: _keyPassword);
  }

  Future<void> clearCredentials() async {
    await _storage.delete(key: _keyUsername);
    await _storage.delete(key: _keyPassword);
  }

  Future<void> saveBaseUrl(String baseUrl) async {
    await _storage.write(key: _keyBaseUrl, value: baseUrl);
  }

  Future<String> getBaseUrl() async {
    return await _storage.read(key: _keyBaseUrl) ?? 'http://10.0.2.2:8000/api/'; // Default for Android emulator
  }
}
