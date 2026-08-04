import '../../domain/models/sighting_entity.dart';

/// Modelo de datos para manejar Avistamientos con JSON de Supabase.
class SightingModel extends SightingEntity {
  const SightingModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.objectType,
    required super.frequencyType,
    required super.locationName,
    required super.description,
    required super.createdAt,
  });

  factory SightingModel.fromJson(Map<String, dynamic> json) {
    return SightingModel(
      id: json['id'] as String,
      userId: json['user_id'] as String? ?? '',
      title: json['title'] as String? ?? 'Desconocido',
      objectType: json['object_type'] as String? ?? 'No clasificado',
      frequencyType: json['frequency_type'] as String? ?? 'Desconocida',
      locationName: json['location_name'] as String? ?? 'Ubicación Desconocida',
      description: json['description'] as String? ?? '',
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'user_id': userId,
      'title': title,
      'object_type': objectType,
      'frequency_type': frequencyType,
      'location_name': locationName,
      'description': description,
    };
  }
}
