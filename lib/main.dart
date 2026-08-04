import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/supabase_service.dart';
import 'core/theme/app_theme.dart';
import 'ui/features/auth/view_models/auth_view_model.dart';
import 'ui/features/auth/views/login_view.dart';
import 'ui/features/home/views/home_view.dart';
import 'ui/features/sightings/view_models/sightings_view_model.dart';
import 'ui/features/codex/view_models/codex_view_model.dart';
import 'ui/features/scanner/view_models/scanner_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase Client
  await SupabaseService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => SightingsViewModel()),
        ChangeNotifierProvider(create: (_) => CodexViewModel()),
        ChangeNotifierProvider(create: (_) => ScannerViewModel()),
      ],
      child: MaterialApp(
        title: 'Clase App Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: Consumer<AuthViewModel>(
          builder: (context, authViewModel, _) {
            if (authViewModel.isAuthenticated) {
              return const HomeView();
            }
            return const LoginView();
          },
        ),
      ),
    );
  }
}
