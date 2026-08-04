import '../../core/services/supabase_service.dart';
import '../models/sighting_model.dart';
import '../../domain/models/sighting_entity.dart';

class SightingsRepository {
  final SupabaseService _supabaseService;

  SightingsRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService();

  /// Retrieve all sightings ordered by latest first
  Future<List<SightingEntity>> getSightings() async {
    try {
      final data = await _supabaseService.client
          .from('sightings')
          .select()
          .order('created_at', ascending: false);
      
      return (data as List).map((json) => SightingModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Add a new sighting
  Future<SightingEntity> addSighting(SightingModel sighting) async {
    try {
      final user = _supabaseService.currentUser;
      if (user == null) throw Exception('Usuario no autenticado');

      final data = await _supabaseService.client
          .from('sightings')
          .insert(sighting.toJson()..['user_id'] = user.id)
          .select()
          .single();
          
      return SightingModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Realtime stream for sightings
  Stream<List<SightingEntity>> getSightingsStream() {
    return _supabaseService.client
        .from('sightings')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .map((data) => data.map((json) => SightingModel.fromJson(json)).toList());
  }
}
