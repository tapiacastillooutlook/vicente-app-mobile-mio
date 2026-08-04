import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../data/models/sighting_model.dart';
import '../../../../data/repositories/sightings_repository.dart';
import '../../../../domain/models/sighting_entity.dart';

class SightingsViewModel extends ChangeNotifier {
  final SightingsRepository _repository;
  StreamSubscription? _subscription;

  SightingsViewModel({SightingsRepository? repository})
      : _repository = repository ?? SightingsRepository() {
    _initRealtime();
  }

  List<SightingEntity> _sightings = [];
  List<SightingEntity> get sightings => _sightings;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void _initRealtime() {
    _isLoading = true;
    notifyListeners();
    _subscription = _repository.getSightingsStream().listen(
      (data) {
        _sightings = data;
        _isLoading = false;
        notifyListeners();
      },
      onError: (err) {
        _errorMessage = err.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> addSighting({
    required String title,
    required String objectType,
    required String frequencyType,
    required String locationName,
    required String description,
  }) async {
    try {
      final model = SightingModel(
        id: '', // Supabase generará el UUID
        userId: '', // El repository pondrá el user_id
        title: title,
        objectType: objectType,
        frequencyType: frequencyType,
        locationName: locationName,
        description: description,
        createdAt: DateTime.now(),
      );
      
      await _repository.addSighting(model);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
