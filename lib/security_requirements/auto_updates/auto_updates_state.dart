import 'auto_updates_changer.dart';

class AutoUpdatesState {
  static int privateSUpdates = -1;

  Future<void> futureIntToInt() async {
    AutoUpdatesState.privateSUpdates = await AutoUpdates().getAutoUpdatesKey();
  }
}