/// Entidad de dominio para un avistamiento OVNI o Eco.
class SightingEntity {
  final String id;
  final String userId;
  final String title;
  final String objectType;
  final String frequencyType;
  final String locationName;
  final String description;
  final DateTime createdAt;

  const SightingEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.objectType,
    required this.frequencyType,
    required this.locationName,
    required this.description,
    required this.createdAt,
  });
}
