import '../../domain/models/species_entity.dart';
import '../models/alien_species_model.dart';

class SpeciesRepository {
  /// Fetches all available species from the static codex
  Future<List<SpeciesEntity>> getAllSpecies() async {
    // Simular un pequeño retardo como si viniera de BD o red
    await Future.delayed(const Duration(milliseconds: 300));
    return AlienSpeciesModel.staticCodex;
  }
}
