import 'package:instaclone/app/app.dart';
import 'package:instaclone/bootstrap.dart';
import 'package:instaclone/firebase_options_prod.dart';
import 'package:shared/shared.dart';

void main() {
  bootstrap(
    (powersyncRepository) => const App(),
    options: DefaultFirebaseOptions.currentPlatform,
    flavor: AppFlavor.production(),
  );
}
