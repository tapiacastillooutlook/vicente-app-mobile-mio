import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

/// Singleton service wrapping Supabase client access and initialization.
class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  SupabaseService._internal();

  /// Initialize Supabase client. Must be called before `runApp`.
  static Future<void> initialize() async {
    // Avoid re-initialization if already initialized or if credentials are set
    if (SupabaseConstants.supabaseUrl != 'YOUR_SUPABASE_URL') {
      await Supabase.initialize(
        url: SupabaseConstants.supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: SupabaseConstants.supabaseAnonKey,
      );
    }
  }

  /// Get current Supabase Client instance
  SupabaseClient get client => Supabase.instance.client;

  /// Quick accessor for Current User
  User? get currentUser => client.auth.currentUser;

  /// Stream of Auth State changes
  Stream<AuthState> get authStateChanges => client.auth.onAuthStateChange;
}
