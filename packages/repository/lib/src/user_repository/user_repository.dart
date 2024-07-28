import 'package:auth_client/auth_client.dart';
import 'package:database_client/database_client.dart';
import 'package:repository/repository.dart';
import 'package:repository/src/user_repository/models/models.dart';
import 'package:repository/src/user_repository/models/user.dart';

/// {@template user_repository}
/// A package that manages user flow.
/// {@endtemplate}
class UserRepository implements UserBaseRepository {
  /// {@macro user_repository}
  const UserRepository({
    required DatabaseClient databaseClient,
    required AuthClient authClient,
  })  : _databaseClient = databaseClient,
        _authClient = authClient;

  final DatabaseClient _databaseClient;
  final AuthClient _authClient;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Stream<User> get user =>
      _authClient.user.map((user) => User.fromAuthenticationUser(authUser: user)).asBroadcastStream();

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      await _authClient.logInWithGoogle();
    } on LogInWithGoogleFailure {
      rethrow;
    } on LogInWithGoogleCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithGoogleFailure(error), stackTrace);
    }
  }

  /// Starts the Sign In with Github Flow.
  ///
  /// Throws a [LogInWithGithubCanceled] if the flow is canceled by the user.
  /// Throws a [LogInWithGithubFailure] if an exception occurs.
  Future<void> logInWithGithub() async {
    try {
      await _authClient.logInWithGithub();
    } on LogInWithGithubFailure {
      rethrow;
    } on LogInWithGithubCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithGithubFailure(error), stackTrace);
    }
  }

  /// Signs out the current user which will emit
  /// [User.anonymous] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await _authClient.logOut();
    } on LogOutFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogOutFailure(error), stackTrace);
    }
  }

  /// Logins in with the provided [password].
  Future<void> logInWithPassword({
    required String password,
    String? email,
    String? phone,
  }) async {
    try {
      await _authClient.logInWithPassword(
        email: email,
        phone: phone,
        password: password,
      );
    } on LogInWithPasswordFailure {
      rethrow;
    } on LogInWithPasswordCanceled {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(LogInWithPasswordFailure(error), stackTrace);
    }
  }

  /// Sign up with the provided [password].
  Future<void> signUpWithPassword({
    required String password,
    required String fullName,
    required String username,
    String? avatarUrl,
    String? email,
    String? phone,
    String? pushToken,
  }) async {
    try {
      await _authClient.signUpWithPassword(
        email: email,
        phone: phone,
        password: password,
        fullName: fullName,
        username: username,
        avatarUrl: avatarUrl,
        pushToken: pushToken,
      );
    } on SignUpWithPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(SignUpWithPasswordFailure(error), stackTrace);
    }
  }

  /// Sends a password reset email to the provided [email].
  /// Optionally allows specifying a [redirectTo] url to redirect
  /// the user to after resetting their password.
  Future<void> sendPasswordResetEmail({
    required String email,
    String? redirectTo,
  }) async {
    try {
      await _authClient.sendPasswordResetEmail(
        email: email,
        redirectTo: redirectTo,
      );
    } on SendPasswordResetEmailFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(
        SendPasswordResetEmailFailure(error),
        stackTrace,
      );
    }
  }

  /// Resets the password for the user with the given [email]
  /// using the provided [token]. Updates the password to
  /// the new [newPassword].
  Future<void> resetPassword({
    required String token,
    required String email,
    required String newPassword,
  }) async {
    try {
      await _authClient.resetPassword(
        token: token,
        email: email,
        newPassword: newPassword,
      );
    } on ResetPasswordFailure {
      rethrow;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ResetPasswordFailure, stackTrace);
    }
  }

  @override
  String? get currentUserId => _databaseClient.currentUserId;

  @override
  Stream<User> profile({required String id}) => _databaseClient.profile(id: id);

  @override
  Future<void> updateUser({
    String? fullName,
    String? email,
    String? username,
    String? avatarUrl,
    String? pushToken,
  }) =>
      _databaseClient.updateUser(
        fullName: fullName,
        email: email,
        username: username,
        avatarUrl: avatarUrl,
        pushToken: pushToken,
      );
}
