import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/scanner_view_model.dart';
import '../../../core/widgets/frequency_wave_painter.dart';
import '../../../core/widgets/glass_card.dart';

class FrequencyScannerView extends StatelessWidget {
  const FrequencyScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScannerViewModel(),
      child: const _ScannerBody(),
    );
  }
}

class _ScannerBody extends StatelessWidget {
  const _ScannerBody();

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScannerViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('ESCÁNER DE RESONANCIA')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              GlassCard(
                borderColor: vm.currentColor,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FRECUENCIA: ${vm.currentFrequencyType.toUpperCase()}',
                      style: TextStyle(
                        color: vm.currentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: vm.isScanning
                          ? CustomPaint(
                              painter: FrequencyWavePainter(
                                animationValue: vm.animationValue,
                                waveColor: vm.currentColor,
                                waveCount: vm.currentFrequency < 0.33 ? 2 : vm.currentFrequency < 0.66 ? 4 : 6,
                              ),
                              size: const Size(double.infinity, 100),
                            )
                          : const Center(
                              child: Text(
                                'MODO ESPERA',
                                style: TextStyle(color: Colors.grey, letterSpacing: 4.0),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                'Ajustar Resonancia',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: vm.currentColor,
                  thumbColor: vm.currentColor,
                  overlayColor: vm.currentColor.withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: vm.currentFrequency,
                  onChanged: vm.setFrequency,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: vm.toggleScan,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: vm.currentColor, width: 3),
                    boxShadow: vm.isScanning
                        ? [BoxShadow(color: vm.currentColor.withValues(alpha: 0.5), blurRadius: 30, spreadRadius: 5)]
                        : [],
                  ),
                  child: Center(
                    child: Icon(
                      vm.isScanning ? Icons.stop : Icons.power_settings_new,
                      size: 40,
                      color: vm.currentColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                vm.isScanning ? 'ESCANEO ACTIVO...' : 'INICIAR ESCANEO',
                style: TextStyle(
                  color: vm.currentColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
