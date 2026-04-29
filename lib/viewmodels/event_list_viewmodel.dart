import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/api_service.dart';

class EventListViewModel extends ChangeNotifier {
  final ApiService _apiService;

  List<Event> _events = [];
  bool _isLoading = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasNextPage = true;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasNextPage => _hasNextPage;

  EventListViewModel(this._apiService);

  Future<void> fetchEvents({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _events = [];
      _hasNextPage = true;
    }

    if (!_hasNextPage || _isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.get('eventos/', queryParameters: {'page': _currentPage});
      
      if (response.statusCode == 200) {
        final data = response.data;
        final List results = data['results'];
        
        _events.addAll(results.map((e) => Event.fromJson(e)).toList());
        _currentPage++;
        _hasNextPage = data['next'] != null;
      } else {
        _errorMessage = 'Failed to load events';
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
