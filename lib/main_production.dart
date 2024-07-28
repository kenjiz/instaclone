import 'package:database_client/database_client.dart';
import 'package:env/env.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instaclone/app/app.dart';
import 'package:instaclone/app/di/di.dart';
import 'package:instaclone/bootstrap.dart';
import 'package:instaclone/firebase_options_prod.dart';
import 'package:repository/repository.dart';
import 'package:shared/shared.dart';
import 'package:supabase_auth_client/supabase_auth_client.dart';
import 'package:token_storage/token_storage.dart';

void main() {
  bootstrap(
    (powersyncRepository) {
      final tokenStorage = InMemoryTokenStorage();
      final iosClientId = getIt<AppFlavor>().getEnv(Env.iOSClientId);
      final webClientId = getIt<AppFlavor>().getEnv(Env.webClientId);
      final googleSignInId = GoogleSignIn(clientId: iosClientId, serverClientId: webClientId);

      final authClient = SupabaseAuthenticationClient(
        powerSyncRepository: powersyncRepository,
        tokenStorage: tokenStorage,
        googleSignIn: googleSignInId,
      );

      final databaseClient = PowerSyncDatabaseClient(powerSyncRepository: powersyncRepository);

      final userRepository = UserRepository(
        databaseClient: databaseClient,
        authClient: authClient,
      );

      return App(userRepository: userRepository);
    },
    options: DefaultFirebaseOptions.currentPlatform,
    flavor: AppFlavor.production(),
  );
}
