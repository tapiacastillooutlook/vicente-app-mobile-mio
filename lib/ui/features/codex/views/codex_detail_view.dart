import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/codex_view_model.dart';
import '../../../core/widgets/glass_card.dart';

class CodexDetailView extends StatelessWidget {
  const CodexDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CodexViewModel(),
      child: const _CodexBody(),
    );
  }
}

class _CodexBody extends StatelessWidget {
  const _CodexBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CodexViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('CÓDEX DE ESPECIES')),
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.species.length,
              itemBuilder: (context, index) {
                final species = vm.species[index];
                final isPleiadian = species.id.contains('pleiadian');
                final accentColor = isPleiadian ? const Color(0xFF00E5FF) : const Color(0xFFE11D48);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: GlassCard(
                    borderColor: accentColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            species.imageUrl,
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 180,
                              color: Colors.black26,
                              child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          species.name.toUpperCase(),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: accentColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          species.faction,
                          style: const TextStyle(color: Colors.grey, letterSpacing: 1.1),
                        ),
                        const Divider(color: Colors.white24, height: 30),
                        _buildInfoRow('Origen:', species.origin, accentColor),
                        const SizedBox(height: 8),
                        _buildInfoRow('Resonancia:', species.primaryFrequency, accentColor),
                        const SizedBox(height: 16),
                        Text(
                          'Descripción',
                          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          species.description,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), height: 1.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Capacidades',
                          style: TextStyle(color: accentColor, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          species.capabilities,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), height: 1.4),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildInfoRow(String label, String value, Color accentColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
