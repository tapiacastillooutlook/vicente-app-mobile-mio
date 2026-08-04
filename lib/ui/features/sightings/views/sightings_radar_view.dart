import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/sightings_view_model.dart';
import 'add_sighting_dialog.dart';
import '../../../core/widgets/glass_card.dart';

class SightingsRadarView extends StatelessWidget {
  const SightingsRadarView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SightingsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('RADAR DE AVISTAMIENTOS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => ChangeNotifierProvider.value(
                  value: vm,
                  child: const AddSightingDialog(),
                ),
              );
            },
          )
        ],
      ),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : vm.sightings.isEmpty
              ? const Center(child: Text('No hay ecos detectados. Mantente alerta.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.sightings.length,
                  itemBuilder: (context, index) {
                    final sighting = vm.sightings[index];
                    final isPleiadian = sighting.frequencyType == 'Armonía' || sighting.frequencyType == 'Aguda';
                    final cardColor = isPleiadian ? const Color(0xFF00E5FF) : const Color(0xFFE11D48);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GlassCard(
                        borderColor: cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isPleiadian ? Icons.brightness_high : Icons.warning_amber,
                                      color: cardColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      sighting.objectType,
                                      style: TextStyle(
                                        color: cardColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  sighting.frequencyType,
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sighting.title,
                              style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(sighting.locationName, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              sighting.description,
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
