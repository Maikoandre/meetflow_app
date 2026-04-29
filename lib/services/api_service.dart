import 'dart:convert';
import 'package:dio/dio.dart';
import 'storage_service.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  final StorageService _storageService;

  ApiService(this._storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Ensure base URL is up to date
          options.baseUrl = await _storageService.getBaseUrl();

          final username = await _storageService.getUsername();
          final password = await _storageService.getPassword();

          if (username != null && password != null) {
            final auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
            options.headers['Authorization'] = auth;
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }
}
