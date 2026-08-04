import 'package:flutter/material.dart';
import '../../../../data/repositories/species_repository.dart';
import '../../../../domain/models/species_entity.dart';

class CodexViewModel extends ChangeNotifier {
  final SpeciesRepository _repository;

  CodexViewModel({SpeciesRepository? repository})
      : _repository = repository ?? SpeciesRepository() {
    loadSpecies();
  }

  List<SpeciesEntity> _species = [];
  List<SpeciesEntity> get species => _species;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadSpecies() async {
    _isLoading = true;
    notifyListeners();
    
    _species = await _repository.getAllSpecies();
    
    _isLoading = false;
    notifyListeners();
  }
}
