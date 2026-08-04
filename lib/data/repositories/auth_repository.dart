import '../../core/services/supabase_service.dart';
import '../../domain/models/user_entity.dart';

/// Repository handling authentication data access and transformations via Supabase.
class AuthRepository {
  final SupabaseService _supabaseService;

  AuthRepository({SupabaseService? supabaseService})
      : _supabaseService = supabaseService ?? SupabaseService();

  /// Sign Up with Email and Password
  Future<UserEntity?> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    try {
      final response = await _supabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );

      final user = response.user;
      if (user == null) return null;

      return UserEntity(
        id: user.id,
        email: user.email ?? email,
        fullName: user.userMetadata?['full_name'] as String? ?? fullName,
        createdAt: DateTime.tryParse(user.createdAt),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Sign In with Email and Password
  Future<UserEntity?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseService.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) return null;

      return UserEntity(
        id: user.id,
        email: user.email ?? email,
        fullName: user.userMetadata?['full_name'] as String?,
        createdAt: DateTime.tryParse(user.createdAt),
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Sign Out current user
  Future<void> signOut() async {
    await _supabaseService.client.auth.signOut();
  }

  /// Get Current Logged In User Entity
  UserEntity? getCurrentUser() {
    final user = _supabaseService.currentUser;
    if (user == null) return null;
    return UserEntity(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String?,
      createdAt: DateTime.tryParse(user.createdAt),
    );
  }
}
