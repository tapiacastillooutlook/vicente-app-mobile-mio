import 'package:flutter/material.dart';
import 'dart:async';

class ScannerViewModel extends ChangeNotifier {
  double _currentFrequency = 0.5; // 0.0 a 1.0 (0% - 100%)
  double get currentFrequency => _currentFrequency;

  bool _isScanning = false;
  bool get isScanning => _isScanning;

  String get currentFrequencyType {
    if (_currentFrequency < 0.33) return 'Ultra-Baja';
    if (_currentFrequency < 0.66) return 'Armonía';
    return 'Aguda';
  }

  Color get currentColor {
    if (_currentFrequency < 0.33) return const Color(0xFFE11D48); // Reptilian Red
    if (_currentFrequency < 0.66) return const Color(0xFF00E5FF); // Lumínicos Cyan
    return const Color(0xFF8B5CF6); // High pitch Purple
  }

  double _animationValue = 0.0;
  double get animationValue => _animationValue;

  Timer? _timer;

  void setFrequency(double value) {
    _currentFrequency = value;
    notifyListeners();
  }

  void toggleScan() {
    _isScanning = !_isScanning;
    if (_isScanning) {
      _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
        _animationValue += 0.02 * (1.0 + _currentFrequency * 2); 
        if (_animationValue > 1.0) _animationValue -= 1.0;
        notifyListeners();
      });
    } else {
      _timer?.cancel();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
