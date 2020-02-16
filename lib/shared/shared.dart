import 'package:Mafruka/modules/core/models/app_state.dart';
import 'package:redux/redux.dart';

class Shared {
  static String loginToken;
  static String deviceToken;
  static Store<AppState> globalStore;
}
