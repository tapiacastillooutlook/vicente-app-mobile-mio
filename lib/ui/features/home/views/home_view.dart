import 'package:flutter/material.dart';
import '../../sightings/views/sightings_radar_view.dart';
import '../../scanner/views/frequency_scanner_view.dart';
import '../../codex/views/codex_detail_view.dart';
import '../../nexo/views/nexo_profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SightingsRadarView(),
    const FrequencyScannerView(),
    const CodexDetailView(),
    const NexoProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.radar),
            label: 'Radar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.waves),
            label: 'Escáner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Códex',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hub),
            label: 'Nexo',
          ),
        ],
      ),
    );
  }
}
