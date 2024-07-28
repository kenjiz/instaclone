import 'package:powersync_repository/powersync_repository.dart';
import 'package:repository/repository.dart';

/// User base repository.
abstract class UserBaseRepository {
  /// The id of the currently authenticated user.
  String? get currentUserId;

  /// Broadcasts the user profile identified by [id].
  Stream<User> profile({required String id});

  /// Updates currently authenticated database user's metadata.
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? username,
    String? avatarUrl,
    String? pushToken,
  });
}

/// {@template client}
/// Represents a client that interacts with various repositories.
///
/// ### Example usage:
/// ```dart
/// final powerSyncRepository = PowerSyncRepository();
/// final client = PowerSyncDatabaseClient(powerSyncRepository);
///
/// client.createPost(
///   id: 'post123',
///   userId: 'user123',
///   caption: 'Hello, world!',
///   media: 'https://example.com/image.jpg',
/// );
/// ```
/// {@endtemplate}
abstract class DatabaseClient implements UserBaseRepository {
  /// {@macro database_client}
  const DatabaseClient();
}

/// {@template power_sync_database_client}
/// A class representing a PowerSyncDatabaseClient.
///
/// It allows users to perform various operations such as creating posts,
/// retrieving posts, liking posts, following users, and more.
/// {@endtemplate}
class PowerSyncDatabaseClient extends DatabaseClient {
  /// {@macro power_sync_database_client}
  PowerSyncDatabaseClient({required PowerSyncRepository powerSyncRepository})
      : _powerSyncRepository = powerSyncRepository;

  final PowerSyncRepository _powerSyncRepository;

  @override
  String? get currentUserId => _powerSyncRepository.supabase.auth.currentSession?.user.id;

  @override
  Stream<User> profile({required String id}) => _powerSyncRepository.db().watch(
        'SELECT * FROM profiles WHERE id = ?',
        parameters: [id],
      ).map(
        (event) => event.isEmpty ? User.anonymous : User.fromJson(event.first),
      );

  @override
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? username,
    String? avatarUrl,
    String? pushToken,
    String? password,
  }) =>
      _powerSyncRepository.updateUser(
        email: email,
        password: password,
        data: {
          if (fullName != null) 'full_name': fullName,
          if (username != null) 'username': username,
          if (avatarUrl != null) 'avatar_url': avatarUrl,
          if (pushToken != null) 'push_token': pushToken,
        },
      );
}
