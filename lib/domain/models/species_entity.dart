/// Entidad de dominio para una especie extraterrestre (Pleyadiana, Reptiliana).
class SpeciesEntity {
  final String id;
  final String name;
  final String origin;
  final String faction; // Lumínicos, Arcanos-Sáuridos
  final String primaryFrequency; // Ultra-Baja, Armonía, Aguda
  final String description;
  final String capabilities;
  final String imageUrl; // Placeholder o URL real

  const SpeciesEntity({
    required this.id,
    required this.name,
    required this.origin,
    required this.faction,
    required this.primaryFrequency,
    required this.description,
    required this.capabilities,
    required this.imageUrl,
  });
}
