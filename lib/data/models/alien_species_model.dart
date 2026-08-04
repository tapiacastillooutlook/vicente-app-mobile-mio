import '../../domain/models/species_entity.dart';

/// Modelo de datos estático para el Códex. (Por ahora sin backend complejo para especies).
class AlienSpeciesModel extends SpeciesEntity {
  const AlienSpeciesModel({
    required super.id,
    required super.name,
    required super.origin,
    required super.faction,
    required super.primaryFrequency,
    required super.description,
    required super.capabilities,
    required super.imageUrl,
  });

  static List<AlienSpeciesModel> get staticCodex {
    return const [
      AlienSpeciesModel(
        id: 'pleiadian_01',
        name: 'Lumínicos (Pleyadianos)',
        origin: 'Pléyades / Múltiples Dimensiones',
        faction: 'La Alianza de la Luz',
        primaryFrequency: 'Armonía / Aguda',
        description: 'Seres de luz y energía aethérica pura. Buscan restaurar la vibración armónica del universo. Operan en densidades superiores a la 3D y se comunican telepáticamente o mediante frecuencias de sonido armónico. Sus naves suelen presentarse como esferas de plasma o luz bioluminiscente.',
        capabilities: 'Manipulación de gravedad local, sanación vibracional, desmaterialización, comunicación telepática, tecnología de cristal-silicio.',
        imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=1000&auto=format&fit=crop', // Abstract light image
      ),
      AlienSpeciesModel(
        id: 'reptilian_01',
        name: 'Arcanos-Sáuridos (Reptilianos)',
        origin: 'Alpha Draconis / Mundo Anillo',
        faction: 'La Hegemonía Oscura',
        primaryFrequency: 'Ultra-Baja',
        description: 'Antigua civilización de orden biotecnológico extremo (hueso cultivado, músculo y metal). Construyen "Torres de Supresión" para congelar la vibración del entorno y alimentarse de las frecuencias bajas (miedo, densidad). Sus vehículos suelen ser oscuros, de geometría pesada o platillos clásicos metálicos.',
        capabilities: 'Control mental de baja frecuencia, bio-ingeniería avanzada, camuflaje óptico, dominación jerárquica.',
        imageUrl: 'https://images.unsplash.com/photo-1614730321146-b6fa6a46bcb4?q=80&w=1000&auto=format&fit=crop', // Abstract dark alien/sci-fi image
      ),
    ];
  }
}
