/// Supabase auth client implementation
// ignore_for_file: depend_on_referenced_packages

library;

export 'package:auth_client/auth_client.dart' hide AuthException;
export 'package:gotrue/gotrue.dart' show AuthException;

export 'src/supabase_auth_client.dart';
