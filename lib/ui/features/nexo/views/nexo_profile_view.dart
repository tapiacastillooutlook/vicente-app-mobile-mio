import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../auth/views/login_view.dart';
import '../../../core/widgets/glass_card.dart';

class NexoProfileView extends StatelessWidget {
  const NexoProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BASE EL NEXO'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.redAccent),
            tooltip: 'Cerrar Sesión',
            onPressed: () async {
              await authViewModel.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (route) => false,
                );
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GlassCard(
                borderColor: const Color(0xFF7C3AED), // Secondary Deep Purple
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF00E5FF), width: 2),
                        boxShadow: const [
                          BoxShadow(color: Color(0x3300E5FF), blurRadius: 10, spreadRadius: 2)
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (user?.fullName?.isNotEmpty ?? false)
                              ? user!.fullName![0].toUpperCase()
                              : 'L',
                          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.fullName ?? 'Lumínico Despertado',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user?.email ?? 'conexion@aethera.red',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Rango: Sintonizador',
                              style: TextStyle(color: Color(0xFF00E5FF), fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'ESTADO DE LOS MÓDULOS',
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
              const SizedBox(height: 16),
              _buildModule(
                'El Observatorio',
                'Radar OVNI activo. 100% operativo.',
                Icons.radar,
                const Color(0xFF00E5FF),
                true,
              ),
              const SizedBox(height: 16),
              _buildModule(
                'Jardín de Memorias',
                'Códex sincronizado. Base de datos alienígena conectada.',
                Icons.auto_stories,
                const Color(0xFF7C3AED),
                true,
              ),
              const SizedBox(height: 16),
              _buildModule(
                'Forja de Resonancia',
                'Armas sónicas en desarrollo. Energía insuficiente.',
                Icons.build,
                Colors.grey,
                false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModule(String title, String desc, IconData icon, Color color, bool isActive) {
    return GlassCard(
      borderColor: isActive ? color : Colors.white24,
      child: Row(
        children: [
          Icon(icon, size: 36, color: isActive ? color : Colors.grey),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(color: isActive ? Colors.white70 : Colors.white24, fontSize: 12),
                ),
              ],
            ),
          ),
          if (isActive)
            Icon(Icons.check_circle, color: color)
          else
            const Icon(Icons.lock, color: Colors.grey),
        ],
      ),
    );
  }
}
