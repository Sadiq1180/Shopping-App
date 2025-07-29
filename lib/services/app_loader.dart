
import 'package:loader_overlay/loader_overlay.dart';

import '../shared/shared.dart';

class AppLoader {
  static void show() {
   appContext.loaderOverlay.show();
  }

  static void hide() {
     appContext.loaderOverlay.hide();
  }
}   