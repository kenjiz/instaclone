import 'package:envied/envied.dart';

part 'env.staging.g.dart';

/// {@template env}
/// Staging environment variables.
/// Used to access environment variables.
/// {@endtemplate}
@Envied(path: '.env.staging', obfuscate: true)
abstract class EnvStaging {
  /// Supabase url secret
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String supabaseUrl = _EnvStaging.supabaseUrl;

  /// Supabase anon key secret
  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String supabaseAnonKey = _EnvStaging.supabaseAnonKey;

  /// Powersync url secret
  @EnviedField(varName: 'POWERSYNC_URL', obfuscate: true)
  static String powersyncUrl = _EnvStaging.powersyncUrl;

  /// IOS Client Id
  @EnviedField(varName: 'IOS_CLIENT_ID', obfuscate: true)
  static String iosClientId = _EnvStaging.iosClientId;

  /// Web Client Id
  @EnviedField(varName: 'WEB_CLIENT_ID', obfuscate: true)
  static String webClientId = _EnvStaging.webClientId;
}
